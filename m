From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 12 Nov 2013 14:53:31 -0800
Subject: [PATCH v11 5/6] ARM: hi3xxx: add smp support
In-Reply-To: <1383813691-31587-6-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Thu, 7 Nov 2013 16:41:30 +0800")
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
 <1383813691-31587-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <8738n1nses.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Enable SMP support on hi3xxx platform
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
> Tested-by: Li Xin <li.xin@linaro.org>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 30 ++++++--
>  arch/arm/boot/dts/hi3620.dtsi                      | 38 ++++++++++
>  arch/arm/mach-hi3xxx/Kconfig                       |  3 +
>  arch/arm/mach-hi3xxx/Makefile                      |  1 +
>  arch/arm/mach-hi3xxx/core.h                        | 11 +++
>  arch/arm/mach-hi3xxx/hi3xxx.c                      | 34 +++++++++
>  arch/arm/mach-hi3xxx/platsmp.c                     | 84 ++++++++++++++++++++++
>  7 files changed, 197 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-hi3xxx/core.h
>  create mode 100644 arch/arm/mach-hi3xxx/platsmp.c
>
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index 3be60c8..8c7a465 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -1,10 +1,32 @@
>  Hisilicon Platforms Device Tree Bindings
>  ----------------------------------------------------
>  
> -Hi3716 Development Board
> -Required root node properties:
> -	- compatible = "hisilicon,hi3716-dkb";
> -

This was added in patch 1/6, then removed here.  If it's not
needed/used, just drop it from patch 1 please.

Kevin
