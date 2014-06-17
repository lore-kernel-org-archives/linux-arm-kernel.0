From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Jun 2014 15:12:54 +0100
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <53A01D54.10506@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk>
 <53A01D54.10506@collabora.co.uk>
Message-ID: <20140617141254.GP5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 12:49:56PM +0200, Javier Martinez Canillas wrote:
> On 06/16/2014 09:25 PM, Mark Brown wrote:

> >> +	config.dev = &pdev->dev;

> > Are you sure this shouldn't be the MFD?

> I just looked at regulator_register() and saw that it does rdev->dev.parent =
> dev, so yes this has to be the MFD.

Do the regulators manage to get their supplies?

> So, for now I thought it made sense to set the operating mode to normal on
> probe() but I'll change it to read from the hardware if that is better.

Yes, otherwise if the device is configured otherwise then when we change
the configuration we may break something.

> I guess I should check in the datasheet if a sane default operating mode for
> LDOs is expected when the chip is reseted or if this is left undefined and also
> if the bootloader already set this.

You can't do anything based on the particular bootloader you're using in
your current system, this has to work in other systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/62f9e425/attachment-0001.sig>
