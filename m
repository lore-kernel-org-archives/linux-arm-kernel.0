From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Aug 2017 13:12:43 +0200
Subject: linux-next 2017-08-08 keyboard failure on Nokia N900
In-Reply-To: <20170808103444.GA18247@amd>
References: <20170808101756.GA12922@amd>
 <20170808103444.GA18247@amd>
Message-ID: <20170808111243.GA20328@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I tried today's linux-next. It boots on n900 (up to X), but then my
> > screen locks and I can't get back. Touchscreen worked, so my guess is
> > keyboard does not...? Ssh connection over usb still works.
> 
> Confirmed, its the keyboard.
> 
> Additionally, battery monitoring fails, because neither
> 
> /sys/class/power_supply/{n900-,rx51-}battery/voltage_now
> 
> exists.

And dmesg is helpful in this case:

[    0.675201] input: twl4030_pwrbutton as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl at 48:pwrbutton/input/input1
[    0.676635] input: TWL4030 Keypad as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl at 48:keypad/input/input2
[    0.679138] twl4030_keypad 48070000.i2c:twl at 48:keypad: request_irq
failed for irq no=156: -13
[    0.679779] twl4030_keypad: probe of 48070000.i2c:twl at 48:keypad
failed with error -13
[    0.682769] twl4030_madc 48070000.i2c:twl at 48:madc: could not
request irq
[    0.684051] twl4030_madc: probe of 48070000.i2c:twl at 48:madc failed
with error -13
[    0.685852] input: twl4030:vibrator as
/devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl at 48:audio/twl4030-vibra/input/input3
[    0.768890] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/8265f7f0/attachment.sig>
