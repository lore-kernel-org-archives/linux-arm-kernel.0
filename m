From: khilman@ti.com (Kevin Hilman)
Date: Thu, 29 Mar 2012 09:55:37 -0700
Subject: [PATCH] omap2+: pm: fix compilation break.
In-Reply-To: <20120329163309.GW9859@atomide.com> (Tony Lindgren's message of
 "Thu, 29 Mar 2012 09:33:10 -0700")
References: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
 <20120329151128.GT9859@atomide.com>
 <20120329163309.GW9859@atomide.com>
Message-ID: <87aa2zmjna.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [120329 08:14]:
>> * Govindraj.R <govindraj.raja@ti.com> [120329 03:12]:
>> > From: "Govindraj.R" <govindraj.raja@ti.com>
>> > 
>> > Fix the compilation break observed on latest mainline.
>> > 
>> > Fixes below compilation break:
>> > 
>> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
>> > arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
>> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
>> > arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'
>> 
>> Care to mention which commit broke the compile?
>
> Seems like it was 9f97da78 (Disintegrate asm/system.h for ARM),
> and also needs to be fixed for omap1 too. Using the updated
> patch below.
>
> Tony
>
>
> From: Govindraj.R <govindraj.raja@ti.com>
> Date: Thu, 29 Mar 2012 09:30:28 -0700
> Subject: [PATCH] ARM: OMAP: pm: fix compilation break
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> Fix the compilation break observed on latest mainline caused
> by 9f97da78 (Disintegrate asm/system.h for ARM):
>
> arch/arm/mach-omap1/pm.c: In function ?omap_pm_prepare?:
> arch/arm/mach-omap1/pm.c:587: error: implicit declaration of function ?disable_hlt?
> arch/arm/mach-omap1/pm.c: In function ?omap_pm_finish?:
> arch/arm/mach-omap1/pm.c:624: error: implicit declaration of function ?enable_hlt?
> arch/arm/mach-omap1/pm.c: In function ?omap_pm_init?:
> arch/arm/mach-omap1/pm.c:681: error: ?arm_pm_idle? undeclared (first use in this function)
> ...
>
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
> arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
> arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'
>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> [tony at atomide.com: updated to fix omap1 too]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@ti.com>
