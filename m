From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Apr 2010 20:26:46 +0800
Subject: [PATCH 05/10] mmp: fix clock tick rate in mmp2
In-Reply-To: <p2i771cded01004280520wc663c42bva8c270fbdfaf4ddc@mail.gmail.com>
References: <p2i771cded01004280520wc663c42bva8c270fbdfaf4ddc@mail.gmail.com>
Message-ID: <z2hf17812d71004280526u6b6171a0rb0c47be480616b1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 8:20 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 4d3bcaf4bd83886fe5d14be22bbc4baf2d51a543 Mon Sep 17 00:00:00 2001
> From: Mingliang Hu <mhu4@marvell.com>
> Date: Mon, 12 Apr 2010 17:55:21 +0800
> Subject: [PATCH] [ARM] mmp: fix clock tick rate in mmp2
>
> In MMP2, clock tick rate should be 6500000.
>
> Signed-off-by: Mingliang Hu <mhu4@marvell.com>
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

Actually we no longer depend on this macro, yet it's straightforward to
keep it here without side effect. So OK.

> ?#define CLOCK_TICK_RATE ? ? ? ? ? ? ? ?3250000
> +#endif
> --
> 1.5.6.5
>
