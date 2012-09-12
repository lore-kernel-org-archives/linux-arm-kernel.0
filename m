From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 12 Sep 2012 13:32:23 -0700
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <CACRpkda6u7ZL9Rj=6+sMUTMs9zjV10kneUguugTuPziQvS68dQ@mail.gmail.com>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdamYMhduj42-reu6QjQiso65=Wy_bNF37gENDBrBbQ5=Q@mail.gmail.com>
 <CACRpkda6u7ZL9Rj=6+sMUTMs9zjV10kneUguugTuPziQvS68dQ@mail.gmail.com>
Message-ID: <20120912203223.3094.5354@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-09-12 09:07:51)
> On Wed, Sep 12, 2012 at 6:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Sep 7, 2012 at 10:19 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> >> -static struct notifier_block twd_cpufreq_nb = {
> >> -       .notifier_call = twd_cpufreq_transition,
> >> +static struct notifier_block twd_clk_nb = {
> >> +       .notifier_call = twd_rate_change,
> >
> > But what happens if there is a platform which is now using this through
> > cpufreq and has not yet switched to the common clock? It regresses
> > right, because no notifications arrive anymore? Does it even compile?
> 
> Bah too late in the afternoon :-(
> 
> So the real question is - are we sure that imx6 is the last platform
> migrated to common clock of all those using the CPUfreq scaling
> (this seems to be the last piece) such that
> we don't break anything....
> 

OMAP will break.  My original version of this patch had "HACK:" in the
$subject since it was just a demo of the notifiers.

I'll submit a new version with some #ifdef CONFIG_COMMON_CLK bits ASAP.

Regards,
Mike

> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
