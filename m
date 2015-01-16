From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 Jan 2015 16:52:12 +0200
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
Message-ID: <54B9259C.3070403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/01/15 01:15, Andrew Lunn wrote:
> This patchset is a driver for the TI tlc59116 16 Channel i2c LED
> driver. This driver is used on the Belkin WRT1900AC access point and
> the C code is derived from code Belkin contributed to OpenWRT.
> However it has been extensively re-written, and a device tree binding
> added to replace platform data.

We have a TLC59108 on one of our boards, and with a quick glance it
looks about the same as TLC59116, except the amount of outputs. Vignesh
wrote a driver for it and was about to send it for review.

However, Vignesh implemented it as a PWM driver. We use it for LCD
backlight (via pwm-backlight).

I'm not very familiar with LED and PWM drivers, but doesn't implementing
this as a LED driver prevent us from using it as a backlight? Whereas it
looks like PWM can be used as a led via pwm-leds (I think).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/dcd6c719/attachment.sig>
