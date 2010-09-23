From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 23 Sep 2010 13:32:20 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100923111604.GZ32018@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Thu, 23 Sep 2010 13:16:04 +0200")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
	<87fwx0ahgl.fsf@macbook.be.48ers.dk>
	<20100923103645.GA23295@n2100.arm.linux.org.uk>
	<877hicafx5.fsf@macbook.be.48ers.dk>
	<20100923111604.GZ32018@game.jcrosoft.org>
Message-ID: <87zkv88zln.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:

Hi,

 >> And yes, if you run the SoC at nonstandard (slower) speed this might be
 >> slower than 100Khz, but that's still safe, so not a big deal.

 Jean-Christophe> except you can also overclock the SoC in some case so
 Jean-Christophe> it's still not safe

Sure, you can do lots of crazy stuff. Instead of discussion this back
and forward, do you agree that udelay=5 is better/safer/more sensible
than the current udelay=2 value?

 Jean-Christophe> and force this speed for all boards :(

Just like it has always been.

 Jean-Christophe> so specify the speed in the board is the right way to
 Jean-Christophe> fix the current issue

I disagree. The problem is that the I2C speed was forced to run too
fast, against what the comment says and the knowledge that some devices
don't support fast/highspeed i2c.

 Jean-Christophe> as you may find some stupid i2c chip that does not
 Jean-Christophe> work at 100kHz (some low cost MCU as example)

If they don't work at 100KHz, then they most likely don't work at 185KHz
either, so that's not a regression.

-- 
Bye, Peter Korsgaard
