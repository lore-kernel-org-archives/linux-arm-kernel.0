From: davidb@codeaurora.org (David Brown)
Date: Thu, 12 Jan 2012 16:27:20 -0800
Subject: [PATCH 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <20120113001334.GA6416@codeaurora.org>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-15-git-send-email-marc.zyngier@arm.com>
 <20120113001334.GA6416@codeaurora.org>
Message-ID: <20120113002720.GA7215@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 04:13:34PM -0800, David Brown wrote:
> On Wed, Jan 11, 2012 at 01:08:53PM +0000, Marc Zyngier wrote:
> > Convert the MSM timers to the runtime registration interface.
> > 
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: David Brown <davidb@codeaurora.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/mach-msm/timer.c |   79 +++++++++++++++++++++++++--------------------
> >  1 files changed, 44 insertions(+), 35 deletions(-)
> 
> This change breaks cpuhotplug.  I get a lockup if I try to shutdown
> cpu 1.  I'll see if I can figure out why.

This may be a false alarm.  I am not able to reproduce this failure,
and have reset and brought the CPU1 on and offline multiple times.

So, in light of this:

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
