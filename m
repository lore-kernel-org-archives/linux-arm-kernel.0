From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 12 Feb 2016 11:24:38 -0800
Subject: [PATCH linux-next v2 01/14] mtd: spi-nor: remove
 micron_quad_enable()
In-Reply-To: <56B1E1A5.9060902@atmel.com>
References: <A765B125120D1346A63912DDE6D8B6310BF57A75@NTXXIAMBX02.xacn.micron.com>
 <56B1E1A5.9060902@atmel.com>
Message-ID: <20160212192438.GD21465@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 12:16:53PM +0100, Cyrille Pitchen wrote:

> So in its current state, micron_quad_enable() prevents us from using Micron
> memories for Quad SPI operations. Some code is missing to make it work.

TL;DR: the original code adding micron_quad_enable() was broken and
should never have been merged (sorry, my bad). Next time, please test
your changes Bean.

> As I said in the patch description, using the SPI 4-4-4 protocol is not
> relevant for MTD usage. It would be worth for XIP operations but this is not the
> purpose of the spi-nor driver.

I'm not completely opposed to using it, if someone can support it well,
test it, and prove it actually provides real benefits. But none of the
above have been satisfied yet.

Regards,
Brian
