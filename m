From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Sep 2012 16:58:25 +0800
Subject: [PATCH] ARM: PRIMA2: rstc: use of_property_read_u32 to replace
 of_get_property and be32_to_cpup
In-Reply-To: <1345702192-1153-1-git-send-email-Barry.Song@csr.com>
References: <1345702192-1153-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4y+jCmE7V2ANySQAacgkA9DwoV+TX25O-7coSB1WONVhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/23 Barry Song <Barry.Song@csr.com>:
> From: Barry Song <Baohua.Song@csr.com>
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Olof, would you apply this or you want me to send a pull request for it?

> ---
>  arch/arm/mach-prima2/rstc.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index 762adb7..d03ff19 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -42,13 +42,10 @@ early_initcall(sirfsoc_of_rstc_init);
>
>  int sirfsoc_reset_device(struct device *dev)
>  {
> -       const unsigned int *prop = of_get_property(dev->of_node, "reset-bit", NULL);
> -       unsigned int reset_bit;
> +       u32 reset_bit;
>
> -       if (!prop)
> -               return -ENODEV;
> -
> -       reset_bit = be32_to_cpup(prop);
> +       if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
> +               return -EINVAL;
>
>         mutex_lock(&rstc_lock);
>
> --
> 1.7.0.4
>

-barry
