From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Feb 2012 14:35:57 +0100
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <20120220125054.GF22562@n2100.arm.linux.org.uk>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
 <4F3945B1.9070900@samsung.com>
 <20120220095813.GB11307@game.jcrosoft.org>
 <20120220100843.GE22562@n2100.arm.linux.org.uk>
 <20120220102231.GC11307@game.jcrosoft.org>
 <20120220125054.GF22562@n2100.arm.linux.org.uk>
Message-ID: <20120220143557.02787bad@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Feb 2012 12:50:54 +0000, Russell King - ARM Linux wrote:
> What is linux specific is specifying the _delay_ rather than specifying
> the bus frequency.  So as soon as you're trying to justify not adding
> the units because they may be linux specific, you've already lost that
> argument by using a delay rather than a bus frequency.  You can't have
> it both ways.

While I am not much into DT and did not follow this thread too
carefully... I seem to understand that the dispute is mainly on
frequency vs. udelay specification for the bus speed, Jean-Christophe
arguing that hardware-specific delays are added when changing e.g. a
GPIO pin output value and thus the frequency can't be guaranteed. Do I
get this right?

If so I would suggest that you specify neither the frequency nor
udelay, but the _maximum_ frequency. Where maximum frequency = 10^6 /
(2 * udelay) Hz. Would this make everybody happy?

Note that I2C allows clock stretching by the slaves so even without the
extra delay incurred by hardware state switching, the bus operating
frequency is already a maximum rather than a guaranteed valued.

-- 
Jean Delvare
