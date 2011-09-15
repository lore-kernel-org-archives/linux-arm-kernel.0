From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 15 Sep 2011 15:53:20 +0200
Subject: [PATCH v3 1/1] ASoC: mxs-saif: add record function
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77225DB00@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<20110909133051.GS1912@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77225DB00@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20110915135320.GG2284@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I think we should use usleep_range for both udelays here? Having a rate
> > of 8000, we'd burn 250us here.
> >
> Yes, I agree that it's a bit long for 8000.
> I tried sleep way but I found the trigger function is called with
> spin_lock held, so it seems we may not be able to sleep here.
> 
> I think the way of dynamically calculate delay suggested by Liam has
> Already minimize the affection, especially for high sample rate, it
> may work more efficiency than sleep (context switch cost).
> 
> Do you think if it's reasonable to accept it?

Yes, it can be fixed when it becomes necessary

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110915/f6022c16/attachment.sig>
