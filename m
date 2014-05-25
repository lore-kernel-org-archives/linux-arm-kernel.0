From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 15:07:47 +0200
Subject: [PATCH 1/3] dt: Add DT bindings documentation for SUNXI Security
 System
In-Reply-To: <201405242143.42693.marex@denx.de>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <201405241321.32147.marex@denx.de> <5380F0E3.7020008@gmail.com>
 <201405242143.42693.marex@denx.de>
Message-ID: <20140525130747.GH10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 09:43:42PM +0200, Marek Vasut wrote:
> On Saturday, May 24, 2014 at 09:20:03 PM, Tomasz Figa wrote:
> > Hi Marek,
> > 
> > On 24.05.2014 13:21, Marek Vasut wrote:
> > > On Thursday, May 22, 2014 at 05:09:54 PM, LABBE Corentin wrote:
> > > 
> > > Missing commit message. Please fix this and send a V2.
> > > 
> > >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > >> ---
> > >> 
> > >>  Documentation/devicetree/bindings/crypto/sunxi-ss.txt | 9 +++++++++
> > >>  1 file changed, 9 insertions(+)
> > >>  create mode 100644
> > >>  Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> > >> 
> > >> diff --git a/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> > >> b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt new file mode
> > >> 100644
> > >> index 0000000..356563b
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> > >> @@ -0,0 +1,9 @@
> > >> +* Allwinner Security System found on A20 SoC
> > >> +
> > >> +Required properties:
> > >> +- compatible : Should be "allwinner,sun7i-a20-crypto".
> > > 
> > > Why sun7i-a20 ? Is the crypto unit different in other sunxi chips ? Can
> > > that not be described by DT props ?
> > 
> > A widely used convention is to define compatible strings after first
> > SoCs on which particular IP blocks appear. It is quite common among IP
> > blocks for which there is no well defined versioning scheme.
> 
> Well yeah, that's fine. But in this case, "sun7i" is the entire group of CPUs 
> manufactured by AW. I find that information redundant, the "allwinner,a20-
> crypto" would suffice. But I wonder if that IP block might have appeared even 
> earlier ? Or if it is CPU family specific, thus "allwinner,sun7i-crypto" would 
> be a better string ?

No. sun7i-a20-crypto is perfectly fine, and the pattern is used for
all the IPs. sun7i is the SoC family, A20 the actual SoC. In the A20
case, they're equivalent, it's not the case for other Allwinner
SoCs. And I definitely prefer consistency over plain mess. You might
see it differently, but that's not going to change.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/b4128d36/attachment.sig>
