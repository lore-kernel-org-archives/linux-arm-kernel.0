From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Jan 2012 15:33:34 -0800
Subject: [PATCH v2 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <20120113224709.GH1068@n2100.arm.linux.org.uk>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
 <20120113223740.GA23036@codeaurora.org>
 <20120113224709.GH1068@n2100.arm.linux.org.uk>
Message-ID: <20120113233334.GA21168@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:47:09PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 13, 2012 at 02:37:40PM -0800, David Brown wrote:
> > On Fri, Jan 13, 2012 at 06:28:41PM +0000, Marc Zyngier wrote:
> > > Convert the MSM timers to the runtime registration interface.
> > > 
> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > Tested-by: David Brown <davidb@codeaurora.org>
> > > Acked-by: David Brown <davidb@codeaurora.org>
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Ok, this is definitely now consistenly causing cpu hotplug to fail.
> > I'll look in to this further, but for now, please removed my Tested-by
> > and Acked-by.
> 
> That'll be because the local_timer_ops structure is marked __initdata
> but is used after init has completed.  It should be marked __cpuinitdata
> if it's used for CPU bringup (which it is.)

:-)  I guess I should be checking my email while looking for
problems.  But, I found it anyway.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
