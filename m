From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Nov 2018 13:31:26 +0000
Subject: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
In-Reply-To: <20181122153241.lzrwhkewg5q4hy2c@flea>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea>
Message-ID: <20181123133126.GF2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 04:32:41PM +0100, Maxime Ripard wrote:
> On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:

> > +- cpvdd-supply: Regulator supply for the headphone amplifier

> I guess we should make this optional, since even if it's missing, it's
> going to create a dummy regulator. and that allows to have backward
> compatibility.

Regulators should never be marked as optional unless they can be
physically absent.  It is true that Linux has code to handle partially
defined device trees but we shouldn't rely on other OSs having similar
code and it's better practice to have board device trees be fully
specified, it means that if we need the regulator information for some
future thing it's more likely to be there and it's less likely that bugs
which do things like cause the regulator to be powered off incorrectly
will be introduced in future.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/dc6a6328/attachment.sig>
