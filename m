From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 24 Sep 2010 13:00:49 +0300
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <20100924015056.10325.95854.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
Message-ID: <AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> From: Yogesh Marathe <yogesh_marathe@ti.com>
>
> The definition of "iva2" device in iommu_device
> is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> this option is not defined in KConfig.
>
> This patch removes the wrapper and makes "iva2"
> available as another iommu_device.

NAK.

This would break tidspbridge's MMU. This was discussed before:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=58305

When tidspbridge has migrated to iommu, then it should define
CONFIG_MPU_BRIDGE_IOMMU.

-- 
Felipe Contreras
