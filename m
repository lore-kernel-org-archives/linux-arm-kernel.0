From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Sep 2015 09:01:28 +0100
Subject: [PATCH v4 1/9] drivers/of: Introduce of_node_alloc
In-Reply-To: <5609C43E.1040106@gmail.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
 <1443458582-7497-2-git-send-email-marc.zyngier@arm.com>
 <5609C43E.1040106@gmail.com>
Message-ID: <20150929090128.4647f27a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Sep 2015 15:50:38 -0700
Frank Rowand <frowand.list@gmail.com> wrote:

> On 9/28/2015 9:42 AM, Marc Zyngier wrote:
> > We want to be able to generate "fake" device nodes that can be
> > used as an identifier for irq domains. For that, we reuse the
> > dynamic DT layer in order to generate DT nodes in a detached state
> > (so that it doesn't interfere with the rest of the tree).
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/of/dynamic.c | 22 ++++++++++++++++++++++
> >  include/linux/of.h   |  5 +++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 53826b8..709d363 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -445,6 +445,28 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
> >  	return NULL;
> >  }
> >  
> > +/**
> > + * of_node_alloc() - Allocate an empty device node dynamically.
> > + * @fmt: Format string (plus vargs) for new full name of the device node
> > + *
> > + * Create an device tree node, either by by allocating an empty one
> 
>       Create a device tree node by allocating an empty one

Ah! Thanks!

	M.
-- 
Jazz is not dead. It just smells funny.
