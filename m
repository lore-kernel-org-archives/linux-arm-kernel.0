From: egon.alter@gmx.net (Egon Alter)
Date: Tue, 29 Jan 2013 12:43:20 +0100
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130129101549.GP23505@n2100.arm.linux.org.uk>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <20130129101549.GP23505@n2100.arm.linux.org.uk>
Message-ID: <34874167.ghObrToI03@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 29. Januar 2013, 10:15:49 schrieb Russell King - ARM Linux:
> On Mon, Jan 28, 2013 at 02:25:10PM -0800, Andrew Morton wrote:
> > What's this "with enabled unaligned memory access" thing?  You mean "if
> > the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"?  If so,
> > that's only x86, which isn't really in the target market for this
> > patch, yes?
> > 
> > It's a lot of code for a 50ms boot-time improvement.  Does anyone have
> > any opinions on whether or not the benefits are worth the cost?
> 
> Well... when I saw this my immediate reaction was "oh no, yet another
> decompressor for the kernel".  We have five of these things already.
> Do we really need a sixth?
> 
> My feeling is that we should have:
> - one decompressor which is the fastest
> - one decompressor for the highest compression ratio
> - one popular decompressor (eg conventional gzip)

the problem gets more complicated as the "fastest" decompressor usually 
creates larger images which need more time to load from the storage, e.g. a 
one MB larger image on a 10 MB/s storage (note: bootloaders often configure 
the  storage controllers in slow modes) gives 100 ms more boot time, thus 
eating the gain of a "fast decompressor".

	Egon
