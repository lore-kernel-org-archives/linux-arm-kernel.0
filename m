From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Mar 2012 10:39:22 -0800
Subject: [PATCH v3 07/10] arm/tegra: Add PWFM controller device tree
 probing
In-Reply-To: <20120305181555.GA22459@avionic-0098.adnet.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-8-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
 <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861C46@HQMAIL01.nvidia.com>
 <20120305181555.GA22459@avionic-0098.adnet.avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C74@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Monday, March 05, 2012 11:16 AM:
> * Stephen Warren wrote:
> > Thierry Reding wrote at Saturday, March 03, 2012 3:54 PM:
...
> > > > Could you also write binding documentation, in particular explaining
> > > > what the two pwm-cells are specifically for Tegra:
> > > >
> > > > Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > > >
> > > > (although perhaps that'd be part of the previous patch which implements
> > > > the driver)
> > >
> > > Actually for Tegra the values would be those documented in the generic
> > > binding because Tegra uses of_pwm_simple_xlate(). Does it still make sense to
> > > add a Tegra-specific binding?
> >
> > There should still be a Tegra-specific binding. Without it, there's no
> > definite way to know whether the "standard" properties actually apply,
> > or someone simply forgot to document it.
> 
> Understood. I assume that both the Tegra20 and Tegra30 variants should have
> explicit bindings then as well, right?

To date, the bindings for the two chips have been similar enough we've
only written a single bindings document that covers both. For the
different compatible values, I've been assuming that's such a base part
of standard DT usage that those differences didn't even require
documenting in the individual bindings. For example, I've written e.g.:

Required properties:
- compatible : "nvidia,tegra20-i2s"

Or:

Required properties:
- compatible: Should be "nvidia,<chip>-apbdma"

And assumed these would be expanded as appropriate by the DT author.

Of course, if there were significant bindings differences (rather than
HW differences that were largely transparent to bindings) then yes I'd
expected separate nvidia,tegra20-foo.txt and nvidia,tegra30-foo.txt.

-- 
nvpublic
