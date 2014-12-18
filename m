From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 18 Dec 2014 20:31:53 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <1418637710.4443.11.camel@linux-0dmf.site>
References: <20141213223727.GA13894@amd>
 <1418637710.4443.11.camel@linux-0dmf.site>
Message-ID: <20141218193153.GA27832@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +	h4p_simple_send_frame(info, skb);
> > +
> > +	if (!wait_for_completion_interruptible_timeout(&info->init_completion,
> > +						       msecs_to_jiffies(1000))) {
> > +		printk("h4p: negotiation did not return\n");
> 
> Memory leak in the error case

And memory leak in the normal case, too, no? Fixed.

> > +	case H4_ACL_PKT:
> > +		acl_hdr = (struct hci_acl_hdr *)skb->data;
> > +		retval = le16_to_cpu(acl_hdr->dlen);
> 
> Could you explain, why only this needs endianness converted?

This one is 16 bit, the others I checked are 8 bit.

> > +static void h4p_rx_tasklet(unsigned long data)
> > +{
> > +	u8 byte;
> > +	struct h4p_info *info = (struct h4p_info *)data;
> > +
> > +	BT_DBG("tasklet woke up");
> > +	BT_DBG("rx_tasklet woke up");
> 
> Isn't this a bit redundant?

Fixed.

> > +	struct sk_buff *skb;
> > +	struct h4p_info *info = (struct h4p_info *)data;
> > +
> > +	BT_DBG("tasklet woke up");
> > +	BT_DBG("tx_tasklet woke up");
> 
> Doubled?

Fixed.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
