From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Feb 2014 15:56:13 +0100
Subject: [PATCH 2/2] ehci-platform: Change compatible string from
 usb-ehci to ehci-platform
In-Reply-To: <52FA4118.2030100@redhat.com>
References: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
 <1392127826-31290-3-git-send-email-hdegoede@redhat.com>
 <52FA3B2B.7050906@ti.com> <52FA4118.2030100@redhat.com>
Message-ID: <20140212145613.GA9812@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 04:26:16PM +0100, Hans de Goede wrote:
> > I'm even OK with removing "usb-ehci" and "usb-ohci" compatibles
> > from all OMAP dts files since they aren't really compatible with
> > the original PPC driver.
> 
> I don't think that is necessary, as your grep has shown there are a
> lot of dts files using compatible = "foo", "usb-?hci"; and some may
> even have the dts in firmware, so we should simply make sure not to
> break such dts.

For these devices, we can't do much, but at least for the DT that are
in Linux, relying on the fact that there is no driver having a
compatible of "usb-ehci" to work looks very fragile. I'd be in favour
of removing it from the OMAP DTs, and every affected DTs.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/bac7bc59/attachment.sig>
