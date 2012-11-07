From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Nov 2012 11:00:43 +0000
Subject: [PATCH] ARM: Fix the "WFI" instruction opcode definition.
In-Reply-To: <0bee01cdbc11$4a59afb0$df0d0f10$%kim@samsung.com>
References: <DA41BE1DDCA941489001C7FBD7A8820E3CB5512E@szxeml549-mbx.china.huawei.com>
 <5091D13B.6060106@gmail.com>
 <CAKw8HL0ymmNRB=jgGcZn1+6k0s=FKA+qBV04y_wfeu7xMpUpkw@mail.gmail.com>
 <20121105173604.GF2005@linaro.org>
 <0bee01cdbc11$4a59afb0$df0d0f10$%kim@samsung.com>
Message-ID: <CAHkRjk5MV7DWUGEhndUbvym9we90FcmvPD+arDfWtuj6PXCy2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2012 11:24, Kukjin Kim <kgene.kim@samsung.com> wrote:
> BTW, if mach-exynos includes ARMv8 later?...ARMv8 platform codes will be put
> in the arch/arm/ or arch/arm/64/ if some platform codes share with ARMv7?
> Just wondering...

If mach-exynos would support ARMv8 at some point, I would expect most
of the code to go under various drivers/ subsystems (mfd, power etc.).
I don't see any point in using opcodes. For wfi just use a macro or
cpu_do_idle() (as Rob said, it does the required dsb as well).

I'm also pushing for a standard hotplug.c implementation that is
shared by multiple platforms and uses the power state coordination
interface implemented by the firmware.

-- 
Catalin
