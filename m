From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Nov 2015 11:09:54 +0100
Subject: [PATCH RESEND v2 3/4] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
References: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
 <1446839371-22601-4-git-send-email-kapilh@broadcom.com>
Message-ID: <CACRpkdZN-iwdR_VwktdHsw+rGQLhCgmWnERYVDE+KaYOqJR30w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 8:49 PM, Kapil Hali <kapilh@broadcom.com> wrote:

> Add SMP support for Broadcom's Northstar Plus SoC
> cpu enable method. This changes also consolidates
> iProc family's - BCM NSP and BCM Kona, platform
> SMP handling in a common file.
>
> Northstar Plus SoC is based on ARM Cortex-A9
> revision r3p0 which requires configuration for ARM
> Errata 764369 for SMP. This change adds the needed
> configuration option.
>
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>

This version looks saner to me.

> +static int nsp_write_lut(void)
> +{
> +       void __iomem *sku_rom_lut;
> +       phys_addr_t secondary_startup_phy;
> +
> +       if (!secondary_boot) {
> +               pr_warn("required secondary boot register not specified\n");
> +               return -EINVAL;
> +       }
> +
> +       sku_rom_lut = ioremap_nocache((phys_addr_t)secondary_boot,
> +                                               sizeof(secondary_boot));

Why is this address not just taken directly from the device tree?

If it is not in the device tree: why?

Also give it a sane name, bcm_sec_boot_address or so.
"secondary_boot" sounds like a function you call to boot
the second core.

Yours,
Linus Walleij
