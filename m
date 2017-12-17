From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Dec 2017 22:16:50 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <CAAEAJfArtxcWgcjHAb__3BQxWEBgWU8uWtHGYETc-m9eUs91nA@mail.gmail.com>
References: <20171217120503.GA3323@1wt.eu>
 <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
 <20171217155305.16c5bb4f@bbrezillon> <20171217150043.GA1403@1wt.eu>
 <CAAEAJfD47bGTSppEqcRszjAgBUjiCevmdYLKfsQTPYMcVu8VDA@mail.gmail.com>
 <20171217162342.GA1833@1wt.eu> <20171217190746.2a61232c@bbrezillon>
 <20171217190056.GA1107@1wt.eu>
 <CAAEAJfArtxcWgcjHAb__3BQxWEBgWU8uWtHGYETc-m9eUs91nA@mail.gmail.com>
Message-ID: <20171217211650.GA6815@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 06:01:29PM -0300, Ezequiel Garcia wrote:
> On 17 December 2017 at 16:00, Willy Tarreau <w@1wt.eu> wrote:
> > On Sun, Dec 17, 2017 at 07:07:46PM +0100, Boris Brezillon wrote:
> >> > > This would guarantee that devices with factory bad blocks,
> >> > > (and no BBT), would be OK with this patch.
> >> >
> >> > I see. I'm fine with trying provided I have reasonably good assurance
> >> > that I won't have to go through the kwboot pain again :-/
> >>
> >> There's a easy test you can do without scrubing the NAND:
> >> 1/ comment the nand-on-flash-bbt property in your DT (this will trigger
> >>    a full scan)
> >> 2/ from u-boot (before booting the kernel), erase a block that you know
> >>    contains nothing important
> >> 3/ during the kernel scan, make sure this block is not reported as bad
> >
> > OK so I tried and never faced any error. Thus I also attempted to mark
> > a bad block in u-boot, it appeared in the bad blocks table, then I had
> > to scrub the whole table to get rid of it. Each time when I booted I
> > saw the message "Scanning device for bad blocks" but no error ever
> > happened. So I hope it's OK.
> >
> 
> Nice. Thanks a lot Willy. I think this acks Boris' patch.

You're welcome, you and Boris fixed my problem very quickly allowing me
to continue to prepare my new router :-)

BTW, Boris please don't forget to mark your fix for -stable.

Thanks,
Willy
