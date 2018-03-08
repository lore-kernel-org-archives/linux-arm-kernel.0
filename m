From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:33:01 +0800
Subject: [PATCH] arm: dts: imx: Add missing #sound-dai-cells for sgtl5000
 codec
In-Reply-To: <20180301202537.30571-1-robh@kernel.org>
References: <20180301202537.30571-1-robh@kernel.org>
Message-ID: <20180308083300.GU3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 02:25:33PM -0600, Rob Herring wrote:
> dtc now warns about missing #sound-dai-cells:
> 
> arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/imx6ul-isiot-emmc.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/imx6ul-isiot-nand.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus at 2100000/i2c at 21a0000/codec at a or bad phandle (referred from sound-dai[0])
> 
> Lots of i.MX boards use the SGTL5000 codec, but not all get the warning
> because only some reference the codec with "sound-dai" property. However,
> the codec should always provide #sound-dai-cells regardless, so fix all
> the occurrences.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks.
