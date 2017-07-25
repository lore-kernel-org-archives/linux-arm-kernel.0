From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 25 Jul 2017 10:45:58 +0200
Subject: [PATCH net-next 09/18] net: mvpp2: use named interrupts
In-Reply-To: <80d4b082-a5ed-73da-0634-8295996dc29d@cogentembedded.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-10-antoine.tenart@free-electrons.com>
 <80d4b082-a5ed-73da-0634-8295996dc29d@cogentembedded.com>
Message-ID: <20170725084558.GB2860@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Jul 24, 2017 at 07:49:03PM +0300, Sergei Shtylyov wrote:
> On 07/24/2017 04:48 PM, Antoine Tenart wrote:
> > +	if (of_get_property(port_node, "interrupt-names", NULL)) {
> > +		port->irq = of_irq_get_byname(port_node, "rx-shared");
> > +		if (port->irq <= 0) {
> > +			err = (port->irq == -EPROBE_DEFER) ?
> > +			      -EPROBE_DEFER : -EINVAL;
> 
>    Perhaps better:
> 
> 		err = port->irq ?: -EINVAL;

Sure.

> > +			goto err_free_netdev;
> > +		}
> > +	} else {
> > +		/* kept for dt compatibility */
> > +		port->irq = irq_of_parse_and_map(port_node, 0);
> > +		if (port->irq <= 0) {
> 
>    Note that irq_of_parse_and_map() returns *unsigned int*, so negative
> error codes are not possible, 0 indicates bad IRQ.

That right, I'll fix that!

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/8e7b1eb7/attachment.sig>
