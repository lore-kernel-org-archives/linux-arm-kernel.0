From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 26 Mar 2015 20:17:26 +0100
Subject: Need a phy function to enable / disable usb squelch detection
Message-ID: <55145B46.9020501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

I've been debugging why some devices do not work with
the musb otg controller found on Allwinner SoC-s, and the
conclusion is not good, the Android kernel does a
poke to the phy before releasing the usb reset.

Now you did not want me to introduce any sunxi specific /
private phy functions in my initial patch-series for adding
sunxi support, but in this case I do not really see an
alternative, as this is a very platform specific hack
to work around an issue with the phy-s squelch detection
which causes it to see a squelch when reset is released
switching it to high speed mode when a lo speed device
is connected, after which things fall apart.

I'm open to some generic solution for this, but I do
not see one myself.

Thanks & Regards,

Hans

p.s.

A review of my existing sun4i-usb-phy otg support work
would be appreciated, this squelch thing is best left
as a fix on top.
