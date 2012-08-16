From: js@sig21.net (Johannes Stezenbach)
Date: Thu, 16 Aug 2012 19:22:51 +0200
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <502D2471.407@pobox.com>
References: <50299142.2030504@oberhumer.com> <20120814123937.GA14756@sig21.net>
 <502B8FE3.7080501@oberhumer.com> <20120815144539.GA8300@sig21.net>
 <502C92C3.7090701@oberhumer.com> <502D100D.2030609@pobox.com>
 <20120816162051.GK11413@one.firstfloor.org>
 <502D2471.407@pobox.com>
Message-ID: <20120816172251.GA25640@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 12:48:49PM -0400, Jeff Garzik wrote:
> On 08/16/2012 12:20 PM, Andi Kleen wrote:
> >>If you think a little bit, I bet you could come up with a solution that
> >>operates at cacheline-aligned granularity, something that would be _even
> >>faster_ than simply fixing the code to do aligned accesses.
> >
> >Cache aligned compression is unlikely to compress anything at all.
> >Compression algorithms are usually by definition unaligned.
> 
> Sure it's a bitstream, but that does not imply the impossibility of
> reading data in in an word-aligned manner.
> 
> Maybe cache-aligned is ambitious, because of resultant code bloat,
> but machine-int-aligned is doable and reasonable.

Well, I for one would be content if the old and new lzo versions
could be merged based on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

(Assuming that the slowdown on ARM is due to unaligned access,
since the old version also uses get/put_unaligned, is the new
version actually using more unaligned accesses?)


Johannes
