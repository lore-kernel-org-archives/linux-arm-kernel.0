From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Feb 2012 21:17:18 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202120900.GC7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
Message-ID: <20120202131716.GF9773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:09:01PM +0000, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:
> 
> >  static void __init mxc_init_audio(void)
> >  {
> >  	imx31_add_imx_ssi(0, NULL);
> >  	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
> > +	imx_add_platform_device("audmux-v2", 0,
> > +				audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);
> 
> Since the audmux is a part of the SoC silicon shouldn't the SoC just
> register the device without individual boards having to do anything
> (possibly conditional on ASoC being selected in Kconfig or something)?
> It's going to be connected in exactly the same fashion on any system
> using the SoC.

Hmm, we are trying to save adding the device for those boards which do
not route any audmux pins out at all.

-- 
Regards,
Shawn
