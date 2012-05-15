From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 15 May 2012 12:00:14 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <20120515111757.32847b91@skate> (Thomas Petazzoni's message of
 "Tue, 15 May 2012 11:17:57 +0200")
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091218.GB6820@lunn.ch> <20120515111757.32847b91@skate>
Message-ID: <87y5otepch.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

Hi,
> Hello Andrew,
>
> Thanks for the quick feedback!
>
> Le Tue, 15 May 2012 11:12:18 +0200,
> Andrew Lunn <andrew@lunn.ch> a ?crit :
>
>> > +/include/ "armada.dtsi"
>> > +
>> > +/ {
>> > +	model = "Marvell Armada 370 family SoC";
>> > +	compatible = "marvell,armada370", "marvell,armada";
>> 
>> It should be mrvl, not marvell, in all the compatibility strings.
>
> Ok, we will change that.
>
>> Also, we need to be careful with armada. kirkwood is an armada for
>> example. It maybe be better to not actually use armada without
>> postfix.
>
> Do you have a recommendation for this? We support both Armada 370 and
> Armada XP, so the obvious common prefix for these two platforms is
> "armada". Since kirkwood are ARMv5 and those new Armada are ARMv7,
> would armadav7 be a better prefix? Then we could have armadav7-370 and
> armadav7-xp? Other suggestions?

Please be carefull with what you'll choose. There's also Dove SoCs
which are v7 too (88AP510 / armada 510 in Marvell namings). I would be
tempted to use "mrvl,dove" like was what was used for kirkwood so this
won't conflict but still, can be quite confusing.

Regards,
Arnaud
