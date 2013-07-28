From: david@gibson.dropbear.id.au (David Gibson)
Date: Mon, 29 Jul 2013 07:46:37 +1000
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130728153546.GB5224@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
 <2529481.u8xHuXumcd@flatron>
 <CAKON4OzReTRb5JnJE+07vNJ-uDndLfqq8ha04J7K3x=WtsZEWw@mail.gmail.com>
 <20130728153546.GB5224@netboy>
Message-ID: <20130728214637.GC29970@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 05:35:46PM +0200, Richard Cochran wrote:
> On Sun, Jul 28, 2013 at 10:09:57AM -0400, jonsmirl at gmail.com wrote:
> > 
> > 3.z kernel is free to alter the schema. But it will have to supply the
> > necessary quirks needed to keep those old dtb's functioning.
> 
> The quirks idea sounds okay to me, if it can really provide forward
> compatibility. In practice, I doubt anyone will really spend the
> effort to make this work. I think it would be much easier to make sure
> the bindings are "future proof" in the first place.

I should clarify.  The idea of DT quirks is not to remove the need to
properly design and review bindings.  It's to limit the damage when
there are, inevitably, failings in that process.  And when, also
inevitably, firmware vendors ship DTs that don't follow the bindings
correctly, even when there is a good one available.

I think it's more likely that people will create, and get right, a
well localized bit of quirk code, than they will get backwards compat
code correct for every place in which a driver wants info from the
device tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/fd78ddc3/attachment-0001.sig>
