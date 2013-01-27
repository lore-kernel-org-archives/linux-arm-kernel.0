From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 16:28:37 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <51050B9E.8000605@gmail.com>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
 <20130126235037.GV1758@titan.lakedaemon.net>
 <20130127013131.GA2400@schnuecks.de> <5104FE5F.2040804@gmail.com>
 <20130127105654.GA23127@schnuecks.de> <51050B9E.8000605@gmail.com>
Message-ID: <20130127152837.GI29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Except for loosing the MAC address, I disagree. From a "clock gating"
> point-of-view all kirkwoods (except that crippled one on keymile board)
> are the same. Even if there is no/one/two ethernet _jacks_ on a specific
> board you still want to disable all _unused_ ethernet modules inside the
> SoC.
> 
> We should find a way to retain the MAC address and in the meantime we
> can add a "always prepare ge clocks" workaround in
> kirkwood_clk_legacy_init().

Hi Sebastian

I've been thinking the same, store the MAC address before turning the
clock off and restore it when enabling the clock. We have a need for
special clocks on kirkwood anyway for turning off the sata and pcie
PHYs. So adding special clocks for ethernet is not too big a deal.

      Andrew
