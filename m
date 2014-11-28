From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 15:07:29 +0000
Subject: [PATCH v4 4/7] regulator: Use ena_gpio supplied with generic
 regulator bindings
In-Reply-To: <1417184044.18249.39.camel@AMDC1943>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-5-git-send-email-k.kozlowski@samsung.com>
 <20141127184342.GC7712@sirena.org.uk>
 <1417170655.18249.24.camel@AMDC1943>
 <20141128113859.GH7712@sirena.org.uk>
 <1417184044.18249.39.camel@AMDC1943>
Message-ID: <20141128150729.GP7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 03:14:04PM +0100, Krzysztof Kozlowski wrote:
> On pi?, 2014-11-28 at 11:38 +0000, Mark Brown wrote:

> > This sort of thing is a sign that we're not saving much by moving the
> > parsing to the core and perhaps there's more flexiblity here... 

> The driver receive callbacks (or exposes other kind of interface) for
> other core-generalized code. Recent example is parsing regulator mode
> (added by Javier) and .of_map_mode() callback.

Right, but that's actually doing some device specific translation and
successfully factoring out the bulk of the code - the fact that it's
taking parameters and returning data is a good sign.  This is a callback
placed randomly away from any other related code (adding to the
confusion - it's not integrated into the rest of the flow around this at
all) without a clear purpose.

> I thought how to do this without this additional set_ena_gpio() call.
> One way would be to extend the regulator modes (FAST/IDLE/STANDBY/ and
> GPIO) but this would look somehow unnatural.

Yes, that's absolutely hideous.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/3628c16a/attachment.sig>
