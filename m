From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Feb 2016 13:47:44 -0500 (EST)
Subject: [PATCH v3 1/2] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <56CD960D.3000900@ti.com>
Message-ID: <Pine.LNX.4.44L0.1602241345350.3812-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2016, Roger Quadros wrote:

> Hi,
> 
> On 24/02/16 13:15, Hans de Goede wrote:
> > From: Reinder de Haan <patchesrdh@mveas.com>
> > 
> > At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
> > reset lines, the controller will not initialize while the reset for
> > its companion is still asserted, which means we need to de-assert
> > 2 resets for the controller to work.
> > 
> > Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>

> > -	} else {
> > -		err = reset_control_deassert(priv->rst);
> > -		if (err)
> > -			goto err_put_clks;
> > +		for (rst = 0; rst < EHCI_MAX_RESETS; rst++) {
> > +			priv->resets[rst] =
> > +				devm_reset_control_get_shared_by_index(
> > +								&dev->dev, rst);

Ugly continuation line.  The convention in these files is to indent 
continuation lines by two tab stops beyond the original source line.
Same comment applies to the 2/2 patch.

Once that is changed, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

to both.

Alan Stern
