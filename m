From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 08:47:27 -0700
Subject: [RFC PATCH 08/12] gpio/tegra: Add device tree support
In-Reply-To: <CAAfyv34kOtwjerB0gMhEKNTwGd9w-LCE52MCUuvzTyYkXLY-dg@mail.gmail.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-9-git-send-email-swarren@nvidia.com>
	<CAAfyv34kOtwjerB0gMhEKNTwGd9w-LCE52MCUuvzTyYkXLY-dg@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25048@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Belisko Marek wrote at Saturday, August 13, 2011 3:49 AM:
> On Sat, Aug 13, 2011 at 12:54 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > ?drivers/gpio/gpio-tegra.c | ? 31 +++++++++++++++++++++++++++++++
> > ?1 files changed, 31 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
...
> > +static void __init tegra_gpio_probe_dt(struct platform_device *pdev)
> > +{
> > + ? ? ? const __be32 *gpios;
> > + ? ? ? u32 gpioslen;
> > + ? ? ? int i;
> > +
> > + ? ? ? gpios = of_get_property(pdev->dev.of_node, "nvidia,gpios", &gpioslen);
> > + ? ? ? if (gpios == NULL)
> > + ? ? ? ? ? ? ? return;
> > +
> > + ? ? ? gpioslen /= sizeof(*gpios);
> > + ? ? ? for (i = 0; i < gpioslen; i++, gpios++) {
> > + ? ? ? ? ? ? ? u32 gpio = be32_to_cpup(gpios);
> > + ? ? ? ? ? ? ? dev_err(&pdev->dev, "Enabling GPIO %d\n", gpio);
>
> Is really necessary to print all enabled gpio's to console? Also seen
> same in pinmux probe.

Oops, that's certainly not necessary. That was debugging code, and I meant
to convert to dev_dbg before posting.

-- 
nvpublic
