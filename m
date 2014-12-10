From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 10 Dec 2014 21:55:54 +0800
Subject: [PATCH v2] irqchip: mediatek: Use IS_ERR() instead of NULL
 pointer check
In-Reply-To: <20141210125313.GJ22670@titan.lakedaemon.net>
References: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
 <1418205302-22531-1-git-send-email-yingjoe.chen@mediatek.com>
 <20141210121442.GA14485@gmail.com>
 <20141210125313.GJ22670@titan.lakedaemon.net>
Message-ID: <1418219755.21309.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-10 at 07:53 -0500, Jason Cooper wrote:
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

Hi,

I'm not sure if that count, but I tested with incorrect DTS node
with/without the patch, to make sure the oops is gone with the patch.

Please note this driver is necessary to boot and kernel uart driver,
even without the oops you still can't boot to shell and you'll need
earlyprintk to see the error message.

Joe.C
