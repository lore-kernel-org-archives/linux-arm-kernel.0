From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Feb 2015 15:03:03 +0100
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x
 Device Tree
In-Reply-To: <CAPv3WKezrx4jkZNo3PYSOGZtiSJH09+94BaknYNN4xPkB1AxKw@mail.gmail.com>
References: <1424901482-3809-1-git-send-email-mw@semihalf.com>
 <1424901482-3809-3-git-send-email-mw@semihalf.com>
 <54EE4AD6.6090101@gmail.com>
 <CAPv3WKf8b+fuB-4qVwKC57iKaNHTLZAf9VFpfDbow1Sb3YAsNw@mail.gmail.com>
 <54EE6942.9080800@gmail.com>
 <CAPv3WKezrx4jkZNo3PYSOGZtiSJH09+94BaknYNN4xPkB1AxKw@mail.gmail.com>
Message-ID: <20150227150303.2c4ea0e7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 26 Feb 2015 10:05:08 +0100, Marcin Wojtas wrote:

> > Given that this PLL layout is most likely 38x specific, I'd just put it
> > into drivers/clk/mvebu/armada-38x.c.
> 
> Audio PLL setting consist of 3 independent registers. Adjacent to them
> there are same regs for setting TDM PLL, however I doubt  telephony is
> going to be supported in foreseeable future (if ever).

We might be supporting TDM in the future. However, I see that the TDM
PLL registers are nicely grouped together, and so are the audio PLL
registers. So maybe we can simply have a driver to handle the audio PLL
registers for now, and if needed in the future, add another driver for
the TDM PLL.

> I also have strong suspicion that it looks the same in a39x - Thomas,
> can you take a look into spec and confirm?

As far as I can see there is no audio support and no TDM support in
Armada 39x, and there those TDM PLL and audio PLL registers do not
exist.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
