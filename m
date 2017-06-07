From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 7 Jun 2017 18:13:33 +0200
Subject: [PATCH 7/9] net: mvmdio: add xmdio support
In-Reply-To: <e423ea96-12df-6a19-ce94-149ace2e2272@gmail.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-8-antoine.tenart@free-electrons.com>
 <e423ea96-12df-6a19-ce94-149ace2e2272@gmail.com>
Message-ID: <20170607161333.GA22888@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Wed, Jun 07, 2017 at 08:48:06AM -0700, Florian Fainelli wrote:
> On 06/07/2017 01:38 AM, Antoine Tenart wrote:
> 
> > +	if (of_device_is_compatible(np, "marvell,orion-mdio")) {
> > +		ops->is_done = smi_is_done;
> > +		ops->is_read_valid = smi_is_read_valid;
> > +		ops->start_read = smi_start_read_op;
> > +		ops->read = smi_read_op;
> > +		ops->write = smi_write_op;
> > +
> > +		dev->poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN;
> > +		dev->poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX;
> > +	} else if (of_device_is_compatible(np, "marvell,xmdio")) {
> > +		ops->is_done = xsmi_is_done;
> > +		ops->is_read_valid = xsmi_is_read_valid;
> > +		ops->start_read = xsmi_start_read_op;
> > +		ops->read = xsmi_read_op;
> > +		ops->write = xsmi_write_op;
> > +
> > +		dev->poll_interval_min = MVMDIO_XSMI_POLL_INTERVAL_MIN;
> > +		dev->poll_interval_max = MVMDIO_XSMI_POLL_INTERVAL_MAX;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> 
> Instead of doing this, you could have the ops structure declared e.g: a
> static global variables in the driver and reference them from the
> of_device_id .data field, something like:

Good idea, I'll update the series using static global variables for ops
and poll intervals and reference them in the .data field.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/b292725a/attachment-0001.sig>
