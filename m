From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 May 2012 19:14:44 +0200
Subject: [PATCH v4 3/7] ARM: imx: clean and consolidate imx5 suspend and
 idle code
In-Reply-To: <CAMXH7KFQvLC-tJRLR-3KqRZTY1=VG2me5HqLGzpo6Y4BnC2Dug@mail.gmail.com>
References: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
 <1337135616-8988-4-git-send-email-rob.lee@linaro.org>
 <20120516173815.GV30400@pengutronix.de>
 <CAMXH7KFQvLC-tJRLR-3KqRZTY1=VG2me5HqLGzpo6Y4BnC2Dug@mail.gmail.com>
Message-ID: <20120517171444.GC30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 09:34:26AM -0500, Rob Lee wrote:
> On Wed, May 16, 2012 at 12:38 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Robert,
> >
> > Overall this looks ok now, some comments inline.
> >
> >> + ? ? ? ? ? ? return ret;
> >> +
> >> + ? ? if (cpu_is_mx51())
> >> + ? ? ? ? ? ? suspend_set_ops(&mx5_suspend_ops);
> >
> > Now this is called only in i.MX51 context, so you can skip the cpu_is
> >
> 
> After this patch series this is also called in i.MX53 context.  I'm
> not confident about the i.MX53 suspend/resume and would prefer to
> perform further testing and address issues with it in a separate patch
> series.

In this case there is also the possibility that you add a imx51_pm_init
in which you set the suspend_ops and call imx5_pm_init afterwards. The
cpu_is_macros a kind of deprecated. Instead we settled on calling
functions with the exact SoC name from the (dt-) board files and call
the more generic function from the SoC specific ones.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
