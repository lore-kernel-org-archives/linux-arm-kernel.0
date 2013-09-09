From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 9 Sep 2013 17:11:10 +0200 (CEST)
Subject: "cpufreq: fix serialization issues with freq change notifiers" breaks
 cpufreq too
Message-ID: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry guys, I'm trying my best to stop this patch from propagating to 
stable and to get it fixed asap, so, the CC list might be a bit excessive. 
Also trying to fix the originally spare cc list, which makes it impossible 
for me to reply to the original thread, instead have to start a new one.

Commit

commit dceff5ce18801dddc220d6238628619c93bc3cb6
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sun Sep 1 22:19:37 2013 +0530

    cpufreq: fix serialization issues with freq change notifiers

breaks .transition_ongoing counting. This leads to cpufreq-cpu0 not 
working any more. In particular switching the governor from performance to 
powersave directly after boot doesn't result in a frequency switch any 
more. Reverting this patch fixes the problem again. Tested with today's 
-next.

Please, refrain from including into "stable" until clarified!

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
