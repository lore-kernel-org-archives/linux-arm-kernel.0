From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Sep 2014 10:58:36 +0200
Subject: [RFC 0/4] i2c: slave support framework for Linux devices
In-Reply-To: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140912085836.GS3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Tue, Sep 09, 2014 at 04:54:26PM +0200, Wolfram Sang wrote:
> Finally, here is my take on the often desired feature that Linux can not only
> be an I2C master, but also an I2C slave. Compared to my draft sent out last
> week, this RFC has been tested on hardware (Renesas Lager board) and works \o/
> 
> One big part still missing is documentation, so brave ones need to "use the
> source". However, this approach turned out to be even less intrusive than
> expected, so that is hopefully a good sign.
Some thoughts from reading through your patch set:

- If I understand correctly you cannot register an i2c slave without
  also registering a master, right? I don't think this is troubling in
  practice, is it?
  For abstraction I would prefer to make these different concepts
  though.

- The IMHO most (even only?) useful slave is "i2cslvdev", i.e. a
  userspace device. With that you wouldn't need device tree stuff, the
  driver would just offer the device if supported. Userspace then could
  care about the rest (slave address, functionality, ...).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
