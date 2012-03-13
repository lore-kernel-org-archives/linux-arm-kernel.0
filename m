From: timur@freescale.com (Timur Tabi)
Date: Tue, 13 Mar 2012 18:23:50 -0500
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120309013216.GH2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
Message-ID: <4F5FD706.8040209@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt, which
> takes Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
> as the example.

sound {
	compatible = "fsl,imx51-babbage-sgtl5000",
		     "fsl,imx-audio-sgtl5000";
	model = "imx51-babbage-sgtl5000";
	ssi-controller = <&ssi1>;
	audio-codec = <&sgtl5000>;
	mux-int-port = <1>;
	mux-ext-port = <3>;
};

How does this handle multiple SSIs, each connected to its own codec?

And where's the binding for the DMA controller?

I honestly don't see how this is an improvement over what I came up with.

-- 
Timur Tabi
Linux kernel developer at Freescale
