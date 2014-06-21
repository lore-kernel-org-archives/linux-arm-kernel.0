From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Jun 2014 21:40:26 +0100
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <53A06749.1010606@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk>
 <53A01D54.10506@collabora.co.uk>
 <20140617141254.GP5099@sirena.org.uk>
 <53A06749.1010606@collabora.co.uk>
Message-ID: <20140621204026.GH22657@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:05:29PM +0200, Javier Martinez Canillas wrote:
> On 06/17/2014 04:12 PM, Mark Brown wrote:

> >> I just looked at regulator_register() and saw that it does rdev->dev.parent =
> >> dev, so yes this has to be the MFD.

> I noticed that many drivers set config.dev = &pdev->dev. The original Chrome OS
> max77xxx driver and max77686 are two examples but others drivers do the same:

Not all drivers are DT drivers that bother specifying supplies.

> And also I see that mfd_add_device() calls
> devm_regulator_bulk_register_supply_alias(&pdev->dev,...) so I'm confused now
> about what the correct device should be...

Right, but to do that you need to set those aliases up - have you done
so?

> > Do the regulators manage to get their supplies?

> There are no current support in mainline for the devices that use the regulators
> in this PMIC so I can't tell you if consumers manage to get their supplies
> correctly (e.g: if regulator_dev_lookup succeeds).

That's not really relevant here - I'm asking if the regulators get their
own supplies rather than if anything uses them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/3900a496/attachment.sig>
