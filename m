From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Mar 2012 23:46:39 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F5FD706.8040209@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
Message-ID: <20120313234638.GY3177@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 06:23:50PM -0500, Timur Tabi wrote:

> sound {
> 	compatible = "fsl,imx51-babbage-sgtl5000",
> 		     "fsl,imx-audio-sgtl5000";
> 	model = "imx51-babbage-sgtl5000";
> 	ssi-controller = <&ssi1>;
> 	audio-codec = <&sgtl5000>;
> 	mux-int-port = <1>;
> 	mux-ext-port = <3>;
> };

> How does this handle multiple SSIs, each connected to its own codec?

With this card those would just be separate CODECs.  This is a binding
for a simple card.

> And where's the binding for the DMA controller?

The DMA controller is transparently instantiated on Tegra systems, there
really isn't a meaningfully separate DMA controller - the I2S controller
specifies the signal to use.  Currently the card takes care of the ASoC
level driver stuff but it really should be done by the I2S controller.

> I honestly don't see how this is an improvement over what I came up with.

The biggest improvement is that the SoC binding knows nothing about the
card binding at all, cards are completely separate and are free to
define any binding they choose using any number of on-SoC and off-SoC
devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/db40adc5/attachment.sig>
