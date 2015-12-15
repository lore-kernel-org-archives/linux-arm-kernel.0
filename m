From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Dec 2015 18:45:01 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151215181002.GA8568@leverpostej>
References: <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215171713.GA5727@sirena.org.uk>
 <20151215172837.GD8012@leverpostej>
 <20151215174516.GB5727@sirena.org.uk>
 <20151215181002.GA8568@leverpostej>
Message-ID: <20151215184501.GE5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 06:10:03PM +0000, Mark Rutland wrote:
> On Tue, Dec 15, 2015 at 05:45:16PM +0000, Mark Brown wrote:

> > > I'm not sure I follow w.r.t. "inherently less information", unless you
> > > mean trying to debug without access to that DTB?

> > If what the kernel knows about the system is that it's got a bunch of
> > cores with numbers assigned to them then all it's really got is those
> > numbers.  If something changes that causes problems for some systems
> > (eg, because the numbers have been picked poorly but in a way that
> > happened to work well with the old code) that's not a lot to go on, the
> > more we know about the system the more likely it is that we'll be able
> > to adjust the assumptions in whatever new thing we do that causes
> > problems for any particular systems where we run into trouble.

> Regardless of where the numbers live (DT or kernel), all we have are
> numbers. I can see that changing the in-kernel numbers would be possible
> when modifyign the DT is not, but I don't see how that gives you more
> information.

It's mainly the modifying the DT case - you're not dealing with some
external misguided number selection method you'd never thought of and
you're not forcing some third party to redo benchmarks or adjust DTs
they may not want to adjust.  You're also able to readjust the numbers
based on feedback if you need to rather than having to adapt algorithms
to handle particular number selections, the algorithm and number
selection are done together rather than separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151215/35f16cbb/attachment-0001.sig>
