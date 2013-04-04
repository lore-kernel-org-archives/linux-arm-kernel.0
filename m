From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 4 Apr 2013 18:28:17 +0800
Subject: [PATCH] clocksource: tegra: enable arch_timer
In-Reply-To: <515CB1A6.6090308@wwwdotorg.org>
References: <1364988750-25058-1-git-send-email-josephl@nvidia.com>
 <515C2E8F.1030802@gmail.com> <515C7363.4040404@wwwdotorg.org>
 <515CA060.7030100@gmail.com>  <515CB1A6.6090308@wwwdotorg.org>
Message-ID: <1365071297.1602.1.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-04 at 06:48 +0800, Stephen Warren wrote:
> On 04/03/2013 03:34 PM, Rob Herring wrote:
> > On 04/03/2013 01:22 PM, Stephen Warren wrote:
> >> On 04/03/2013 07:28 AM, Rob Herring wrote:
> >>> On 04/03/2013 06:32 AM, Joseph Lo wrote:
> >> Rob, if I did apply this change, and you also apply that series of
> >> yours, what is the result: compile-time breakage, run-time breakage,
> >> just some redundant code that needs to be removed again?
> > 
> > Compile-time breakage as the functions called here are being removed.
> 
> OK, I definitely won't apply Joseph's patch then.

Agree. This patch is redundant, once Rob's patches go into mainline.
> 
> Aside from that, I took the git branch you mentioned in the patch you
> linked to above, merged it into my dev tree, updated my bootloader to
> actually initialize the TSC correctly, and I see the following during
> boot, so I guess that's enough for:
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> on your patches.
> 
> > [    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
> > [    0.000000] Architected local timer running at 12.00MHz (virt).
> > [    0.000000] Switching to timer-based delay loop
> > [  117.431229] Calibrating delay loop (skipped), value calculated using timer frequency.. 24.00 BogoMIPS (lpj=120000)
> > [  117.987221] Switching to clocksource arch_sys_counter
