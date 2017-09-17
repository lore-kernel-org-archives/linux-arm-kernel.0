From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 17 Sep 2017 09:34:05 +0200
Subject: [PATCH v2] ARM: dts: exynos: fix incomplete Odroid-XU3/4
 thermal-zones definition
In-Reply-To: <20170908164015.rayfh2kluy45ktfi@kozik-lap>
References: <CGME20170907161007epcas1p316fba6e329eaabedde8a98628ebb9751@epcas1p3.samsung.com>
 <1848394.K3C0KxojUN@amdc3058>
 <20170908164015.rayfh2kluy45ktfi@kozik-lap>
Message-ID: <20170917073405.GB19716@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 06:40:15PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 07, 2017 at 06:10:00PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > From: Willy Wolff <willy.mh.wolff@gmail.com>
> > 
> > Odroid XU3/4 boards have thermal sensors per 4 pairs of A7+A15
> > cores but currently there is only one thermal-zone (including
> > cooling maps) defined (for the first pair of cores - the first
> > core of the A7 cluster and the first core of A15 cluster) so
> > i.e. if the task is running on any of A15 cores but the first
> > one, such core can reach high temperature without any proper
> > cooling action.
> > 
> > Fix it by adding missing thermal-zones definitions.
> > 
> > Also while at it fix the number of steps in cpufreq cooling for
> > cpu4 (11 steps for A15 corresponds to 700MHz, for 600MHz 12 steps
> > should be used).
> > 
> > Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Kukjin Kim <kgene@kernel.org>
> > [b.zolnierkie: rewrote patch subject & description + minor fixups]
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Thanks for taking care of this. I'll take it after merge window.

Thanks, applied.

Best regards,
Krzysztof
