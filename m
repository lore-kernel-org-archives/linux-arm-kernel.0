From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:35:15 +0100
Subject: [PATCH 08/10] ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
In-Reply-To: <CAGb2v67w6gQki1Vjvzr_OYYAdMU0tefS0_c2qCrpQs2Po=-qZQ@mail.gmail.com>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-9-git-send-email-wens@csie.org>
 <20141207150249.GG12434@lukather>
 <CAGb2v67w6gQki1Vjvzr_OYYAdMU0tefS0_c2qCrpQs2Po=-qZQ@mail.gmail.com>
Message-ID: <20141207153515.GL12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 11:18:28PM +0800, Chen-Yu Tsai wrote:
> >> +     reg_vcc3v0: vcc3v0 {
> >> +             compatible = "regulator-fixed";
> >> +             regulator-name = "vcc3v0";
> >> +             regulator-min-microvolt = <3000000>;
> >> +             regulator-max-microvolt = <3000000>;
> >> +     };
> >
> > There's already such a regulator in sunxi-common-regulators.
> 
> I cannot include sunxi-common-regulators, not without a lot of work.
> sunxi-common-regulators includes a soc/pio node, but the addresses,
> and thus the node names are different. This results in:
> 
> ERROR (duplicate_label): Duplicate label 'pio' on
> /soc at 01c00000/pinctrl at 01c20800 and /soc/pinctrl at 06000800
> 
> If we move to preprocessor-based includes and phandle referencing
> (&pio { .... })
> to override/add nodes and properties, then it would work. But that is
> a lot of work
> going through all of our DTs.

Not really, you can just do so in sunxi-common-regulator. There's no
need to do it everywhere else.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/de956048/attachment.sig>
