From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 17:22:26 +0200
Subject: [PATCH v4 1/2] phy-sun4i-usb: Add full support for usb0 phy / OTG
In-Reply-To: <556C25B7.80708@redhat.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <1433088626-8858-2-git-send-email-hdegoede@redhat.com>
 <20150601092249.GF17267@lukather> <556C25B7.80708@redhat.com>
Message-ID: <20150602152226.GB23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 01, 2015 at 11:28:23AM +0200, Hans de Goede wrote:
> On 01-06-15 11:22, Maxime Ripard wrote:
> >On Sun, May 31, 2015 at 06:10:25PM +0200, Hans de Goede wrote:
> >>+	/* We either want both gpio pins or neither (when in host mode) */
> >>+	if (!data->id_det_gpio != !data->vbus_det_gpio) {
> >>+		dev_err(dev, "failed to get id or vbus detect pin\n");
> >>+		return -ENODEV;
> >>+	}
> >
> >The fact that the driver expects both to be set if one is should be in
> >the binding documentation.
> 
> That would be behavior description, and I've always been told that the
> binding should only document the hardware description, not the behavior.

Yes, that's true, but here it looks more like there's no point of
having one without the other.

Pretty much like interrupt-parent and interrupt. A single one doesn't
really make much sense without the other.

And I don't think saying that you would need some additional
properties when in device mode rather than in host mode is really
documenting a behaviour. It does change things at a hardware level
too.

> Also this may change in the future as we add support for more boards,
> e.g. the cubieboard seems to be unable to turn vbus off ever, so vbus-det
> will always read as 1 / high, making it rather useless. This is something
> which I still need to figure out how to deal with.

We can always figure it out in due time.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/dde4cac1/attachment.sig>
