From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Mon,  3 Aug 2015 10:37:51 +0200 (CEST)
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de><CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
Message-ID: <20150803083751.1BCF56C80391@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

Julian Calaby schrieb am 03.08.2015 01:35:
>> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20
>> boards
>> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
>> voltage for the lowest operating point to 1.0V so all boards can actually use
>> it.
> 
> Surely it wouldn't be added here if some could supply 0.9v.

Maybe. I just know some boards don't (e.g. Cubieboard 2, Cubietruck, BananaPi)
and don't know of any that does. But that's not my point. I think that a common
minimum operating point, defined on the SOC level, should be defined in a way
that works on all boards.

> 
> Is the code that uses this smart enough to sensibly switch between two
> operating points with the same frequency and different voltages? If
> so, maybe just add a 144MHz @ 1.0v operating point?

I never tried and I probably won't have time to test that before the weekend.
The current behaviour is this, though: On boards that set their minimum CPU
voltage to 1.0V, the lowest operating point will simply not be available to
the user.

> (Alternatively, would it make sense to modify the code that uses this
> to use frequencies with voltages specified that are lower than can be
> supplied with the lowest voltage it can?)

Considering OPPv2 is in the works, maybe not?


Thanks,

Timo
