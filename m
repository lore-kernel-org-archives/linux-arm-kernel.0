From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Feb 2013 13:33:49 -0800
Subject: [PATCH] pinctrl/pinconfig: add debug interface
In-Reply-To: <51196161.7020901@wwwdotorg.org>
References: <1360527070-18430-1-git-send-email-linus.walleij@stericsson.com>
 <51195A63.7080706@wwwdotorg.org>
 <20130211210041.GW4801@atomide.com>
 <51195F00.4020309@wwwdotorg.org>
 <20130211212105.GX4801@atomide.com>
 <51196161.7020901@wwwdotorg.org>
Message-ID: <20130211213348.GY4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130211 13:27]:
> On 02/11/2013 02:21 PM, Tony Lindgren wrote:
> > * Stephen Warren <swarren@wwwdotorg.org> [130211 13:17]:
> >> On 02/11/2013 02:00 PM, Tony Lindgren wrote:
> >>> * Stephen Warren <swarren@wwwdotorg.org> [130211 12:57]:
> >>>> On 02/10/2013 01:11 PM, Linus Walleij wrote:
> >>>>> From: Laurent Meunier <laurent.meunier@st.com>
> >>>>>
> >>>>> This update adds a debugfs interface to modify a pin configuration
> >>>>> for a given state in the pinctrl map. This allows to modify the
> >>>>> configuration for a non-active state, typically sleep state.
> >>>>> This configuration is not applied right away, but only when the state
> >>>>> will be entered.
> >>>>>
> >>>>> This solution is mandated for us by HW validation: in order
> >>>>> to test and verify several pin configurations during sleep without
> >>>>> recompiling the software.
> >>>>
> >>>> I never understood why HW engineers can't just recompile the kernel.
> >>>> Besides, it's just a device tree change these days - no recompile even
> >>>> required, right?
> >>>
> >>> Typically when bringing up a new board you do not have the driver
> >>> specific mux settings verified. For developers, it's easiest to tweak
> >>> the muxing during runtime do the drivers as a loadable module, then
> >>> export the verified mux configuration into a .dts file.
> >>
> >> Well HW engineers typically just write to the HW registers directly
> >> rather than screwing around with the Linux pinctrl tables and
> >> unloading/reloading drivers.
> > 
> > I've seen cases where most of the mux register configuration are
> > done correctly by HW engineers.. But there's always been some pieces
> > of the pin configuration wrong initially and that needs to be fixed by
> > the driver people to get things working.
> > 
> > Being able to set the mux configuration via debugfs is also very
> > useful for the case of adding external devices to your proto boards
> > like beagle etc.
> 
> This patch won't work for that, since it doesn't support adding new
> entries to the mux table, just editing existing entries.

Being able to change the existing mux entries still helps developers to
debug things like pull values needed for i2c device impedance etc.

Regards,

Tony
