From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 14 Jun 2012 09:31:49 +0200
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de> (Wolfram
 Sang's message of "Wed, 13 Jun 2012 23:12:10 +0200")
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <87ehpiwdqy.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Wolfram" == Wolfram Sang <w.sang@pengutronix.de> writes:

 Wolfram> Currently, every driver has to do it on its own, but it should
 Wolfram> be done in the core, like we already do with board_info
 Wolfram> structs.

 Wolfram> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
 Wolfram> ---

 Wolfram> Based on v3.5-rc2. Only build tested, I don't have a OF based device
 Wolfram> around at the moment.

Neither have I, but it looks good.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 Wolfram> @Peter: Why does ocores do the device registration manually via
 Wolfram> platform_data instead of using board_info?

Because of dd14be4c274 (i2c-ocores: Can add I2C devices to the bus), a
patch I wasn't CC'ed on and haven't acked. I only noticed it later when
the I2C tree got merged into mainline.

-- 
Bye, Peter Korsgaard
