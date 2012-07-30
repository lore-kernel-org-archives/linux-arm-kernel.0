From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jul 2012 10:29:50 -0600 (MDT)
Subject: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised
 wakeup/sleep
In-Reply-To: <CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com>
 <CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1207301027310.18037@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 27 Jul 2012, Nayak, Rajendra wrote:

> On Fri, Jul 27, 2012 at 2:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
> > clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
> > clockdomain wakeup and sleep.  This would probably have broken
> > software-supervised clockdomain wakeup and sleep on OMAP3.
> 
> Would something like this be better than duplicating most of
> omap2_clkdm_clk_enable/disable?

Am working towards getting the cpu_is_*() calls out of there in 
preparation for the move to drivers/.  In fact there are some patches here 
that will be posted shortly to get rid of those clkdm_clk_(enable|disable) 
functions completely.


- Paul
