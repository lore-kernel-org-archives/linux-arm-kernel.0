From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Apr 2010 19:19:48 -0700
Subject: udelay() broken for SMP cores?
Message-ID: <4BCE60C4.8020505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed the subject and starting a new thread. Please ignore the previous 
email with an incorrect subject.

Hi,

This is the first time I'm mailing LAKML, so please excuse me if I do 
something silly (looks like I already did!).

I looked at arch/arm/lib/delay.S and it looks like __udelay and 
__const_udelay won't work correctly for SMP cores. The code just uses 
the loops_per_jiffy variable instead of the per-CPU loops per jiffy data.

Is anyone already working on a fix for that? If not, I can fix it up in 
a way that's hopefully palatable to the community.

Thanks,
Saravana
