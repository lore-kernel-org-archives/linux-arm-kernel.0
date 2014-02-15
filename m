From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 22:12:02 +0100
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <20140215135930.GA26088@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <2979047.tn4oVevojb@wuerfel> <20140215135930.GA26088@lunn.ch>
Message-ID: <201402152212.02580.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014, Andrew Lunn wrote:
> None of the _defconfig's ever turn on
> CACHE_FEROCEON_L2_WRITETHROUGH. I also did a quick google and could
> not find any usage of it.
> 
> So i see two options:
> 
> 1) Remove the wr-override from the DT binding and use
> CACHE_FEROCEON_L2_WRITETHROUGH.
> 
> 2) Remove CACHE_FEROCEON_L2_WRITETHROUGH and make proc-feroceon.S do
> the right thing at runtime.
> 
> I suspect i will go for 1), it is simpler.

Yes, fair enough. I'd hope we could just kill the option altogether,
but it's probably hard to find anyone who would remember what it
was introduced for, unless Nico knows.

Git history points to 

commit 4360bb41920ffacd4a935fa692768129ee5bef4e
Author: Ronen Shitrit <rshitrit@marvell.com>
Date:   Tue Sep 23 15:28:10 2008 +0300

    [ARM] Kirkwood: add support for L2 cache WB/WT selection
    
    Feroceon L2 cache can work in eighther write through or write back mode
    on Kirkwood. Add the option to configure this mode according to Kconfig.
    
    Signed-off-by: Ronen Shitrit <rshitrit@marvell.com>
    Signed-off-by: Nicolas Pitre <nico@marvell.com>

	Arnd
