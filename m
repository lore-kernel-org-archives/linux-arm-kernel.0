From: eric.miao@canonical.com (Eric Miao)
Date: Sat, 26 Jun 2010 16:50:32 +0800
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
Message-ID: <AANLkTinVZdN0Ltbk6H9YMPDT4OZ2-2S7_3vLKcBEfxgT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +config PATCH_PHYS_VIRT
> + ? ? ? def_bool n
> +
> ?source "init/Kconfig"
>
> ?source "kernel/Kconfig.freezer"
> @@ -579,6 +582,7 @@ config ARCH_PXA
> ? ? ? ?select GENERIC_CLOCKEVENTS
> ? ? ? ?select TICK_ONESHOT
> ? ? ? ?select PLAT_PXA
> + ? ? ? select PATCH_PHYS_VIRT if !XIP_KERNEL

Tested on PXA, so ignore this change at the moment.
