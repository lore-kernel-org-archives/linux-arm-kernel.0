From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 28 Nov 2014 10:57 +0100
Subject: [PATCH v12 0/3] ARM: rk3288: Add PM Domain support
In-Reply-To: <1416217842-4716-1-git-send-email-caesar.wang@rock-chips.com>
References: <1416217842-4716-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1454366.cVgT9MeyeC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. November 2014, 17:50:38 schrieb Caesar Wang:
>     Add power domain drivers based on generic power domain for
>     Rockchip platform, and support RK3288.
> 
>     https://chromium-review.googlesource.com/#/c/220253/9
>     This is the GPU driver, add the following information in DT,
>     and it can support the PMDOMAIN

I'm not sure what to do with this series. Kevin had concerns about the clocks 
being part of the power-domains and I don't see them actually addressed and/or 
Kevin being satisfied - actually he isn't even on the recipients list of this 
version of the series.


@Ceasar: you should include people being part of important previous 
conversations in new versions of patchsets - especially when they have voiced 
concerns.


I've added Tomasz whom I remember having previous experience on the Exynos 
Powerdomains, so maybe he can add some other perspective - new ideas.


@Tomasz: this is the part of Kevin's concerns from v10 of the powerdomain 
series:

Am Donnerstag, 13. November 2014, 12:24:47 schrieben Kevin Hilman:
> Heiko St?bner <heiko@sntech.de> writes:
> > Am Dienstag, 11. November 2014, 08:53:13 schrieb Kevin Hilman:
> >> I still don't like having lists of clocks in the power-domain DT.
> >> 
> >> DT is supposed to describe the hardware, and clocks are properties of
> >> devices, not power-domains, so the DT description should follow from
> >> that.
> > 
> > on the policy side one could argue that if the clock needs to be enabled
> > to
> > achieve sucessful domain state-changes, that it is also a property of the
> > domain itself in addition to the device.
> 
> You could, but from a hardware perspective, the clock is a property of
> the device.
> 
> > And on the pratical side we don't have drivers nor bindings for a big part
> > of the domain users - and this will probably be true for quite some time.
> > This of course makes it very impractical (or impossible) to collect the
> > clocks for parts like the gpu (mali), hevc, vcodec (video
> > encoder/decoder), rga (2d stuff), iep, isp.
> 
> This doesn't sound impossible at all.
> 
> You have to collect the clocks anyways.  The only debate is whether to
> list them in the device node or the power-domain node.
> 
> Even for devices without drivers, you just need a minimal node in the DT if
> which lists the clocks and has a phandle to the parent power domain.
> 
> Sounds rather simple to me, and since the DT is supposed to describe the
> hardware, doing it this way makes looking at the DT actually help
> understand the hardware.
