From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Mar 2013 19:16:13 +0800
Subject: [PATCH 05/10] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <51363F67.8040200@wwwdotorg.org>
References: <1362397241-5786-1-git-send-email-josephl@nvidia.com>
 <51363F67.8040200@wwwdotorg.org>
Message-ID: <1362654973.1890.28.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-06 at 02:54 +0800, Stephen Warren wrote:
> On 03/04/2013 04:40 AM, Joseph Lo wrote:
> > The PMC mostly controls the entry and exit of the system from different
> > sleep modes. Different platform or system may have different configurations.
> > The power management configurations of PMC is represented as some properties.
> > The system needs to define the properties when the system supports deep sleep
> > mode (i.e. suspend).
> 
> One overall question here: For LP0, the idea is that the bootloader
> provides the AVP boot code, puts it in RAM, passes the address to the
> kernel, which then arranges for that code to be executed when the system
> resumes from LP0. Why does the bootloader have to provide the code? Why
> can't the AVP code simply be part of the kernel, just like e.g. the main
> CPU's hotplug/secondary-power-on/power-saving reset vector is part of
> the kernel? If we did that, it'd remove any need for bootloader support
> for LP0 - the kernel would manage it entirely internally. That seems
> much simpler.

Yes, I had exactly the same question before.

The AVP was a ARM7 (armv4) core. So the warm boot code needs to be built
as armv4 binary.

Other functions in warm boot should not be a problem to implement in
kernel (at least for Tegra114, not confirm it's ok or not for Tegra20
and Tegra30's warm boot code).

Thanks,
Joseph
