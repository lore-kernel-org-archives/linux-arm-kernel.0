From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 11 Aug 2010 21:10:05 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <20100811174238.GA12382@kroah.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<AANLkTimmJDKbh3_pRY_ASKvjsf4YuuUMh3edh5LvDv-p@mail.gmail.com>
	<20100811174238.GA12382@kroah.com>
Message-ID: <201008112110.05542.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 11 August 2010 19:42:38 schrieb Greg KH:
> > So the question is are hcds expected to accept arbitarilly aligned but
> > heap allocated pointers (such as the result of kmalloc() + 1)?
> 
> It sounds like your HCD doesn't like this, so perhaps we should make
> that rule :)
> 
> If you allocate the urb with a kmalloc() call with no offset, does it
> all work properly?  The driver should be calling usb_alloc_urb() which
> does this automatically for them, right?  Or is it trying to allocate
> things on its own somehow?

The buffer is the problem not the URB. And up to now the alignment
was not specified, but drivers are generally written assuming byte
granularity.

	Regards
		Oliver
