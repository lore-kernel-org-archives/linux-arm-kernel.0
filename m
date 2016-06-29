From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 14:10:21 +0200
Subject: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
In-Reply-To: <60021467122182@web19j.yandex.ru>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather> <60021467122182@web19j.yandex.ru>
Message-ID: <20160629121021.GD6095@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2016 at 09:56:22PM +0800, Icenowy Zheng wrote:
> The reason for a dedicate driver is:
> 1. This IP have only thermal function, so it's not suitable to use a
> driver at drivers/input/touchscreen/.

That's not a problem, and it's being worked on [1].

> 2. Control Register are quite different.

That's not a problem either, there's just a bit that you don't need to
set in the control 1 register, and that's pretty much it. It doesn't
justify a whole new driver.

> 3. This IP uses AUDIO PLL (PLL2) as its clock!

It's listed as the input, but all the rest of the documentation refers
only to 24MHz, which seems to indicate that it's only running on the
oscillator, which would make much more sense.

Thanks,
Maxime

1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/439487.html

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/2fa032a7/attachment-0001.sig>
