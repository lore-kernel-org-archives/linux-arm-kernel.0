From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Mon, 19 May 2014 23:18:26 +0200
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
In-Reply-To: <537A5F5B.6050403@linaro.org>
References: <5374FE61.50901@linaro.org> <5374FF5B.8050702@ti.com>
 <5375079E.3060305@ti.com> <537615EA.3020809@ti.com>
 <20140516212942.GK12881@atomide.com> <537A3544.1050307@linaro.org>
 <20140519172338.GJ4849@atomide.com> <537A408F.7070301@ti.com>
 <20140519175157.GK4849@atomide.com> <537A4827.30604@linaro.org>
 <20140519193622.GA11945@atomide.com> <537A5F5B.6050403@linaro.org>
Message-ID: <537A7522.30007@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano wrote:
>
> So apparently Santosh, Kevin and Alex say they are not facing the
> issue anymore with the revert. But Tobias is still facing this issue.
>
> There is this simple program [1] which usually makes cpuidle to hang
> the system more quickly when there is a problem somewhere. May be
> worth to check with it.
>
> Hope that helps.
>
>   -- Daniel
>
> [1]
> https://git.linaro.org/power/pm-qa.git/blob/HEAD:/cpuidle/cpuidle_killer.c
>
Hello,

just to clarify. I never encountered the boot failure problem on my
Panda ES in the first place. The issue with CPU_IDLE for me, like I also
say in the bugreport, showed itself through instability of the USB. I
saw the boot issue on the ml, read that it was caused by CPU_IDLE, and
thought I should make Tony aware that I have a similar problem.

Now, after applying the latest version of the patch that Santosh
proposed, the situation with CPU_IDLE improves. But it is still not
stable for me, since after some while, working with an SSH session of
WiFi (which IIRC is not connected via USB on the board), this 'BUG'
storm hits. This does _not_ happen when I disable CPU_IDLE completly.

But even if I don't connect via WiFi at all, just boot and let me system
run with serial console connected, after some time I get a kernel 'WARNING':
http://www.math.uni-bielefeld.de/~tjakobi/archive/dmesg.1.log

So something with CPU_IDLE is not right here. However I can't say if
it's exactly this boot issue which this thread was initially about.
Maybe seperate issues are at work here, who knows.

Anyway, I'm going to have a look at that cpuidle killer thingy later.

-- Tobias
