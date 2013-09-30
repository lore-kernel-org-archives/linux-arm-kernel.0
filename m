From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Sep 2013 18:43:19 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <5249AB82.60701@wwwdotorg.org>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org>
 <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
 <5249AB82.60701@wwwdotorg.org>
Message-ID: <20130930174319.GG19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 10:49:06AM -0600, Stephen Warren wrote:

> The only potential issue with that approach is if the CODEC can be used
> in a "simple" mode where e.g. no control GPIOs, regulator manipulation,
> etc. are required, or in a more complex mode where such things are
> required, you may end up with the device-specific binding being written
> to the simple mode, and hence missing features required for the complex
> mode. Having a separate simple binding prevents the device-specific
> binding from being broken that way.

That would probably indicate a bug in the complex bindings since if the
simple mode exists then usually that would mean that the bindings for
the complex mode ought to be specifying things as optional, these things
are typically just done by strapping pins instead of routing them to the
CPU.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/8047c508/attachment.sig>
