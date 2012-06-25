From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 00:05:18 +0800
Subject: [PATCH v4] ARM: mx23: Add initial support for olinuxino board
In-Reply-To: <1340027512-8461-1-git-send-email-fabio.estevam@freescale.com>
References: <1340027512-8461-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120625160515.GF2342@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:51:52AM -0300, Fabio Estevam wrote:
> +
> +				mmc0_4bit_pins_a: mmc0-4bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x2000 0x2020 0x2030
> +						0x2040 0x2050>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				mmc0_sck_cfg: mmc0_sck_cfg {
> +					fsl,pinmux-ids = <0x2010>;
> +					fsl,pull-up = <0>;
> +				};

This looks suspicious.  First of all, 0x2010 (SSP1_DETECT) should be
in pinmux-ids of mmc0_4bit_pins_a.  Secondly, SSP1_SCK seems missing
from the pins.  You do not have a SSP1_SCK pin for the mmc slot?

-- 
Regards,
Shawn
