From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 23 Apr 2016 16:22:23 +0200
Subject: [PATCH v4 4/5] dt-bindings: arm: add DT binding for Marvell
 CP110 system controller
In-Reply-To: <CAMuHMdVYtXEZF0+G3W+Q8cDcBFB55s1ru6N6J3tgFy9BcGZiXw@mail.gmail.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160328194756.GA28967@rob-hp-laptop>
 <20160413180122.4f997a9a@free-electrons.com>
 <CAMuHMdVYtXEZF0+G3W+Q8cDcBFB55s1ru6N6J3tgFy9BcGZiXw@mail.gmail.com>
Message-ID: <20160423162223.16e3ca28@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 14 Apr 2016 21:19:54 +0200, Geert Uytterhoeven wrote:

> From my experience with clock drivers for Renesas SoCs, life is much easier
> when handling all of this (clock names, parents, ...) in C. The same is true
> BTW for PM Domains.
> 
> The clock controllers of r8a7791 and r8a7795 are very similar, and could
> be handled similarly.
> Compare the DT hierarchy for CPG and MSTP/MSSR in
> arch/arm/boot/dts/r8a7791.dtsi and arch/arm64/boot/dts/renesas/r8a7795.dtsi.

Thanks for your feedback. However in practice, there will ultimately be
two instances of this clock controller, as some variants of the SoC
will contain two CP parts. Due to this, it is going to be quite
convenient to have the clock names configurable from the DT, as I will
be able to give the same clock on the master CP and the slave CP a
different name.

That's actually why my binding documentation uses names like
"cpm-<foo>" for all the clocks, where "cpm" stands for "CP Master". In
the future, another instance will have clocks named "cps-<foo>" for "CP
Slave".

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
