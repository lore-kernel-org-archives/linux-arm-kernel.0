From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jan 2016 12:27:17 +0100
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1454061134.10861.14.camel@mtksdaap41>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
 <56AA5A5C.9080402@openwrt.org>
 <20160128231306.GD4130@sirena.org.uk>
 <1454061134.10861.14.camel@mtksdaap41>
Message-ID: <20160129112717.GP4130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 05:52:14PM +0800, menghui lin wrote:
> On Fri, 2016-01-29 at 00:13 +0100, Mark Brown wrote:

> > I'm not convinced this binding makes sense, how would a user of the API
> > (currently there are none in tree) know what the modes mean?  It's a bit
> > different when the user is supplying configuration for a specific
> > regulator but this needs to be something that can be used by consumers.

> > What are you actually trying to do with this?

> In this patch, we want to support both normal/standby modes for mt6323
> regulators due to mt6323 regulators support low power mode which
> provides better power efficiency for standby case.

> We expect user of mt6323 regulators could dynamically change power mode
> by regulator_set_mode(). -EINVAL is returned if the given mode is not
> supported.

> The regulator_set_mode() API looks very straightforward and possible
> modes are already defined in consumer.h. It looks like we don't have to
> list possible modes for mt6323 additionally in binding document.

None of this is answering my question - I know what the current API is,
describing it doesn't tell me about actual users or how they are able to
sensibly use the interface.  Bear in mind that the definitions of the
various modes are all relative and what one device thinks is high usage
may be low usage for another device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/db1a930d/attachment.sig>
