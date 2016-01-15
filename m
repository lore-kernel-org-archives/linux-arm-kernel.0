From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Jan 2016 11:22:25 -0800
Subject: [PATCH v3 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
In-Reply-To: <56994640.3090704@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-3-git-send-email-kishon@ti.com>
 <56994640.3090704@ti.com>
Message-ID: <20160115192224.GD3904@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [160115 11:20]:
> On 01/14/2016 08:11 AM, Kishon Vijay Abraham I wrote:
> > Create platform data for PCIe and populate it with function
> > pointers to perform assert and deassert of PCIe reset lines.
> > The PCIe driver can use the callbacks provided here to
> > reset the PCIe.
> > This will be removed once the reset contoller driver is
> > available to reset PCIe.
...

> > +/**
> > + * struct pci_dra7xx_platform_data - platform data specific to pci in dra7xx
> > + * @reset_name: name of the reset line
> > + * @assert_reset: callback for performing assert reset operation
> > + * @deassert_reset: callback for performing deassert reset operation
> > + */
> > +struct pci_dra7xx_platform_data {
> > +	const char *reset_name;
> > +
> > +	int (*assert_reset)(struct platform_device *pdev, const char *name);
> > +	int (*deassert_reset)(struct platform_device *pdev, const char *name);
> > +};

I doubt this platform_data is dra7 specific. I believe it's
the same PCI controller that has been in the omap variants for
years?

Regards,

Tony
