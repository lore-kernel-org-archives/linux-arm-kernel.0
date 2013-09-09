From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 09 Sep 2013 23:08:25 +0200
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
Message-ID: <1883706.eFcILAzoo8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, September 09, 2013 05:11:10 PM Guennadi Liakhovetski wrote:
> Sorry guys, I'm trying my best to stop this patch from propagating to 
> stable and to get it fixed asap, so, the CC list might be a bit excessive. 
> Also trying to fix the originally spare cc list, which makes it impossible 
> for me to reply to the original thread, instead have to start a new one.

I'm not sure what you're talking about.  What exactly was wrong with the
original CC list in particular?

> Commit
> 
> commit dceff5ce18801dddc220d6238628619c93bc3cb6
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Sun Sep 1 22:19:37 2013 +0530
> 
>     cpufreq: fix serialization issues with freq change notifiers
> 
> breaks .transition_ongoing counting.

Do you know how exactly it breaks that?  If so, care to share that knowledge?

> This leads to cpufreq-cpu0 not working any more. In particular switching the
> governor from performance to powersave directly after boot doesn't result in
> a frequency switch any more. Reverting this patch fixes the problem again.

However, this is a regression fix, so I'd prefer to fix the problem on top of
it instead of reverting this commit entirely.

> Tested with today's 
> -next.
> 
> Please, refrain from including into "stable" until clarified!

Well, dropping the commit altogether and dropping the "CC stable" tag are
equally disruptive at this point, so I think I'll just defer all of the
cpufreq fixes I wanted to push for 3.12 before the ending of the merge
window.

Thanks,
Rafael
