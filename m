From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 21:12:18 +0800
Subject: [PATCH 5/7] [v2] arm64: dts: add LS1046A-RDB board support
In-Reply-To: <1473069695-33092-6-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-6-git-send-email-shh.xie@gmail.com>
Message-ID: <20160908131218.GB16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 06:01:33PM +0800, shh.xie at gmail.com wrote:
> +&ifc {
> +	status = "okay";

For sake of consistency, please have 'status' at the end of property
list.

Shawn

> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	/* NAND Flashe and CPLD on board */
> +	ranges = <0x0 0x0 0x0 0x7e800000 0x00010000
> +		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
> +
> +	nand at 0,0 {
> +		compatible = "fsl,ifc-nand";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x10000>;
> +	};
> +
> +	cpld: board-control at 2,0 {
> +		compatible = "fsl,ls1046ardb-cpld";
> +		reg = <0x2 0x0 0x0000100>;
> +	};
> +};
