From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:23:25 +0200
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <20150803083751.1BCF56C80391@dd34104.kasserver.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
 <20150803083751.1BCF56C80391@dd34104.kasserver.com>
Message-ID: <20150803092325.GA2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 10:37:51AM +0200, Timo Sigurdsson wrote:
> Hi Julian,
> 
> Julian Calaby schrieb am 03.08.2015 01:35:
> >> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20
> >> boards
> >> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
> >> voltage for the lowest operating point to 1.0V so all boards can actually use
> >> it.
> > 
> > Surely it wouldn't be added here if some could supply 0.9v.
> 
> Maybe. I just know some boards don't (e.g. Cubieboard 2, Cubietruck, BananaPi)
> and don't know of any that does. But that's not my point. I think that a common
> minimum operating point, defined on the SOC level, should be defined in a way
> that works on all boards.

All of them can supply it. The DCDC2 regulator they use for the CPU
can go as low as 0.7V. The question is whether the CPU itself can work
at such a low voltage. And the operating limits for the CPU is
documented to be 1V - 1.4V. Anything else is either over or
underclocking, which might or might not work on individual SoCs. So
it's not something that we're going to support.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/3773a03f/attachment.sig>
