From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 14:34:09 +0100
Subject: [PATCH] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
In-Reply-To: <1512644748-14491-1-git-send-email-jagan@amarulasolutions.com>
References: <1512644748-14491-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171207133409.cpp7wxx4yflkgavp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 07, 2017 at 04:35:48PM +0530, Jagan Teki wrote:
> Add usb otg support for orangepi-zero-plus2 board:
> - Add usb_otg node with dr_mode as 'otg'
> - USB0-IDDET connected to PA21
> - VBUS connected through DCIN which always on
> 
> Tested mass storage function.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Did you test the OTG or peripheral modes?

> Note: Anyone please check vbus connection [1]
> Since it is connected through DCIN of vcc-5v, I've added vcc-5v0
> regulator for the same and attached to usb0_vbus-supply but it is
> disabling during kernel boot.
> [    1.887854] vcc5v0: disabling

VBUS is the power line that is provided on the USB connector. In
peripheral, that power is provided by the host, therefore it needs to
be shutdown on the peripheral end. This is the expected behaviour.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/372d069a/attachment.sig>
