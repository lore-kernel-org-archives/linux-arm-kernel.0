From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jul 2015 23:01:11 +0200
Subject: [PATCH 4/4] arm64: dts: Add Broadcom North Star 2 support
In-Reply-To: <1436837955-26279-5-git-send-email-rjui@broadcom.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
 <1436837955-26279-5-git-send-email-rjui@broadcom.com>
Message-ID: <2107639.2a3PGefz8c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 July 2015 18:39:15 Ray Jui wrote:

> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x66130000";
> +	};
> +

Please remove those bootargs and just set the stdout-path to the alias
of the uart. If necessary, you can have just "earlycon" in the bootargs.

	Arnd
