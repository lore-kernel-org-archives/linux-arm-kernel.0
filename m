From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 15 Jul 2016 15:27:56 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
Message-ID: <20160715152756.db7375a7109fed18c2fbf43a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jul 2016 12:38:54 +0200
Ond?ej Jirman <megous@megous.com> wrote:

> > If so, then yes, trying to switch to the 24MHz oscillator before
> > applying the factors, and then switching back when the PLL is stable
> > would be a nice solution.
> > 
> > I just checked, and all the SoCs we've had so far have that
> > possibility, so if it works, for now, I'd like to stick to that.
> 
> It would need to be tested. U-boot does the change only once, while the
> kernel would be doing it all the time and between various frequencies
> and PLL settings. So the issues may show up with this solution too.

I don't think this is a good idea: the CPU clock may be changed at any
time with the CPUFreq governor. I don't see the system moving from
1008MHz to 24MHz and then to 1200MHz when some computation is needed!

BTW, Ond?ej, in my BPi M2+, I tried to change the CPU clock with your
code at kernel start time from 792MHz to 1008MHz, but the hardware
(arisc?) set an other value, and the system speed was lower than before
(the PLL-CPUx register is 0x90031521 on boot, I want to set it to
xxxx1410 and I read 0x91031f33 - sorry, I did not have a look at the
CPU SD pattern). Do you know why?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
