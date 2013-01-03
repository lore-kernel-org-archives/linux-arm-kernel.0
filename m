From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Jan 2013 11:33:29 -0800
Subject: [PATCH] ARM: OMAP1: fix USB configuration use-after-release
In-Reply-To: <1356123392-6172-1-git-send-email-aaro.koskinen@iki.fi>
References: <1356123392-6172-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130103193329.GF25633@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [121221 12:59]:
> All boards, except Amstrad E3, mark USB config with __initdata.
> 
> As a result, when you compile USB into modules, they will try to refer
> already released platform data and the behaviour is undefined. For example
> on Nokia 770, I get the following kernel panic when modprobing ohci-hcd:

Thanks applying into omap-for-v3.8-rc2/fixes.

Tony
