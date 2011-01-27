From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 16:47:26 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <AANLkTin7BEP0kpYGKyCczXY+MRG=GQ5_WgD3duDtemZ-@mail.gmail.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110127163643.GG25968@n2100.arm.linux.org.uk>
	<AANLkTin7BEP0kpYGKyCczXY+MRG=GQ5_WgD3duDtemZ-@mail.gmail.com>
Message-ID: <20110127164725.GI25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 05:43:35PM +0100, Linus Walleij wrote:
> 2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > So, maybe we want:
> >
> > ? ? ? ?host->data_xfered = ((success - 1) / data->blksz) * data->blksz;
> >
> > instead?
> 
> So like this:

Yes, that looks right, and shouldn't ever underflow.
