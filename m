From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 2 Jun 2011 12:18:35 +0200
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <20110602094622.GS3660@n2100.arm.linux.org.uk>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
	<20110602094622.GS3660@n2100.arm.linux.org.uk>
Message-ID: <4DE7637B.3060901@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2011 11:46 AM, Russell King - ARM Linux wrote:
> Why don't we just find a way of fixing sched_clock so that the value
> doesn't reset over a suspend/resume cycle?
Even if the value isn't reset during suspend/resume we want the 
clocksource to keep counting. Or is it ok to have the clocksource stop 
or freeze during suspend?
Then we have cpuidle. Is it ok to stop/freeze the timer during cpuidle 
sleep states?
My view is that sched_clock and the clocksource read should return the 
time since boot and keep counting during sleep and suspend. (In this 
case we use the same timer for both sched_clk and clocksource.)
> IOW, lets fix the problem
> for_everyone_  rather than only fixing it for one platform at a time.
I agree that fixing it for everyone would be better and I can give it a 
try if I get pointed in the right direction.
