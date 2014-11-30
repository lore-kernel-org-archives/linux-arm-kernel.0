From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 30 Nov 2014 00:11:10 -0800
Subject: [PATCH v5 1/3] mtd: nand: gpmi: add gpmi_move_bits function
In-Reply-To: <20141126175708.1acb90ac@bbrezillon>
References: <1417020793-3354-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417020793-3354-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141126175708.1acb90ac@bbrezillon>
Message-ID: <20141130081110.GC3608@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:57:08PM +0100, Boris Brezillon wrote:
> On Wed, 26 Nov 2014 17:53:11 +0100 Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > +/**
> > + * gpmi_move_bits - move bits from one memory region to another
> > + * @dst: destination buffer
> > + * @dst_bit_off: bit offset we're starting to write at
> > + * @src: source buffer
> > + * @src_bit_off: bit offset we're starting to read from
> > + * @nbits: number of bits to copy
> > + *
> > + * This functions copies bits from one memory region to another, and is used by
> > + * the GPMI driver to copy ECC sections which are not guaranteed to be byte
> > + * aligned.
> 
> I forgot to add that src and dst should not overlap, otherwise it won't
> work...

Hmm, normally that's implied for copy-like operations. But since you
named this function "move" (rather than "copy" or "cpy"), that's a
little less clear.

Did you have a good reason for the "move" name? If not, maybe it's worth
changing.

Brian
