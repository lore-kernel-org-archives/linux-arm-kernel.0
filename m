From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Mar 2017 07:35:39 -0700
Subject: [PATCHv2 8/9] ARM: dts: omap4: add clkctrl nodes
In-Reply-To: <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-9-git-send-email-t-kristo@ti.com>
 <20170317154333.GW20572@atomide.com>
 <9456caee-4f45-044a-0b2e-305fa2d0d274@ti.com>
 <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
Message-ID: <20170320143538.GH20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170320 06:27]:
> On 17/03/17 23:41, Tero Kristo wrote:
> > On 17/03/17 17:43, Tony Lindgren wrote:
> > > * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> > > > Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
> > > > replacement for part of the existing clock data and the existing
> > > > clkctrl hooks under hwmod data.
> > > 
> > > It seems to be actually this patch in the series that breaks booting
> > > if the last patch in this series is not applied.
> > 
> > Yea I guess we need to squash this and patch #9, I'll double check next
> > week. Sorry about not catching this one.
> 
> Yes, patch #8 and #9 must be squashed. What happens with patch #8 alone, is
> that you get all the clkctrl clocks registered, but as nobody is using them,
> the clock core disables them later on in clk_disable_unused.

So how hard would it to do a mixed approach where we don't need
to have everything in place in the dts in order to flip a SoC?

This atomic transaction worries me..

Regards,

Tony
