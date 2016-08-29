From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Aug 2016 08:56:20 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i-q8-common: Add support for SDIO wifi
 controllers
In-Reply-To: <20160826145236.30210-4-hdegoede@redhat.com>
References: <20160826145236.30210-1-hdegoede@redhat.com>
 <20160826145236.30210-4-hdegoede@redhat.com>
Message-ID: <20160829065620.GC7612@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:52:36PM +0200, Hans de Goede wrote:
> Most of the sun8i q8 boards have an usb wifi controller, on the
> variants which use an USB wifi controller, this will result in a
> couple of error msg-s in dmesg when proving the sdio bus and
> an used mmc controller.
> 
> The best way to deal with wifi on this boards really is to simply
> let the kernel auto-detect usb or sdio wifi controllers, so we
> will just have to live with the few errors in dmesg.

No, because that grabs PINs that might or might not be supposed to be
used for that, it leaves clocks and regulators enabled, which draw
power, to no end. And that's even worth since most boards will not use
it.

You can put the definition of the nodes in the DTSI, but the final
status will have to be in the (relevant) DTS.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/b1c25ce3/attachment.sig>
