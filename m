From: b04825@freescale.com (Timur Tabi)
Date: Thu, 15 Mar 2012 11:47:05 -0500
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120315142115.GB6065@S2101-09.ap.freescale.net>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
Message-ID: <4F621D09.2080806@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> sound {
>       compatible = "fsl,imx51-babbage-sgtl5000",
>                    "fsl,imx-audio-sgtl5000";
>       model = "imx51-babbage-sgtl5000";
>       ssi-controller = <&ssi1, &ssi2>;
>       audio-codec = <&sgtl5000_1, &sgtl5000_2>;
>       mux-int-port = <1>;
>       mux-ext-port = <3>;
> };

Based on Mark's other email, I would rather see this:

sound1 {
      compatible = "fsl,imx51-babbage-sgtl5000",
                   "fsl,imx-audio-sgtl5000";
      model = "imx51-babbage-sgtl5000";
      ssi-controller = <&ssi1>;
      audio-codec = <&sgtl5000_1>;
      mux-int-port = <1>;
      mux-ext-port = <3>;
};

sound2 {
      compatible = "fsl,imx51-babbage-sgtl5000",
                   "fsl,imx-audio-sgtl5000";
      model = "imx51-babbage-sgtl5000";
      ssi-controller = <&ssi2>;
      audio-codec = <&sgtl5000_2>;
      mux-int-port = <1>;
      mux-ext-port = <3>;
};

(ignoring for the moment that I have no idea what the mux-xxx-port values
in sound2 should be)

This makes it clear that ssi1 connects only to sgtl5000_1.

If you're okay with this, then please update the documentation accordingly.

-- 
Timur Tabi
Linux kernel developer at Freescale
