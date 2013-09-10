From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 Sep 2013 13:49:24 +0200
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
Message-ID: <4292924.3iHJT5nzNS@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 10, 2013 04:59:29 PM Viresh Kumar wrote:
> On 9 September 2013 20:41, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Sorry guys, I'm trying my best to stop this patch from propagating to
> > stable and to get it fixed asap, so, the CC list might be a bit excessive.
> > Also trying to fix the originally spare cc list, which makes it impossible
> > for me to reply to the original thread, instead have to start a new one.
> >
> > Commit
> >
> > commit dceff5ce18801dddc220d6238628619c93bc3cb6
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Sun Sep 1 22:19:37 2013 +0530
> >
> >     cpufreq: fix serialization issues with freq change notifiers
> >
> > breaks .transition_ongoing counting. This leads to cpufreq-cpu0 not
> > working any more. In particular switching the governor from performance to
> > powersave directly after boot doesn't result in a frequency switch any
> > more. Reverting this patch fixes the problem again. Tested with today's
> > -next.
> 
> I have tested it again on my exynos and intel machines and couldn't see
> a single problem with this patch..
> 
> I am afraid you need to give us some more information on how it broke
> your stuff.. :)
> 
> And I am also not sure cpufreq-cpu0 is different then any other driver..

That said I'm actually unsure what problems *exactly* are fixed by commit
7c30ed5.  The commit log only says that PRECHANGE or POSTCHAGE shouldn't be
called twice in a row, but it doesn't say why.  As the fallout indicates,
that actually happened before commit 7c30ed5 and nothing visibly broke, so
the benefit from having that commit is questionable to me.  On the other hand,
the commit itself is evidently broken, so what exactly is the reason for
keeping it?

Rafael
