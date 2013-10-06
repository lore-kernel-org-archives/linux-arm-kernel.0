From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Oct 2013 23:35:36 +0200
Subject: [PATCH] clk: provide public clk_is_enabled function
In-Reply-To: <5251E334.2070008@gmail.com>
References: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131005202430.GI10079@pengutronix.de>
 <20131005204208.GB28106@lunn.ch>
 <20131006090609.GK14747@book.gsilab.sittig.org>
 <20131006163011.GA30818@lunn.ch> <5251BD09.3050900@gmail.com>
 <20131006200223.32214.4440@quantum> <5251E334.2070008@gmail.com>
Message-ID: <20131006213536.GC30818@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Andrew has mentioned, that some bootloaders might disable clocks but
> leave the nodes enabled. Reading those registers would lock up
> the HW, of course. So we thought about to check clk gate status first,
> which this patch is about.
> 
> Of course, we can do clk_enable, read, clk_disable as said before - and
> given the amount of questions and misinterpretation, I think it is the
> saner way.

Hi Sebastian

I agree. As you say, too many people have asked questions or
misinterpretation what is happening, so lets go for the simpler method
people can understand.

I would also suggest in the ethernet driver, maybe set_params(), check
if we have a valid MAC address, and if not, issue a warning and call
to eth_hw_addr_random(dev) to get a random one.

   Andrew
