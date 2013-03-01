From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Mar 2013 11:45:22 +0000
Subject: [PATCH 3/7] ARM: hs: add board support with device tree
In-Reply-To: <CAHTX3dLO6Waf7bT0Lo6AqmDQSKbt14pwjZzYzP5De8RR3btY9w@mail.gmail.com>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
 <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
 <CAHTX3dLO6Waf7bT0Lo6AqmDQSKbt14pwjZzYzP5De8RR3btY9w@mail.gmail.com>
Message-ID: <201303011145.22231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 February 2013, Michal Simek wrote:
> > +
> > +extern void __init hs_init_clocks(void);
> 
> this shouldn't be in this file. Run checkpatch.pl on it.

Right, I believe that the new CLK_OF_DECLARE macro should
take care of this. For now, you still need to call
"of_clk_init(NULL);" from platform code when using this,
but I suppose we will find a way to mvoe that into common
arch code eventually.

	Arnd
