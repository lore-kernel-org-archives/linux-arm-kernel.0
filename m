From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 18 Dec 2014 21:10:43 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <20141218193153.GA27832@amd>
References: <20141213223727.GA13894@amd>
 <1418637710.4443.11.camel@linux-0dmf.site>
 <20141218193153.GA27832@amd>
Message-ID: <20141218201043.GA15240@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
On Thu 2014-12-18 20:31:53, Pavel Machek wrote:
> Hi!
> 
> > > +	h4p_simple_send_frame(info, skb);
> > > +
> > > +	if (!wait_for_completion_interruptible_timeout(&info->init_completion,
> > > +						       msecs_to_jiffies(1000))) {
> > > +		printk("h4p: negotiation did not return\n");
> > 
> > Memory leak in the error case
> 
> And memory leak in the normal case, too, no? Fixed.

Actually, no, h4p_simple_send_frame passes skb to network stack, and
it should free it as neccessary.

								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
