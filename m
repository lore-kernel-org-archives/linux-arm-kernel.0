From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 15:54:03 +0100
Subject: [PATCH 3/5] ARM: berlin/dt: add cpupll and syspll support to BG2Q
In-Reply-To: <532C30AB.5020108@gmail.com>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395402220-23503-4-git-send-email-alexandre.belloni@free-electrons.com>
 <532C2C71.4010703@gmail.com> <20140321121741.GB6443@piout.net>
 <532C30AB.5020108@gmail.com>
Message-ID: <20140321145403.GC6443@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/2014 at 13:29:31 +0100, Sebastian Hesselbarth wrote :
> >>Hmm, you probably know better than me, but if cpuclk == cpupll
> >>is always true we don't need another clk layer here. If you
> >>can scale down cpuclk from cpupll and we just have no driver
> >>for it, I am fine with it.
> >>
> >
> >You can actually switch CPU clk from CPU pll to smclk. I'm not sure this
> >is completely useful yet though, probably for suspend ?
> 
> Then it should be clk mux instead?
> 
> >Also, while I'm not sure this is a good reason, other clocks are derived
> >from CPU pll and have another divider.
> 
> I have no strong opinion, but a fixed-factor-clock with 1:1 just to
> rename cpupll to cpuclk seems a bit wasty ;)
> 
> If there is a mux, we should add it now - no matter if we are ever
> going to make any use of it. For the derived clocks we should be
> careful if they actually depend on cpuclk or always cpupll.
> 
> If your (current) knowledge of the berlin clock trees is almost as
> bad as mine, we can also ignore cpuclk mux if you prefer.
> 

Yeah, fact is I know there is a mux but I don't know yet how to get/set
its state so I will ignore it until we have more info.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
