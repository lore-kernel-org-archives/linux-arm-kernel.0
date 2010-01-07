From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 7 Jan 2010 10:45:01 +0800
Subject: [PATCH 1/3] mmp: fix the clock rate of mmp2
In-Reply-To: <771cded01001060606h22592839x89ff1a9df0d695d6@mail.gmail.com>
References: <771cded01001060606h22592839x89ff1a9df0d695d6@mail.gmail.com>
Message-ID: <f17812d71001061845t5134f350we87c32a5e8c58fcf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

We don't need this anymore, CLOCK_TICK_RATE is for legacy use,
provided it is exclusive between different SoCs (think about MMP3
using a different one, while it can be built with MMP2 together).
Are there any specific errors of this?

On Wed, Jan 6, 2010 at 10:06 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From d2a97d0b83a139c9771d1cece544c7ef2454741c Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 6 Jan 2010 16:48:24 -0500
> Subject: [PATCH] [ARM] mmp: fix the clock rate of mmp2
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/timex.h | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/timex.h
> b/arch/arm/mach-mmp/include/mach/timex.h
> index 6cebbd0..70c9f1d 100644
> --- a/arch/arm/mach-mmp/include/mach/timex.h
> +++ b/arch/arm/mach-mmp/include/mach/timex.h
> @@ -6,4 +6,8 @@
> ?* published by the Free Software Foundation.
> ?*/
>
> +#ifdef CONFIG_CPU_MMP2
> +#define CLOCK_TICK_RATE ? ? ? ? ? ? ? ?6500000
> +#else
> ?#define CLOCK_TICK_RATE ? ? ? ? ? ? ? ?3250000
> +#endif
> --
> 1.5.6.5
>
