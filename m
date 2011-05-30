From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 30 May 2011 13:57:16 +0530
Subject: [PATCH] Consolidate the clkdev header files
In-Reply-To: <20110530010416.GA24365@july>
References: <20110530010416.GA24365@july>
Message-ID: <BANLkTinp8+mNkVmW=RwymqGF6ohs4yhY-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 6:34 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Now most of ARM machines has the alsmot same __clk_get/put() macro
>
> So place it at the arch/arm/include/asm/clkdev.h and remove the reduntant header files
>
> But some machines don't have the same form as above. It can use the machince specific clkdev file by HAVE_MACH_CLKDEV config
>
> Now there are only 3 caese.
>
> 1) define the clk structure with clkdev macro => Need to move clk structure to proper header file
>
> arch/arm/mach-versatile/include/mach/clkdev.h
> arch/arm/mach-realview/include/mach/clkdev.h
> arch/arm/mach-vexpress/include/mach/clkdev.h
> arch/arm/mach-integrator/include/mach/clkdev.h
>
> 2) export the __clk_get/put function at clock.c
>
> arch/arm/mach-shmobile/include/mach/clkdev.h
>
> 3) demuxing the clk source
> arch/arm/mach-u300/include/mach/clkdev.h
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?6 ++++
> ?arch/arm/include/asm/clkdev.h ? ? ? ? ? ? ? ?| ? ?5 ++++

[...]

> ?arch/arm/mach-spear3xx/include/mach/clkdev.h | ? 19 --------------
> ?arch/arm/mach-spear6xx/include/mach/clkdev.h | ? 19 --------------
> ?arch/arm/plat-spear/include/plat/clkdev.h ? ?| ? 20 ---------------

Acked-by: Viresh Kumar <viresh.kumar@st.com>
