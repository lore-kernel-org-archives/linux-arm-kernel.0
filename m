From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 11:01:53 +0200
Subject: [PATCH v4 4/8] dts: sun8i-h3: move uart1 pinmux/peripheral
 assocation to DSTI
In-Reply-To: <20160908080213.GA32547@carbon.kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-5-git-send-email-jorik@kippendief.biz>
 <20160908062317.GD8913@lukather>
 <20160908080213.GA32547@carbon.kippendief.biz>
Message-ID: <20160908090153.GL8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 10:02:13AM +0200, Jorik Jonker wrote:
> Maxime, Chen-Yu: thanks for taking the effort to go through my patches
> again!
> 
> On Thu, Sep 08, 2016 at 08:23:17AM +0200, Maxime Ripard wrote:
> >On Wed, Sep 07, 2016 at 09:58:57AM +0200, jorik at kippendief.biz wrote:
> >>From: Jorik Jonker <jorik@kippendief.biz>
> >>
> >>Users using this UART without RTS/CTS should override the association in
> >>their board specific DTS. All (1) board using this UART uses RTS/CTS, so
> >>this breaks nothing.
> >
> >Using RTS / CTS is very rare among the boards. Forcing it down the
> >throat of every user doesn't seem like the right thing to do.
> 
> So, I'm going for a v5, with these changes:
> - rename uart0_pins to uart0_pa_pins (as there could be a pf)
> - associate uart0_pa_pins with uart0 on all H3 board DTS files

Please don't. We use that naming scheme everywhere else. Plus, nothing
prevents any one from using one PF pin and one PA pin.

> - put rts/cts in seperate pinmux sets for uart1 (2,3: see below)
> - associate rx/tx for uart1-3 in H3 DTSI (this is the only option)

I'm still a bit skeptical about this. This wouldn't be in any way
consistant. I prefer to have something consistant and a bit duplicated
over something without any duplication but that confuses everyone
about what should be placed where.

> - associate UART1 rts/cts as pinctrl-1 in sun8i-h3-bananapi-m2-plus
>  (to prevent breakage for existing users)

You can also set it in pinctrl-0.

> I am a bit in doubt if I should include pinmux definitions for the following
> things, as Chen-Yu said to only include stuff that is actually used in a
> board:
> 
> - uart0_pf_pins, since there is no board using it
> - uart{2,3}_rts_cts, as I agree RTS/CTS is a bit exotic

Don't

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/72cc9805/attachment.sig>
