From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 25 Jul 2017 10:42:46 +0200
Subject: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY address when
 connecting to the PHY
In-Reply-To: <7ccc9080-5967-5728-bb1e-f41b9c91b254@cogentembedded.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <7ccc9080-5967-5728-bb1e-f41b9c91b254@cogentembedded.com>
Message-ID: <20170725084246.GA2860@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Jul 24, 2017 at 07:40:01PM +0300, Sergei Shtylyov wrote:
> On 07/24/2017 04:48 PM, Antoine Tenart wrote:
> 
> > +	/* Set the SMI PHY address */
> > +	if (of_property_read_u32(port->phy_node, "reg", &phy_addr)) {
> > +		netdev_err(port->dev, "cannot find the PHY address\n");
> > +		return -EINVAL;
> 
>    Wny not propagte the error from of_property_read_u32()?

I could do this, you're right.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/0b9a13ae/attachment.sig>
