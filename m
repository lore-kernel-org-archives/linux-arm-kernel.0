From: alan@linux.intel.com (Alan Cox)
Date: Tue, 1 Nov 2011 19:55:17 +0000
Subject: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
In-Reply-To: <CAC=G6sxm9YJZsi_+Zq7YVYsQrw1SAFvnroPxGyH7JGRn7ko5nw@mail.gmail.com>
References: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
	<20111101121851.7d393277@bob.linux.org.uk>
	<CAC=G6swE7WCqTFkJkOm_GXpVncjXrc+-jvaKHiwc9KTb6Re8hQ@mail.gmail.com>
	<CAC=G6szKRbyJXTXOCyDaF3rEfaiVCktTU6y0Fwohh6qf2VD-_A@mail.gmail.com>
	<CAC=G6sxm9YJZsi_+Zq7YVYsQrw1SAFvnroPxGyH7JGRn7ko5nw@mail.gmail.com>
Message-ID: <20111101195517.5334482c@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The opinion part... ?I needed a timer to switch from transmit to
> receive after the FIFO was empty. ?I started by using the low
> resolution timer using jiffies first. ?I found that wasn't high enough
> resolution, so I switched to the Linux HRT.  Currently I have both
> versions that can be selected by conditional compile. ?Should I
> just remove the low resolution timer completely or leave it in.

I would just remove the low res one. They should degrade to low res
timer equivalence anyway.

> Second, I have a chunk of code that if it could be made to work
> could off load the receiving to DMA up to the last couple of bytes
> then switch back to interrupts for the token byte. ?Should I leave
> that code in a #if 0 statement or should I just delete it.

Is it something that you are likely to debug or someone is going to
debug shortly ?
