From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 11:51:08 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
Message-ID: <20160721095108.GJ5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 03:27:56PM +0200, Jean-Francois Moine wrote:
> On Fri, 15 Jul 2016 12:38:54 +0200
> Ond?ej Jirman <megous@megous.com> wrote:
> 
> > > If so, then yes, trying to switch to the 24MHz oscillator before
> > > applying the factors, and then switching back when the PLL is stable
> > > would be a nice solution.
> > > 
> > > I just checked, and all the SoCs we've had so far have that
> > > possibility, so if it works, for now, I'd like to stick to that.
> > 
> > It would need to be tested. U-boot does the change only once, while the
> > kernel would be doing it all the time and between various frequencies
> > and PLL settings. So the issues may show up with this solution too.
> 
> I don't think this is a good idea: the CPU clock may be changed at any
> time with the CPUFreq governor. I don't see the system moving from
> 1008MHz to 24MHz and then to 1200MHz when some computation is needed!

It wouldn't happen that often. The sampling rate for the governor is
1000 times the latency, so, at most, 0.1% of the time would be spent
at 24MHz.

And if you're really concerned about performances, you won't enable
cpufreq anyway.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/c73e8efe/attachment-0001.sig>
