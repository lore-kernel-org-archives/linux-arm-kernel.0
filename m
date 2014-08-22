From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Aug 2014 09:44:03 -0500
Subject: [PATCH] ARM: bcm: Don't build brcmstb SMP code when building for
 V6
In-Reply-To: <20140822050907.GC3246@norris-Latitude-E6410>
References: <1408673194-16228-1-git-send-email-broonie@kernel.org>
 <20140822050907.GC3246@norris-Latitude-E6410>
Message-ID: <20140822144403.GU24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 10:09:07PM -0700, Brian Norris wrote:
> On Thu, Aug 21, 2014 at 09:06:34PM -0500, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > building for -march=armv6 as happens when building allmodconfig. Since I
> > have not been able to identify a way to override the compiler architecture
> > selection per file add a Kconfig dependency to ensure this code is not
> > built if V6 support is enabled.

> I already proposed this solution to override the compiler architecture,
> in the same pattern as other similar code in the same directory.

>   http://article.gmane.org/gmane.linux.drivers.devicetree/84517

> My using 'CFLAGS_<obj> += <flags>', you can compile in v7.

I tried that but it wasn't doing the right thing for me - it appeared
since the compiler ends up getting both -march=armv7-a and -march=armv6
it complained that it couldn't satisfy both options.  It might be that
this is version dependant or the actual cause wsa something else, I
didn't investigate too hard.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140822/274418c1/attachment.sig>
