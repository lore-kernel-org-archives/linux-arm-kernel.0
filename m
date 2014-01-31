From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Jan 2014 15:46:48 +0000
Subject: Extending OPP bindings
In-Reply-To: <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
Message-ID: <20140131154648.GF22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 12:46:20PM +0000, Lorenzo Pieralisi wrote:

> Indexing does not mean that the index in the DT is the same as the one
> allocated by the OS. Indexing is there to point at specific OPPs from
> different DT nodes, a good example are clock bindings and that's exactly
> how they work.

> Can you provide me with an example where the indexing would go wrong
> please ?

This does depend on what you mean by indexing but if you're talking
about having bindings where you have things that refer to the nth
element in an array in that form then it can become hard to read the
resulting DT and the potential for errors is increased.  Changes to the
original table need to take into account all the references to the table
and (especially if the number of entries gets large) it can be prone to
miscounting when checking references.

With OPPs this might happen if new operating points are characterised or
some are removed, for example due to new SoC variants or binning.

> Certainly relying on implicit ordering is not great either, actually I
> would say that it is broken.

Yes, that too - some sort of explict reference does help.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/69f7af5f/attachment.sig>
