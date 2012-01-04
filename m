From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Jan 2012 09:58:24 +0900
Subject: linux-next: interesting merges in the arm-soc tree
In-Reply-To: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
References: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
Message-ID: <01bc01ccca7b$f6483fe0$e2d8bfa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Rothwell wrote:
> 
> Hi all,
> 
Hi,

> I noticed that the arm-soc tree has merged in the v4l-dvb and the
> slave-dma trees today.   Is there some good reason for this?  It fixes a

I did slave-dma...

Yes, I have created branch for samsung dma on top of slave-dma tree. Because
samsung tree touched drivers/dma/pl330.c for samsung device tree then the
arch/arm/common/pl330.c file have been merged into drivers/dma/pl330.c with
touching samsung stuff and of course there are changes of
drivers/dma/pl330.c in slave-dma as well. So I did...

> few conflicts (but that is not excuse) and there may be dependencies in a
> driver on the v4l-dvb tree (but maybe that means that that driver should
> be merged via the v4l-dvb tree - it looks like the "at91/drivers" is
> based on the v4l-dvb tree, so probably doesn't depend on anything else on
> the arm-soc tree).
> 
> If nothing else, are you sure that neither of those merged trees will
> rebase?  You have also just inherited any bugs in those two trees.

I know, Vinod knows I merged his tree for above situation so he will not
rebase that and Arnd will send that after merging of slave-dma into mainline
during merge window. So I think, we will not see any problem. :) But if
wrong, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
