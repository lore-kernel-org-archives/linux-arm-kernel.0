From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 20 Jun 2018 10:05:10 +0200
Subject: [PATCH v1] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
In-Reply-To: <20180619220719.3200-1-nick@shmanahar.org>
References: <20180619220719.3200-1-nick@shmanahar.org>
Message-ID: <1529481910.7211.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

Am Dienstag, den 19.06.2018, 23:07 +0100 schrieb Nick Dyer:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
> 
> > Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
> ?arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca94d812..4d12ba54ba15 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -770,8 +770,8 @@
> ?
> > ?	pinctrl_ts: tsgrp {
> > ?		fsl,pins = <
> > > -			MX51_PAD_CSI1_D8__GPIO3_12		0x85
> > > -			MX51_PAD_CSI1_D9__GPIO3_13		0x85
> > > +			MX51_PAD_CSI1_D8__GPIO3_12		4
> +			MX51_PAD_CSI1_D9__GPIO3_13		(1<<16)

Please don't move away from using hex notation for the padctrl
settings.

Thanks,
Lucas
