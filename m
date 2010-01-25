From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 10:55:03 +0000
Subject: Default machine include placements
In-Reply-To: <20100125104959.GC5772@digital-scurf.org>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
	<20100125104959.GC5772@digital-scurf.org>
Message-ID: <20100125105503.GQ26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:49:59AM +0000, Daniel Silverstone wrote:
> On Mon, Jan 25, 2010 at 10:44:25AM +0000, Ben Dooks wrote:
> > We do a bit of #include <plat/xxx-base.h> already for some things.
> > The 'empty' headers always seme to end up catching more copyright
> > statement than the space they end up saving.
> 
> I guess it depends if you're aiming for space savings or "only one place to fix
> a bug" in that case.

The big one is bug repetition, which happened with the s3c64xx clksrc
code. The internal Samsung trees ended up with 4 similar copies of this
code, each with its own unique problems. Whilst this problem is quite
easy to fix (and it is now fixed in the current kernel) the other problem
is the size of submission for each new CPU support.

One solution is just to make mach-s5p and stick all s5p implementations
in there, but this could end up with one quite big directory or a large
number of sub directiories springing up for CPU specific support.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
