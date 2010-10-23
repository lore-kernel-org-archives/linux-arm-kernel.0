From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 23 Oct 2010 09:07:34 +0800
Subject: [PATCH] pxafb: correct the vertical back porch macro
In-Reply-To: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
References: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
Message-ID: <AANLkTinb3hNdp5evit9Ga0Z-gLCfPrPzE1VdCvwQVB3o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 23, 2010 at 5:26 AM, Matt Reimer <mreimer@sdgsystems.com> wrote:
> Fix an off-by-one bug in the LCCR2_BegFrmDel() macro. The vertical back porch
> knob LCCR2[BFW] specifies the number of clock periods minus one, but the
> macro wasn't doing the subtraction.
> ---
> ?arch/arm/mach-pxa/include/mach/regs-lcd.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
> index f82dcea..5074d18 100644
> --- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
> +++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
> @@ -107,7 +107,7 @@
> ?#define LCCR2_EndFrmDel(Tln) ? ((Tln) << FShft (LCCR2_EFW))
>
> ?#define LCCR2_BFW ? ? ?Fld (8, 24) ? ? /* Beginning-of-Frame line clock */
> -#define LCCR2_BegFrmDel(Tln) ? ((Tln) << FShft (LCCR2_BFW))
> +#define LCCR2_BegFrmDel(Tln) ? (((Tln) - 1) << FShft (LCCR2_BFW))

Nothing in the spec suggests that this minus 1 is necessary. Could you please
double check?

>
> ?#define LCCR3_API ? ? ?(0xf << 16) ? ? /* AC Bias pin trasitions per interrupt */
> ?#define LCCR3_API_S ? ?16
> --
> 1.7.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
