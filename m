From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Feb 2018 14:39:45 +0100
Subject: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and
 add V3 one
In-Reply-To: <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
 <20180202221301.judzaafcu67h4c2v@flea.lan>
 <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
Message-ID: <20180205133945.ac3im2fu42evuxtb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 03, 2018 at 03:23:28PM +0800, Icenowy Zheng wrote:
> ? 2018?2?3? GMT+08:00 ??6:13:01, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >On Sat, Feb 03, 2018 at 02:04:54AM +0800, Icenowy Zheng wrote:
> >> The V3s is just a differently packaged version of the V3 chip, which
> >has
> >> a MAC with the same capability with H3. The V3s just doesn't wire out
> >> the external MII/RMII/RGMII bus. (V3 wired out it).
> >> 
> >> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
> >a
> >> V3 compatible string, which has all capabilities.
> >> 
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> >This breaks the DT ABI, so NAK.
> 
> I have asked this at IRC.

One more reason why no one should ask questions like this on IRC.

> The V3s compatible string is never used in any mainline
> kernel, even not in any RC version.

$ git grep allwinner,sun8i-v3s-emac v4.15 | wc -l 
5

It is there already, and the fact that we have or don't have a DT in
tree that use it doesn't matter. One could very well have written a DT
for it and never submitted it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180205/5f15ff3a/attachment.sig>
