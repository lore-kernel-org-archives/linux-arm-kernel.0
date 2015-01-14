From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 20:30:08 +0100
Subject: [PATCH v3 4/9] ARM: dts: sun7i: cubieboard2: add axp209
 regulator nodes
In-Reply-To: <CAGb2v65=Jfr56Yb2udNVy=shA9+AOPK9yjHTAOJZ7TFh5idTHA@mail.gmail.com>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-5-git-send-email-wens@csie.org>
 <20150112090603.GE4891@lukather>
 <CAGb2v66r6EG2F1-=Gaig7ZW58Z1KteQ5nDPfW5niisv7dCjY0Q@mail.gmail.com>
 <20150113094036.GR4891@lukather>
 <CAGb2v65=Jfr56Yb2udNVy=shA9+AOPK9yjHTAOJZ7TFh5idTHA@mail.gmail.com>
Message-ID: <20150114193008.GD4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 06:30:51PM +0800, Chen-Yu Tsai wrote:
> >> You could probably chain the regulators in the DT via xxx-supply
> >> if it helps. But beyond that, it is hard to do anything meaningful
> >> at this point. Modeling them as fixed regulators beyond our control
> >> is simpler. We also do not have an IPSOUT regulator for the AXP.
> >>
> >> > Eventually, I think we would be able to remove
> >> > sunxi-common-regulators.dtsi, or at least, expose the proper regulator
> >> > hierarchy.
> >>
> >> The USB and SATA regulators are just GPIO enabled switches (MOSFETs)
> >> or current limiters. I think these will always exist because of the
> >> reference designs. Or do you want to move them back into the board
> >> dts files? FWIW, I like it the way it is now. Not that I don't like
> >> it to be accurate.
> >
> > At least providing the right hierarchy at the board level would be
> > great. Adding the -supply property to all our fixed regulators
> > wouldn't take too much code, and would be enough to model properly the
> > regulator trees.
> 
> These are all unrelated to axp209. You'd end up with
> 
>     vin-supply = <&reg_vcc5v>;
> 
> for the usb and sata power regulators. You could put these
> in sunxi-common-regulators, and override them for boards
> that actually have something controllable.

Ok. Fine then.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/387122b6/attachment.sig>
