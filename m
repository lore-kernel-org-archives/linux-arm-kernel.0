From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Sep 2013 00:26:48 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <5240B07C.6080404@wwwdotorg.org>
References: <20130919105437.75e0f0a3@armhf>
 <5240B07C.6080404@wwwdotorg.org>
Message-ID: <20130923232648.GL21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 03:19:56PM -0600, Stephen Warren wrote:
> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:

> > +Required properties:
> > +- compatible: should be "linux,simple-codec".

> We shouldn't have any Linux-specific bindings. It might be reasonable to
> define a binding for a "simple CODEC", but there's no reason it should
> be Linux-specific.

What's the vendor prefix to use then?  The same thought did occur to me
but I wasn't sure what to suggest instead.

> > +- dai-name: name of the codec

> That should be internal to the driver; it's Linux-specific.

I do think it's reasonable to define a name for display purposes however
this binding doesn't say that, I did say something to that effect
already IIRC.

> > +Formats:
> > +	"s8"
> > +	"u8"

> I think the binding should specify on-the-wire formats, not in-memory
> formats. For example, if this binding is used to represent an I2S CODEC,
> it's more important to know whether it supports left-justified,
> right-justified, DSP mode, etc., and the max number of bits (or perhaps
> a list of supported numbers of bits) per channel in each case.

I didn't query this myself since my expecation with this is that the
rest of the wire format properties will come from the binding that pulls
this together into a card (since this will need to be set at that level
for other CODECs which are more flexible) so I saw this as providing
additional information which would normally not be fixed at that level.
Arguably this could be pushed up there too, though it's not normal to
fix the word size.

We should really be defining things like signed and unsigned as well as
the bits per word since they do make a difference, though in practice
you very rarely see anything except unsigned and some of the formats
listed don't seem to have ever even been used in Linux.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/72fe0e20/attachment.sig>
