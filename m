From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 28 Aug 2012 08:51:44 +0200
Subject: [PATCH 05/14] ARM: at91: add pinctrl support
In-Reply-To: <CACRpkdYWXZLNdgMhqoMZsaaszZ5Uz9pZ1EO=mrnuY5Der4O+Mw@mail.gmail.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-5-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdZ2__V06Eo8JH451Sup5Nw2jJXVOH2FOfZBp5nNYpCtbg@mail.gmail.com>
 <5034FC18.2090400@wwwdotorg.org>
 <CACQ1gAieByr5vMmyyCuGtS8AgnnRZPPhLZY8sKvwvcQYe5ieUA@mail.gmail.com>
 <50366D2B.4010807@wwwdotorg.org> <20120825083811.GB7629@game.jcrosoft.org>
 <CACRpkdYWXZLNdgMhqoMZsaaszZ5Uz9pZ1EO=mrnuY5Der4O+Mw@mail.gmail.com>
Message-ID: <CACQ1gAiFQAwn34mCYXWi9cTZPLRNiDVHT0qLNtJ4cgL51kRQBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/28 Linus Walleij <linus.walleij@linaro.org>:
> I'm following it now I think, after some discussion here at the kernel summit
> I have come to the conclusion that the real problem with readability comes
> from a shortcoming in the device tree compiler, that it cannot handle
> macros and defines (no preprocessor) so it's currently hard to make
> it more readable.
Definitively, I've seen quite some hex (or dec) voodoo with comment
next to them like that:
fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
linux,code = <102>; /* KEY_HOME */
linux,code = <158>; /* KEY_BACK */
fsl,pinmux-ids = <
		0x0180 /* MX28_PAD_GPMI_RDN__GPMI_RDN */
		0x0190 /* MX28_PAD_GPMI_WRN__GPMI_WRN */
		0x01c0 /* MX28_PAD_GPMI_RESETN__GPMI_RESETN */
		>;
Those bits of code are crying out "We want defines !"
(And even bitwise OR would be usefull, instead of having to choose
between hex voodoo and one bool for each bit in a register)

> But that's not the implementers fault so I'm OK with this looking like
> this for the moment.
>
> Yours,
> Linus Walleij

Best regards,
Richard.
