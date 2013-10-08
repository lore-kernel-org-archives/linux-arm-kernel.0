From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Oct 2013 23:49:28 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <525425A5.2020500@mentor.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <525425A5.2020500@mentor.com>
Message-ID: <20131008154926.GA8946@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 10:32:53AM -0500, Nathan Lynch wrote:
> > @@ -130,7 +130,11 @@ static inline void imx_smp_prepare(void) {}
> >  static inline void imx_scu_standby_enable(void) {}
> >  #endif
> >  extern void imx_src_init(void);
> > +#ifdef CONFIG_HAVE_IMX_SRC
> >  extern void imx_src_prepare_restart(void);
> > +#else
> > +extern inline void imx_src_prepare_restart(void) {}
> 
> Should be static inline?

Ah, yes.  That's a copy-paste error.  Thanks for spotting it, Nathan.
I just fixed it here.

Shawn
