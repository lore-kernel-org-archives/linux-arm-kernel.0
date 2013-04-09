From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 00:43:11 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.9
In-Reply-To: <201304091734.30298.arnd@arndb.de>
References: <51643279.7050200@samsung.com> <201304091734.30298.arnd@arndb.de>
Message-ID: <5164370F.6020503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/13 00:34, Arnd Bergmann wrote:
> On Tuesday 09 April 2013, Kukjin Kim wrote:
>> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
>
>> ----------------------------------------------------------------
>> Sylwester Nawrocki (2):
>>         ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
>>         ARM: S3C24XX: Fix interrupt pending register offset of the EINT
>> controller
>
>
> I got a conflict merging this into the for-next branch, which has earlier
> patches. Please confirm that the resolution below is correct.
>
Yes, your resolution is correct.

Thanks.

- Kukjin

>
> diff --cc arch/arm/mach-s3c24xx/irq.c
> index 8296d94,d8ba9be..7f56a93
> --- a/arch/arm/mach-s3c24xx/irq.c
> +++ b/arch/arm/mach-s3c24xx/irq.c
> @@@ -498,9 -500,10 +498,9 @@@ struct s3c_irq_intc *s3c24xx_init_intc(
>                  base = (void *)0xfd000000;
>
>                  intc->reg_mask = base + 0xa4;
> -               intc->reg_pending = base + 0x08;
> +               intc->reg_pending = base + 0xa8;
>   -              irq_num = 20;
>   +              irq_num = 24;
>                  irq_start = S3C2410_IRQ(32);
>   -              irq_offset = 4;
>                  break;
>          default:
>                  pr_err("irq: unsupported controller address\n");
>
> --
