From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed, 10 Dec 2014 21:08:05 +0100
Subject: [PATCH v2] irqchip: mediatek: Use IS_ERR() instead of NULL
 pointer check
In-Reply-To: <20141210125313.GJ22670@titan.lakedaemon.net>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
 <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
 <20141210121442.GA14485@gmail.com>
 <20141210125313.GJ22670@titan.lakedaemon.net>
Message-ID: <20141210200805.GA17513@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 07:53:13AM -0500, Jason Cooper wrote:
> On Wed, Dec 10, 2014 at 01:14:43PM +0100, Beniamino Galvani wrote:
> > On Wed, Dec 10, 2014 at 05:55:02PM +0800, Yingjoe Chen wrote:
> > > Beniamino reported a kernel oops caused by an invalid DT file for the
> > > mediatek interrupt polarity extension.
> > > 
> > > The reason is that the interrupt polarity support for mediatek chips
> > > merely checks for NULL pointer instead of a casted error return
> > > value in mtk_sysirq_of_init() so any other casted error value passes
> > > the NULL pointer check and causes a kernel panic when dereferenced.
> > > 
> > > Use IS_ERR() and return the error value via PTR_ERR().
> > > 
> > > Reported-and-tested-by: Beniamino Galvani <b.galvani@gmail.com>
> > 
> > Well, actually I only reported the bug and didn't do any test. Can the
> > "-and-tested" portion of the tag be dropped while applying the patch?
> 
> I'd prefer that it be tested before applying.  Would you mind confirming
> that the oops is gone with this patch applied?

Probably the commit message is misleading about this, but I don't own
any Mediatek device and never used the driver. I only reported [1] a
possible bug in the driver found through code analysis.

Anyway, I suppose that the tests done by Yingjoe are enough to get the
patch merged.

Beniamino

[1] https://lkml.org/lkml/2014/11/29/105
