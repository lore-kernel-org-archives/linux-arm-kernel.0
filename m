From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Oct 2014 12:23:30 +0000
Subject: [PATCH v3 01/14] mfd: max77686/802: Map regulator driver to its
 own of_node
In-Reply-To: <1414668053-31370-2-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141031122330.GP18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 12:20:40PM +0100, Krzysztof Kozlowski wrote:
> Add of_compatible fields for max77686 and max77802 regulator drivers.
> The driver's node should be the same as voltage-regulators node. This
> simplifies parsing of regulators init data from DTS.

No, this is broken.  You're introducing an ABI break that conveys no
additional information, I can't see any reason why this should make it
simpler to parse init data (you've certainly not articulated one in the
changelog here) but even if it did you are changing the ABI incompatibly
and convenience isn't a good reason to do that.

I'm getting very frustrated with what's going on with these drivers,
there seem to be a lot of rather large sets of patches spawning lots of
discussion but also frequent review problems and very little actually
getting merged (look at the set of changes in the past few merge windows
for example).  There's something going wrong here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/aba1dbc3/attachment.sig>
