From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 May 2011 00:11:55 -0600
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110530033826.GE4130@opensource.wolfsonmicro.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
Message-ID: <20110530061155.GC23517@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 11:38:27AM +0800, Mark Brown wrote:
> On Sun, May 29, 2011 at 08:11:34PM -0700, Olof Johansson wrote:
> > On Fri, May 27, 2011 at 6:24 PM, Mark Brown
> 
> > > This is a step back from the usability of the existing platform data -
> > > the platform data uses a series of individually named GPIOs while this
> > > uses an array of GPIO numbers with magic indexes. ?The fact that you
> > > need comments explaining what the functions of the array elements are
> > > is a bit of a red flag here.
> 
> > Agreed, I had similar concerns with the sdhci bindings where it used a
> > 3-element array of gpios instead of the previous named ones. I was
> > told it's common practice to do it that way though? Seems like a step
> > backwards to me. :(
> 
> Interesting...  what was the reasoning behind this?  It's a definite
> step backwards but it does explain my major concern with the new batch
> of device tree patches.

The binding for gpios was defined a few years ago and it is in fairly
wide use within the powerpc sphere.  The design followed the pattern
established for specifying irqs, and in that regard satisfied the
principle of least surprise.

That said, it isn't a very large leap to go from a single 'gpios'
property to allowing multiple named gpios properties with meaningful
names, particularly if they are fully specified by the device
binding, and they follow exactly the same binding semantics as the
existing 'gpios' proprety (phandle + gpio specifier).

Personally, I'm /cautious/ about saying okay to extending the binding,
simply because once the extension is in use it is really hard to go
back on it, but I cannot think of any reason why this particular case
wouldn't be a good idea.  Anyone have thoughts on this?  Ben?  Mitch?

g.
