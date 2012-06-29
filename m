From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 29 Jun 2012 14:22:01 -0600 (MDT)
Subject: [PATCH v2 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <1340786915-29507-3-git-send-email-rnayak@ti.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com>
 <1340786915-29507-3-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1206291420480.2338@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 27 Jun 2012, Rajendra Nayak wrote:

> Moving to Common clk framework for OMAP would mean we no longer use
> internal lookup mechanism like omap_clk_get_by_name().
> get rid of all its usage mostly from hwmod and omap_device
> code.
> 
> Also use IS_ERR_OR_NULL() for error checking.
> 
> Moving to clk_get() also means the respective platforms
> need the clkdev tables updated with an entry for all clocks
> used by hwmod to have clock name same as the alias.
> 
> Based on original changes from Mike Turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

As originally misattributed to patch 1, this patch generates checkpatch 
warnings:

http://marc.info/?l=linux-omap&m=134100139702775&w=2

Please fix.


- Paul
