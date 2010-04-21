From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Apr 2010 10:26:01 +0530
Subject: udelay() broken for SMP cores?
In-Reply-To: <4BCE60C4.8020505@codeaurora.org>
References: <4BCE60C4.8020505@codeaurora.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Saravana Kannan
> Sent: Wednesday, April 21, 2010 7:50 AM
> To: linux-arm-kernel at lists.infradead.org
> Subject: udelay() broken for SMP cores?
> 
> Fixed the subject and starting a new thread. Please ignore the previous
> email with an incorrect subject.
> 
> Hi,
> 
> This is the first time I'm mailing LAKML, so please excuse me if I do
> something silly (looks like I already did!).
> 
> I looked at arch/arm/lib/delay.S and it looks like __udelay and
> __const_udelay won't work correctly for SMP cores. The code just uses
> the loops_per_jiffy variable instead of the per-CPU loops per jiffy data.
> 
> Is anyone already working on a fix for that? If not, I can fix it up in
> a way that's hopefully palatable to the community.

Two questions :

1. Why do you think the udelay is broken ?? Did you measure the time ??
2. Have you arrived at this conclusion based on BOGO MIPS value ??
If you are correlating BIGOMIPS with udelay, then I am sure you are going
Get it wrong because of the aggressive nature of newer ARM's where the branch
loop in the udelay is always hit and instead of fetching it from cache/memory,
its taken from pipe line itself.

Ofcourse you point of using the per cpu "loops_per_jiffy" variable may be valid, but
