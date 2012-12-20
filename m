From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Dec 2012 10:46:58 -0700
Subject: [PATCH V3 3/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <1355797861-12759-4-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-4-git-send-email-josephl@nvidia.com>
Message-ID: <50D34F12.9080801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 07:30 PM, Joseph Lo wrote:
> Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> functions were used for CPU powered-down state maintenance.

I think this isn't adding those functions into tegra_cpu_car_ops, but
rather implementing the already existing function pointers for Tegra20,
right?

This patch touches the clock driver and Prashant will soon be posting
patches that significantly rework the clock driver. Those will conflict.
How have you worked with Prashant to resolve the conflicts? Will
Prashant's patches be based on top of this series? Please explicitly
describe the dependencies and resolution of conflicts when you post the
next version. (below the ---, along with the changelog)
