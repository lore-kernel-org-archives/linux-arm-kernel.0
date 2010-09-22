From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 22 Sep 2010 13:08:29 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100922104846.GQ32018@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Wed, 22 Sep 2010 12:48:46 +0200")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<20100922104846.GQ32018@game.jcrosoft.org>
Message-ID: <87lj6uavde.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:

Hi,

 >> Use a correct udelay value to get bus speed around 100KHz. The udelay
 >> value was most likely copied from the older devices, but the 9g45
 >> is signicantly faster (400MHz, DDR, ..), so a udelay of 2 gives a
 >> bus speed of around 190KHz, which is too fast for some devices.
 >> A udelay value of 5 gives a bus speed of around 90KHz here.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Jean-Christophe> in this case it will be better to overwite it at board
 Jean-Christophe> than force it for all of them

You don't expect most 9g45 users will run at 400MHz? It seems pretty
likely to me. In any case, a safe (but somewhat slow) default seems
better than a potentially unsafe one.

Now, I agree that it would be nice to add an interface to tweak this
delay if needed (extra argument to at91_add_device_i2c()?), but that's
next to the discussion about what the default should be.

-- 
Bye, Peter Korsgaard
