From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 18:00:04 +0100
Subject: [PATCH v3] drm/rockchip: Refactor the component match logic.
In-Reply-To: <1489573247-9628-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1489573247-9628-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <19101003.9xjQ92OS5C@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 18:20:47 CET schrieb Jeffy Chen:
> Currently we are adding all components from the dts, if one of their
> drivers been disabled, we would not be able to bring up others.
> 
> Refactor component match logic, follow exynos drm.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

This reliably produces null pointer dereference errors in
	__platform_driver_register called from rockchip_drm_init
on at least rk3036 and rk3288 (probably more) when applied on top of 
Linus' tree from today. Log attached and Rockchip drm compiled as module.

I'm currently dug into other areas, so hadn't have time to investigate further 
yet.


Heiko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: firefly-drm.log
Type: text/x-log
Size: 36974 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/86183a40/attachment-0001.bin>
