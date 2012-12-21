From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 21 Dec 2012 13:02:11 +0800
Subject: [PATCH V3 3/5] ARM: tegra20: clocks: add CPU low-power
 function into tegra_cpu_car_ops
In-Reply-To: <50D34F12.9080801@wwwdotorg.org>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-4-git-send-email-josephl@nvidia.com>
 <50D34F12.9080801@wwwdotorg.org>
Message-ID: <1356066131.26029.26.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-21 at 01:46 +0800, Stephen Warren wrote:
> On 12/17/2012 07:30 PM, Joseph Lo wrote:
> > Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> > functions were used for CPU powered-down state maintenance.
> 
> I think this isn't adding those functions into tegra_cpu_car_ops, but
> rather implementing the already existing function pointers for Tegra20,
> right?
> 
Yes, exactly.

> This patch touches the clock driver and Prashant will soon be posting
> patches that significantly rework the clock driver. Those will conflict.
> How have you worked with Prashant to resolve the conflicts? Will
> Prashant's patches be based on top of this series? Please explicitly
> describe the dependencies and resolution of conflicts when you post the
> next version. (below the ---, along with the changelog)
> 
Yes, there are many patch series may have dependency each other
recently. We also want to know what the sequence you expect to merge the
patch series to your tree. Evan my own patch series had dependency too.
For ex, hotplug enhancement, cpuidle, SMP works on UP and
suspend/resume. Currently, I think we are all work the the top of
linux-next tree. If we can't expect the sequence of the patch series to
be merged, we will always have some conflicts with each other.

Depend on the timing, I think it should be better to know which patch
series should be going first or recently and which should go later and
depend on which series. Then we can rearrange our patches on top of it.
And reducing the job to fix conflict on your side.

What do you think, Prashant? If your rework of clock driver will show up
soon and Stephen also expect that will be merged first, I am fine to
re-base on it and re-send my next version after new clock driver be
done.

Thanks,
Joseph
