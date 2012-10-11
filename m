From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 11 Oct 2012 18:28:41 +0800
Subject: [PATCH 4/7] ARM: tegra30: common: enable csite clock
In-Reply-To: <5074A77D.9080500@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-5-git-send-email-josephl@nvidia.com>
 <5074A77D.9080500@wwwdotorg.org>
Message-ID: <1349951321.19413.154.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-10 at 06:38 +0800, Stephen Warren wrote:
> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> > Enable csite (debug and trace controller) clock at init to prevent it
> > be disabled. And this also the necessary clock for CPU be brought up or
> > resumed from a power-gate low power state (e.g., LP2).
> 
> Does it make sense to enable this clock only when entering LP2? Or do we
> really need to keep it on 100% of the time?

Hmmm. I am not sure does the RealView or Lauterbach ICE can still attach
to the target if the clock is not available. Or even it can be attached
but some functions of the debugger may not work. Because the CoreSight
is a very fancy debug module.

I only test it with a light weight debugger (OpenOCD). It still can work
without turning on the CoreSight clock. Maybe it just because the
openocd debugger only using the jtag interface.

Anyway, I think we need the csite always on for the developer that using
RealView or Lauterbach ICE.

Thanks,
Joseph
