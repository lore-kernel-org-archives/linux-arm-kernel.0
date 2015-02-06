From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Feb 2015 14:52:26 +0100
Subject: Recommendations for a new MFD device driver?
In-Reply-To: <1423227312.31210.286.camel@mtksdaap41>
References: <20150206101006.GK12209@pengutronix.de>
 <20150206115418.GV21293@sirena.org.uk>
 <1423227312.31210.286.camel@mtksdaap41>
Message-ID: <20150206135226.GA29018@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 08:55:12PM +0800, Yingjoe Chen wrote:

> I think we should create a dtsi file, say mt6397.dtsi, the regulator
> device nodes are already too much to duplicate into every board using
> mt6397.

Please bear in mind that the regulator bindings are all about what is
being done to connect the PMIC to the rest of the system on a given
board; this means that it is almost always a bad idea to have a generic
include file for the PMIC since while many boards may be similar other
boards may differ and it's potentially unsafe to try to handle things
generally.  

It can be a good idea to have a .dsti file for the common elements of a
widely used reference design but that's a different thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150206/44147a7a/attachment.sig>
