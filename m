From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 18:24:41 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <20161004174903.GA3098@localhost>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com> <20160919231441.GA60928@google.com>
 <57E0E97B.5000106@arm.com> <20160928012309.GA29518@localhost>
 <20160929170847.1227a312@arm.com> <20161004174903.GA3098@localhost>
Message-ID: <20161019012441.GW8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04, Brian Norris wrote:
> Hi Marc,
> 
> On Thu, Sep 29, 2016 at 05:08:47PM +0100, Marc Zyngier wrote:
> > On Tue, 27 Sep 2016 18:23:11 -0700
> > Brian Norris <briannorris@chromium.org> wrote:
> > > On Tue, Sep 20, 2016 at 08:47:07AM +0100, Marc Zyngier wrote:
> > > <Begin side note>
> > > rk3288 (ARMv7 system widely used for our Chromebooks) has the same
> > > issue, except the kernel we're using for production (based on v3.14)
> > > doesn't have the following commit, which stopped utilizing the RTC:
> > > 
> > > commit 0fa88cb4b82b5cf7429bc1cef9db006ca035754e
> > > Author: Xunlei Pang <pang.xunlei@linaro.org>
> > > Date:   Wed Apr 1 20:34:38 2015 -0700
> > > 
> > >     time, drivers/rtc: Don't bother with rtc_resume() for the nonstop clocksource
> > > 
> > > And any mainline testing on rk3288 doesn't see the problem, because
> > > mainline doesn't support its lowest-power sleep modes well enough (see
> > > ROCKCHIP_ARM_OFF_LOGIC_DEEP in arch/arm/mach-rockchip/pm.c).
> > 
> > Arghh... So even my favourite Chromebook (from which I'm typing this
> > email) is affected? Not very nice...
> 
> Yep. But if you're running mainline, you just get to have high S3 power
> consumption instead!

Just curious, do we enter this state during cpuidle as well? Or
is it only across suspend that the clock stops working?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
