From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Apr 2014 17:18:13 +0100
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
Message-ID: <20140411161813.GF28800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 03:04:32PM +0200, Carlo Caione wrote:
> On Fri, Apr 11, 2014 at 2:29 PM, Mark Brown <broonie@kernel.org> wrote:

> >> +                             regulators {
> >> +                                     compatible = "x-powers,axp20x-reg";

> > This compatible isn't part of the driver.

> Yes I know. The problem here is that in v4 I had to fill in the field
> .of_compatible of the mfd_cell with "x-powers,axp20x-reg". This
> because the regulator_dev_lookup() checks for dev->of_node when
> looking for the supply so I needed the compatible string in the DT to
> have the dev->of_node filled in by mfd_add_device().
> What do you suggest? Modify the regulator driver?

You're looking for regulator_bulk_register_supply_alias() in the MFD
driver (via parent_supplies in the MFD cell probably).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/7b11da57/attachment.sig>
