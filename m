From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Feb 2014 11:41:32 +0000
Subject: [RFC PATCH v2 1/2] mfd: syscon: Support early initialization
In-Reply-To: <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
References: <cover.1392807832.git.michal.simek@xilinx.com>
 <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
Message-ID: <20140219114132.GC10504@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FAO Arnd, Mark,

> Some platforms need to get system controller
> ready as soon as possible.
> The patch provides early_syscon_initialization
> which create early mapping for all syscon compatible
> devices in early_syscon_probe.
> Regmap is get via syscon_early_regmap_lookup_by_phandle()
> 
> Regular device probes attach device to regmap
> via regmap_attach_dev().
> 
> For early syscon initialization is necessary to extend
> struct syscon and provide remove function
> which unmap all early init structures.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Fix bad logic in early_syscon_probe
> - Fix compilation failure for x86_64 reported by zero day testing system
> - Regmap change available here
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/nodev
> 
>  drivers/mfd/syscon.c       | 128 +++++++++++++++++++++++++++++++++++++++------
>  include/linux/mfd/syscon.h |  11 ++++
>  2 files changed, 122 insertions(+), 17 deletions(-)

I have the same reservations as last time:

  http://archive.arm.linux.org.uk/lurker/message/20140212.095424.96cb7281.html

I believe you were waiting for Arnd and/or Mark to comment.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
