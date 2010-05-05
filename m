From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 5 May 2010 14:10:40 +0800
Subject: [PATCH 05/10] [ARM] pxa: fix the cpu_is_pxa950
In-Reply-To: <x2q771cded01004290118tc3639f59ga7b8760de91e911f@mail.gmail.com>
References: <x2q771cded01004290118tc3639f59ga7b8760de91e911f@mail.gmail.com>
Message-ID: <p2kf17812d71005042310s59667734r57cc208849b62ef8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 4:18 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From a4529b7e7e8b33d52106da10f04219d9e9b4f690 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 12 Mar 2010 08:51:54 -0500
> Subject: [PATCH] [ARM] pxa: fix the cpu_is_pxa950
>
> Fix the wrong variable used in cpu_is_pxa950().
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied.

> ---
> ?arch/arm/mach-pxa/include/mach/hardware.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
> b/arch/arm/mach-pxa/include/mach/hardware.h
> index 7515757..3d8d8cb 100644
> --- a/arch/arm/mach-pxa/include/mach/hardware.h
> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
> @@ -202,7 +202,7 @@
> ?#define __cpu_is_pxa950(id) ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ?({ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> ? ? ? ? ? ? ? ?unsigned int _id = (id) >> 4 & 0xfff; ? \
> - ? ? ? ? ? ? ? id == 0x697; ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? _id == 0x697; ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ? })
> ?#else
> ?#define __cpu_is_pxa950(id) ? ?(0)
> --
> 1.5.6.5
>
