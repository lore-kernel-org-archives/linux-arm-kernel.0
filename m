From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 16:10:59 -0800
Subject: [PATCH 19/19] omap: McBSP: Drop unnecessary status/error bit
	clearing on reg_cacheretrieved register values
In-Reply-To: <20100312000059.GY2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100312000059.GY2900@atomide.com>
Message-ID: <20100312001058.GA2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100311 16:04]:
> From eee91441bf26c6ea88656eb9866e706b1e07d30b Mon Sep 17 00:00:00 2001
> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Date: Tue, 23 Feb 2010 15:50:38 +0000
> Subject: [PATCH] omap: McBSP: Drop unnecessary status/error bit clearing on reg_cacheretrieved register values
> 
> The MsBSP register cache will never have any error/status flags set, since
> these flags are never written to the reg_cache. So it is kind of not
> necessary to clear these flags, which are actually always 0.
> 
> In other words, clearing the status/error flags are not necessary, since the
> reg_cache will never got these bits set. We can just write back the
> register content from the cache as it is when clearing an error condition.
> 
> Tested on Amstrad Delta.

And this one is really patch 18/19. Sorry again.

Tony
