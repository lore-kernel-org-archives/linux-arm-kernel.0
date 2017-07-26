From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Jul 2017 02:07:03 +0200
Subject: [PATCH net-next 10/18] net: mvpp2: use the GoP interrupt for
 link status changes
In-Reply-To: <20170725151748.22268390@windsurf.lan>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170725151748.22268390@windsurf.lan>
Message-ID: <20170726000703.GI2860@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Jul 25, 2017 at 03:17:48PM +0200, Thomas Petazzoni wrote:
> On Mon, 24 Jul 2017 15:48:40 +0200, Antoine Tenart wrote:
> > +
> > +		port->link_irq = of_irq_get_byname(port_node, "link");
> > +		if (port->link_irq == -EPROBE_DEFER) {
> > +			err = -EPROBE_DEFER;
> > +			goto err_free_irq;
> > +		}
> > +		if (port->link_irq <= 0)
> > +			/* the link irq is optional */
> > +			port->link_irq = 0;
> 
> You need to add the irq_dispose_mapping() call corresponding to this
> of_irq_get_by_name() in the error path and in the remove path.

That's right. I'll fix that in v2.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/32027e75/attachment.sig>
