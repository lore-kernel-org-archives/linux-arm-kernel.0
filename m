From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 22:00:45 +0800
Subject: MX28 fec clock frequency
In-Reply-To: <4F0C384F.10706@prolan.hu>
References: <4F06D643.6080602@prolan.hu>
 <20120108033238.GA19721@S2101-09.ap.freescale.net>
 <4F0AF4B0.4030403@prolan.hu>
 <20120110082138.GF23362@S2101-09.ap.freescale.net>
 <4F0C384F.10706@prolan.hu>
Message-ID: <20120110140043.GC26599@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 02:08:31PM +0100, Peter Rusko wrote:
> >I'm not sure it's causing the problem you are seeing.  But from i.MX28
> >spec, it seems that bit BUSY_TIME of register HW_CLKCTRL_ENET should
> >be polled for new divider setting?
> >
> 
> Thank you, I've added the check, but unfortunately it didn't help :(
> 
Another point worth checking is bit field ATIME_INC of register
HW_ENET_MAC_ATIME_INC.  It should be 25 if your CLK_ENET_TIME runs
at 40 MHz.

-- 
Regards,
Shawn
