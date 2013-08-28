From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 09:26:57 +0200
Subject: [PATCH] ARM: integrator: Make sure INTEGRATOR_AP depends on PCI
In-Reply-To: <20130814200442.GA20372@8bytes.org>
References: <1376509818-22163-1-git-send-email-joro@8bytes.org>
 <20130814195701.GY23006@n2100.arm.linux.org.uk>
 <20130814200442.GA20372@8bytes.org>
Message-ID: <CACRpkdZVAG=0zvLbR4E+UEjHUaYOgqUxsfGoZybPtm1DwDAJ1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:04 PM, Joerg Roedel <joro@8bytes.org> wrote:

> So when integrator does not depend on PCI this diff is more appropriate?
>
> diff --git a/arch/arm/mach-integrator/pci_v3.h b/arch/arm/mach-integrator/pci_v3.h
> index 755fd29..51738e0 100644
> --- a/arch/arm/mach-integrator/pci_v3.h
> +++ b/arch/arm/mach-integrator/pci_v3.h
> @@ -1,2 +1,9 @@
> -/* Simple oneliner include to the PCIv3 early init */
> +/* Define PCIv3 early init */
> +#ifdef CONFIG_PCI
>  extern int pci_v3_early_init(void);
> +#else
> +static inline int pci_v3_early_init(void)
> +{
> +       return 0;
> +}
> +#endif

Yes.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

And can you please create and send a proper patch with this
content to arm at kernel.org and the mailing list on CC, with
a request for the ARM SoC maintainers to apply it directly
as a fix?

You might as well add Cc: stable at vger.kernel.org as well.

Yours,
Linus Walleij
