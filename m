From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 09:37:48 +0200
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <CAGb2v64h7kq2jWzUJ74vDdOOQOXPxjx3ruSsJMXvyr7fP63BGg@mail.gmail.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-4-maxime.ripard@free-electrons.com>
 <CACRpkdZsxA7avmO85R=-Quu7FQwSVMPhQMDmmgL+xbkVTB-2HQ@mail.gmail.com>
 <CAGb2v64h7kq2jWzUJ74vDdOOQOXPxjx3ruSsJMXvyr7fP63BGg@mail.gmail.com>
Message-ID: <20160908073748.GF8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:46:14PM +0800, Chen-Yu Tsai wrote:
> > I mean it like supporting these in *addition* to the custom ones, so there can
> > be a smooth phase-over.
> >
> > Check for example Laurent's commit for SH-PFC:
> > commit 16ccaf5bb5a52372bfebd3dfbb79dd810ad49c09
> > "pinctrl: sh-pfc: Accept standard function, pins and groups properties"
> > It's awesome, and since, they have improved the looks of Renesas
> > DTS files a lot.
> >
> > It could look a bit like this nice thing from
> > lpc4337-ciaa.dts:
> >
> > &pinctrl {
> >         enet_rmii_pins: enet-rmii-pins {
> >                 enet_rmii_rxd_cfg {
> >                         pins = "p1_15", "p0_0";
> >                         function = "enet";
> >                         slew-rate = <1>;
> >                         bias-disable;
> >                         input-enable;
> >                         input-schmitt-disable;
> >                 };
> >
> >                 enet_rmii_txd_cfg {
> >                         pins = "p1_18", "p1_20";
> >                         function = "enet";
> >                         slew-rate = <1>;
> >                         bias-disable;
> >                         input-enable;
> >                         input-schmitt-disable;
> >                 };
> > (etc)
> 
> This looks nice.

Indeed.

> I've slightly looked at the generic pinconf stuff.  I think we
> should be able to support them, though the sunxi pinctrl driver
> currently doesn't work well with it though. For example, it doesn't
> declare ".is_generic = true", it doesn't filter unsupported pinconf
> parameters, and it doesn't reply to queries correctly. I will fix
> these bits.
> 
> Also, I think we are needlessly using pin groups, 1 pin per group.
> Can pinconf/pinctrl work without them? Would there be any harm
> converting the sunxi driver to work directly with pins? This would
> make it match generic pinconf parsing, and make it easier to get
> both working together.

I think it comes from a requirement that you had to have groups at
some point (I don't know if it's still the case), which is why we
ended up with single-pin groups, because we can mux each pins entirely
separately.

If it's not required anymore, then yes, it makes total sense to remove
it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/e9e0ca6b/attachment.sig>
