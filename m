From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 6 Jan 2017 03:46:58 +0100
Subject: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
In-Reply-To: <CAAEAJfBeu7Z_JeM55Tyj4a2ZOxNWhq7qoPDwFyftoO8sCumVQw@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
 <CAAEAJfBeu7Z_JeM55Tyj4a2ZOxNWhq7qoPDwFyftoO8sCumVQw@mail.gmail.com>
Message-ID: <20170106024657.y72pxkh6xeexwpp4@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 05, 2017 at 02:34:48PM -0300, Ezequiel Garcia wrote:
> > +static int axp20x_power_probe(struct platform_device *pdev)
> > +{
> > +       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> > +       struct axp20x_batt_ps *axp20x_batt;
> > +       struct power_supply_config psy_cfg = {};
> > +
> 
> To be consistent with the AC power supply and USB power supply,
> you might want to call of_device_is_available() here.
> Otherwise, the device probes even if "disabled" in the DTS.

I would expect that check in the mfd code. Probe should not be
called at all if the sub-device is disabled.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/306245c1/attachment.sig>
