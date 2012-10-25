From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Oct 2012 11:27:56 +0100
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <CACRpkdaxUS95vPLsW0kSbPn3g0ywMg+MJhrbEJBRa4uaLvw4Fg@mail.gmail.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdaxUS95vPLsW0kSbPn3g0ywMg+MJhrbEJBRa4uaLvw4Fg@mail.gmail.com>
Message-ID: <20121025102756.GJ18814@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 08:46:38AM +0200, Linus Walleij wrote:

> Now I don't know which kernel senior being it was that told me
> never to screw around with the defaults from the boot loader
> if not really needed. It is better if the driver reads the hardware
> to figure out what state it's in and move on from there.

This depends on the platform quite a bit - there's two schools of
thought on what bootloaders should do, and typically platforms decide on
a per platform basis which they'll use:

 1. The bootloader does enough to load the kernel and nothing more, the
    kernel should ignore anything the bootloader did.  Some people
    prefer this as it places minimal reliance on the bootloader which
    may be of uncertain quality and minimises the need to upgrade the
    bootloader which is often highly risky.

 2. The bootloader does all the pin setup and so on.  This provides a
    place for board specific stuff and avoids the kernel having to know
    about lots of device variants.

For example AIUI OMAP tends towards the second view (partly due to
number of device variants) but for example Samsung platforms typically
use the first method (their pinmux is pretty simple).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/f30f4e79/attachment-0001.sig>
