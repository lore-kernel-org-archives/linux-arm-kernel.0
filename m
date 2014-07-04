From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Jul 2014 20:39:34 +0800
Subject: [PATCH] arm: pxa: call debug_ll_io_init for earlyprintk
In-Reply-To: <1401995457-24721-2-git-send-email-andrew.ruder@elecsyscorp.com>
References: <1401995457-24721-1-git-send-email-andrew.ruder@elecsyscorp.com>
 <1401995457-24721-2-git-send-email-andrew.ruder@elecsyscorp.com>
Message-ID: <CAN1soZwHjbifY-iNc9d0eiDgwV3T6RMBYK4Ys6UavhOGCHr3dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 3:10 AM, Andrew Ruder
<andrew.ruder@elecsyscorp.com> wrote:
> This is already done automatically for many other ARM platforms by the
> ARM core code, but since pxa is using the .map_io callback, it needs to
> call it explicitely for earlyprintk support.
>
> Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
> ---
>  arch/arm/mach-pxa/generic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
> index 4225417..94f49c2 100644
> --- a/arch/arm/mach-pxa/generic.c
> +++ b/arch/arm/mach-pxa/generic.c
> @@ -93,5 +93,6 @@ static struct map_desc common_io_desc[] __initdata = {
>
>  void __init pxa_map_io(void)
>  {
> +       debug_ll_io_init();
>         iotable_init(ARRAY_AND_SIZE(common_io_desc));
>  }
> --
> 1.9.0.rc3.12.gbc97e2d
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
