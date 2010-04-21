From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Apr 2010 18:35:13 -0700
Subject: Loops per jiffy broken for SMP cores?
Message-ID: <4BCE5651.8040504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the first time I'm mailing LAKML, so please excuse me if I do 
something silly.

I looked at arch/arm/lib/delay.S and it looks like __udelay and 
__const_udelay won't work correctly for SMP cores. The code just uses 
the loops_per_jiffy variable instead of the per-CPU loops per jiffy data.

Is anyone already working on a fix for that? If not, I can fix it up in 
a way that's hopefully palatable to the community.

Thanks,
Saravana
