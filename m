From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 12:11:32 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502100225.GB24211@n2100.arm.linux.org.uk>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <20120502095816.GG20478@pengutronix.de>
 <20120502100225.GB24211@n2100.arm.linux.org.uk>
Message-ID: <20120502101132.GW4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 11:02:25AM +0100, Russell King - ARM Linux wrote:
> > 
> > There is a mux->hw.init = &init missing here.
> 
> What happens to mux->hw.init long term?  Because once this function
> returns, that pointer will no longer be valid.

It's not used after clk_register, so everything should be fine.

> It would be a good
> idea to NULL it out in clk_register() once its done with, to ensure
> that no one comes up with the idea of using it later.

Enforcing this is a good idea.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
