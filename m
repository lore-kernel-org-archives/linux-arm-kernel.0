From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Jan 2015 23:41:52 +0100
Subject: [PATCH v2 3/8] ARM: digicolor: add minimal device tree description
In-Reply-To: <9d8d7aed6220e9e92ab70217a65d3291924cfa71.1420744369.git.baruch@tkos.co.il>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <9d8d7aed6220e9e92ab70217a65d3291924cfa71.1420744369.git.baruch@tkos.co.il>
Message-ID: <20032538.pHVo39OjvN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 January 2015 21:39:59 Baruch Siach wrote:
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +};

Please don't put earlyprintk into the dtb. Hopefully by the next
merge window we will have working earlycon support as a replacement.
You can already put an stdout-path property into the chosen node
for this.

> +	interrupt-parent = <&intc>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};

Better move the aliases into the board specific file.

	Arnd
