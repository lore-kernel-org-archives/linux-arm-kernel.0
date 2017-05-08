From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 8 May 2017 19:41:04 +0800
Subject: [RFC PATCH 2/3] clk: add managed version of clk_bulk_get
In-Reply-To: <20170422025837.GU7065@codeaurora.org>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-3-git-send-email-aisheng.dong@nxp.com>
 <20170413143727.GE24254@b29396-OptiPlex-7040>
 <20170422025837.GU7065@codeaurora.org>
Message-ID: <20170508114104.GD18153@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 07:58:37PM -0700, Stephen Boyd wrote:
> On 04/13, Dong Aisheng wrote:
> > On Wed, Apr 12, 2017 at 12:03:28PM +0800, Dong Aisheng wrote:
> > 
> >    drivers/built-in.o: In function `devm_clk_bulk_get':
> > >> (.text+0x1930e): undefined reference to `clk_bulk_get'
> >    drivers/built-in.o: In function `devm_clk_bulk_release':
> > >> clk-devres.c:(.text+0x19370): undefined reference to `clk_bulk_put'
> > 
> > clk_bulk_get is defined in clkdev.c which depends on CONFIG_CLKDEV_LOOKUP.
> > However, some platforms like m68k may not select CLKDEV_LOOKUP but
> > select HAVE_CLK. Thus compiling devm_clk_bulk_get may cause a undefined
> > reference to 'clk_bulk_get'.
> > 
> > Since clk_bulk_get is built upon the platform specific clk_get api,
> > clk_bulk_get can also be used by that platform accordingly.
> > 
> > Then we probably could move clk_bulk_get into clk-devres.c as well which
> > is controlled by common CONFIG_HAVE_CLK to benifit all platforms.
> 
> clk-devres is for devm* things. I'd just make another file for
> now, clk-bulk.c or something like that. When everyone moves to
> common clk, we can fold it into clk.c, or not because clk.c is
> rather large right now.
> 

Thanks for the suggestion.
Much agree with you that getting a new file to handle them is better.
Will do them in clk-bulk.c first.

Regards
Dong Aisheng

> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
