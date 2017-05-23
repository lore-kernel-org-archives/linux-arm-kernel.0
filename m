From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 May 2017 16:20:21 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: add sdhci
In-Reply-To: <20170516171159.GH22219@n2100.armlinux.org.uk> (Russell King's
 message of "Tue, 16 May 2017 18:11:59 +0100")
References: <E1dAcn4-0004z2-Fl@rmk-PC.armlinux.org.uk>
 <CAPv3WKf4GcOc7g-2yMCjGN4HrftDL0Ro6jHErQL8-zSH-tC10w@mail.gmail.com>
 <CAPv3WKeK9Z_1dGvBnc=NJrD7+nZOgf60iCNvvTkFGcP7GSyt=Q@mail.gmail.com>
 <20170516171159.GH22219@n2100.armlinux.org.uk>
Message-ID: <878tlny7ru.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mar., mai 16 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> >>
>> >> +&ap_sdhci0 {
>> >> +       bus-width = <8>;
>> >> +       /*
>> >> +        * Not stable in HS modes - phy needs "more calibration", so add
>> >> +        * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
>> >> +        */
>> >> +       marvell,xenon-phy-slow-mode;
>> >
>> >
>> > FYI, this property is by default present in armada-ap806.dtsi.
>
> Yes, it may be, it's unclear (at least to me) whether this is a board
> problem or a SoC problem.  Given that it's at the SoC layer, it suggests
> there's a SoC/driver problem that needs resolving.

According to the feedback I got from Marvell the issue is at SoC level,
it seemed there was a integration problem of the Xenon IP inside the
AP806 so I don't expect it will ever work.

Gregory

>
> However, given that the board is tested only in non-HS mode at the
> moment, having the property in place is the sensible thing, even though
> the SoC level currently has the property.  If we can prove that the
> board is capable of HS modes, then I'd be happy to remove it, but not
> before.  It could be that even if the SoC level is capable of HS modes,
> the board may not support them.
>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
