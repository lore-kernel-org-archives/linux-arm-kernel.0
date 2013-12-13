From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 Dec 2013 11:38:22 +0100
Subject: [PATCH 04/10] net: stmmac: sunxi platfrom extensions for GMAC in
 Allwinner A20 SoC's
In-Reply-To: <CAGb2v655_83b76PTmgkDmNGCADWwTjTwW13sOgM5HFmCVkeu=w@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org>
 <52A5A52C.50605@st.com>
 <CAGb2v67WiCaMpJEzA_X6o7uOu6i3w3FCEz7=N5HY0amQb01SZA@mail.gmail.com>
 <52A72C6D.60100@st.com>
 <CAGb2v64qQvqJSicA6MTAxeh1sGjWY=Pk=vDq=9J3pTQW+wkXrA@mail.gmail.com>
 <52A87A74.8040807@st.com> <20131212090415.GQ3651@lukather>
 <CAGb2v655_83b76PTmgkDmNGCADWwTjTwW13sOgM5HFmCVkeu=w@mail.gmail.com>
Message-ID: <20131213103822.GX3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 06:31:43PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Dec 12, 2013 at 5:04 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Wed, Dec 11, 2013 at 02:45:08PM +0000, srinivas kandagatla wrote:
> >> >>> 1. .tx_coe
> >> >>>    This is not exported in the DT bindings.
> >> >>>    Looking at stmmac code, not setting this seems to disable all
> >> >>>    checksum offloading.
> >> >>
> >> >> Why cant this go via DT as well?
> >> >
> >> > If you and Giuseppe are OK with this, why not?
> >> Am Ok with it.
> >
> > Please note that I'm opposed to this until someone explain why putting
> > it in the DT is relevant (and not just convenient).
> 
> Checksum offloading is an optional feature[1], implemented starting
> from version 3.20a. It is not tied to a specific IP version. As such,
> using a "snps,dwmac-<version>" compatible isn't a good fit here.

No, but we're not in such case. Since we have a compatible of our own,
we can derive it from that. Putting a property in the DT would only be
redundant.

> stmmac does auto-detection for optional features on MAC version > 3.50a.
> This is what Srinivas was referring to.
> 
> Unfortunately, our MAC is < 3.50a. No auto-detection. We could add a
> "snps,dwmac-tx-coe" compatible for this, or the seperate DT property.
> 
> The other way would be to pass the flags in the initial .data with the
> SoC specific compatible. Other SoCs with the same feature won't be
> able to reuse the same compatible though.

Which is already pretty much the case, since we have to deal with
Allwinner specific code and features.

A new compatible is cheap to maintain, a new property is not.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/cddcaf10/attachment-0001.sig>
