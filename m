From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 21 Dec 2012 00:13:48 +0200
Subject: [PATCH 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <50D34630.9020708@arm.com>
References: <50D305A6.2080904@arm.com>
 <20121220125507.GB6819@tbergstrom-lnx.Nvidia.com>
 <50D31365.9000009@arm.com>
 <20121220.164230.292625215885249791.hdoyu@nvidia.com>
 <50D34630.9020708@arm.com>
Message-ID: <20121220221348.GB19766@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > "tegra114.dtsi" has the folloiwng "tsc" entry. So can we consider that
> > if dts has this entry, CNTFRQ is not set, which implies it's in secure
> > mode. kernel should set it up by itself? Otherwise, skip this setup
> > and use it. For example:
> > 
> >  	tsc {
> >  		compatible = "nvidia,tegra114-tsc";
> >  		reg = <0x700f0000 0x20000>;
> > +		setup-cntfrq;
> >  	};
> > 
> > Is this what you explained in the above?
> > At least, kernel can survive without bootloader/firmware support, ATM.
> 
> No. The DT should only describe the hardware, and not something that is
> Linux specific.
> 
> Just use the "clock-frequency" attribute in the timer arch-timer node,
> and get rid of this CNTFRQ setting. The driver already knows how to deal
> with this situation if this attribute is set.

The frequency is probed at boottime by the kernel though. It will not
necessarily be the same for every board.

Cheers,

Peter.
