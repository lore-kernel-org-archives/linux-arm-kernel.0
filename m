From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 7 Jun 2011 20:59:28 +0100
Subject: [RFC PATCH] KMS support for i.MX51/53
In-Reply-To: <20110607191205.GK23771@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
	<20110607121701.71cdd06e@lxorguk.ukuu.org.uk>
	<20110607191205.GK23771@pengutronix.de>
Message-ID: <20110607205928.22f3e1ef@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not sure I understand you correctly. I have no address space on the
> card side since my 'card' just uses main memory. The memory I need must
> be a physically contiguous portion of sdram. I'm afraid shmem backing
> memory is not of much use for me.

I hadn't realised you had that underlying limit. If you are limited to a
specific chunk of SDRAM and it must be physically linear rather than any
of memory then indeed it's not.

I'd been tweaking GEM so you can borrow the abstraction and handles but
back them with your own allocator but in my case it makes sense because I
can use either main memory or a chunk of linear preallocated memory
reserved by the firmware so I wanted the commonality and single set of
handles for GEM, IOCTL_MODE_CREATE_DUMB etc.

Alan
