From: peda@lysator.liu.se (Peter Rosin)
Date: Sun, 4 Oct 2015 21:50:28 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <560F0DB1.2020101@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se>
Message-ID: <56118304.8020002@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-03 01:05, Peter Rosin wrote:
> I looked around and found that if I revert a839ce663b3183209fdf7b1fc4796bfe2a4679c3
> "eeprom: at24: extend driver to allow writing via i2c_smbus_write_byte_data"
> eeprom writing starts working again.
> 
> AFAICT, the i2c-at91 bus driver makes the eeprom driver use the
> i2c_transfer code path both with that patch and with it reverted,
> so I sadly don't see why the patch makes a difference.

And now when I retry the same thing, that patch is no longer affecting things.
I must have confused myself over what kernel was actually running. Christian,
please accept my deepest apologies for implicating you in this regression.

But the regression is still there. In short, linux-3.18-at91 from the
linux4sam tree works, linux-4.1-at91 from the same tree does not, and
vanilla 4.2 also doesn't work. I have a hard time bisecting this thing
though, since the last known good version has a long list of atmel
patches that I refuse to even try to rebase...

Ideas still welcome of course.

Cheers,
Peter
