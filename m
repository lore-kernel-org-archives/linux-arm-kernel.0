From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Dec 2012 13:25:07 +0800
Subject: [PATCH 2/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <50BD8646.6070608@nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-3-git-send-email-josephl@nvidia.com>
 <50BD8646.6070608@nvidia.com>
Message-ID: <1354598707.30563.10.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-04 at 13:12 +0800, Prashant Gaikwad wrote:
> On Monday 03 December 2012 08:30 AM, Joseph Lo wrote:
> > Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> > functions were used for CPU powered-down state maintenance.
> >
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> >   arch/arm/mach-tegra/tegra20_clocks.c |  102 ++++++++++++++++++++++++++++++++++
> >   1 files changed, 102 insertions(+), 0 deletions(-)
> 
> I have a concern here, I am working on removing these ops and replacing 
> it with clock.
> Adding suspend/resume to these will make it more difficult to remove.
> 
> Any other way to implement this?
> 

Prashant,

Thanks for remind.
Actually the "tegra_cpu_car_ops" is more like reset & suspend/resume
handling, it's not really related to clock framework. So it's more like
some functions for CPU power management control. Maybe I can move them
(Tegra20 & Tegra30) to another pm related file later.

How do you think, Stephen?

Thanks,
Joseph
