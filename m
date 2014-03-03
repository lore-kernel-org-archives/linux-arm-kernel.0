From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 3 Mar 2014 17:27:31 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1722697.3h0GnbWuD3@avalon>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1569751.q5lJmQcb3K@avalon> <20140303091903.GA6531@katana>
 <1722697.3h0GnbWuD3@avalon>
Message-ID: <20140303162731.GA3732@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> While the parent is indeed selected at boot time only, and only one parent is 
> thus needed, parent selection could be performed by a DIP switch connected to 
> MD_CLK on the board for instance. In that case both parents should be 
> available in DT, as selection will be done by the kernel at boot time, not at 
> DT compile time.

OK, I understand the case. I still wonder about specifying two parents,
though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
clock (or an empty one), just because USB_X1 is enumerated as second
entry?

> > Again, now that I already coded it, what is the gain to remove it? The
> > drawback is that other people might get encouraged to find reasons to
> > allow them sloppy practices.
> 
> It will make the kernel binary smaller by removing code that is not needed in 
> practice.

Sounds like a micro-optimazation to me. If you insist, we should BUG()
right away in that case, to make the code comprehensible. Returning with
a leak and saying "we will probably fail somewhere" should really be
avoided IMO.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/059fadbc/attachment-0001.sig>
