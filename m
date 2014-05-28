From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 20:49:13 +0100
Subject: [PATCH v2 1/4] devicetree: bindings: Properly document micrel
 ks8851 SPI chips
In-Reply-To: <53863CA3.7040000@codeaurora.org>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
 <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
 <20140524124858.GR22111@sirena.org.uk>
 <5385063F.30407@codeaurora.org>
 <20140528151646.GU20155@pengutronix.de>
 <20140528171219.GD5099@sirena.org.uk>
 <53863CA3.7040000@codeaurora.org>
Message-ID: <20140528194913.GI5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 12:44:35PM -0700, Stephen Boyd wrote:
> On 05/28/14 10:12, Mark Brown wrote:

> > If the supply must always be physically present the bindings should be
> > specified as it being mandatory and the code written in that fashion; as
> > an extension Linux will put a dummy in but this is attempting to handle
> > incorrect DTs.  This means we have functional error handling in cases
> > where there is something to worry about and simplifies the code using
> > the regulator.

> Ok, you're saying the opposite of Rob. Should it be required or optional
> in the DT binding?

I'm saying it should be required.  The implementation accepts it as an
extension (a recent extension at that).

> Ok. Dave M has already picked up all these patches so I'll send a patch
> to replace regulator_get_optional() with regulator_get() and fix up the
> error handling unless I hear otherwise.

Yes, please.  I'm much more worried about the abuse of
regulator_get_optional() than the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/2dfa8b45/attachment-0001.sig>
