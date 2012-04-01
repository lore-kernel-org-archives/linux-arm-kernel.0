From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Apr 2012 21:22:50 +0200
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 8:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index ebc1e86..5be3248 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -2788,6 +2788,7 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
> ? ? ? ? ? ? ? ?.constraints = {
> ? ? ? ? ? ? ? ? ? ? ? ?.name = "db8500-vape",
> ? ? ? ? ? ? ? ? ? ? ? ?.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> + ? ? ? ? ? ? ? ? ? ? ? .always_on = true,
> ? ? ? ? ? ? ? ?},
> ? ? ? ? ? ? ? ?.consumer_supplies = db8500_vape_consumers,
> ? ? ? ? ? ? ? ?.num_consumer_supplies = ARRAY_SIZE(db8500_vape_consumers),

Combined with the PL022 patch this causes a power regression since
the PL022 is hereafter always on.

But I guess if I fix a power domain patch to accomplish much the
same things then nothing is really lost...

And I do like the change, if for nothing else so for the fact that it
eventually pushes to power domains what belongs there, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But to the defence: power domain code was not in the kernel
when the AMBA "vcore" regulator was introduced so how else
could we do it... except for inventing power domains...

Yours,
Linus Walleij
