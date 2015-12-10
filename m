From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 10 Dec 2015 16:57:22 +0100
Subject: [PATCH v4 7/8] ARM: dts: Exynos5422: fix OPP tables
In-Reply-To: <56669126.7050803@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
 <56669126.7050803@samsung.com>
Message-ID: <2192451.zF6EhNeeQc@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, December 08, 2015 05:13:26 PM Krzysztof Kozlowski wrote:
> On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
> > From: Ben Gamari <ben@smart-cactus.org>
> > 
> > The Exynos 5422 is identical to the 5800 except for the fact that it
> > boots from the A7 cores. Consequently, the core numbering is different:
> > cores 0-3 are A7s whereas 4-7 are A15s.
> > 
> > We can reuse the device tree of the 5800 for the 5422 but we must take
> > care to override the OPP tables and CPU clocks.  These are otherwise
> > inherited from the exynos5800 devicetree, which has the CPU clusters
> > reversed compared to the 5422. This results in the A15 cores only
> > reaching 1.4GHz, the maximum rate of the KFC clock.
> > 
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5422-cpus.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> 
> This looks like a very-non-atomic way of handling a change. You added
> opp tables to exynos5420 before so at that time they will be applied to
> Odroid XU3 family which uses different CPU order. After that you are
> fixing the tables to proper CPU order. Direct bisectability probably
> won't be an issue because all of DTS would go to separate branch... but
> the logic behind confuses.

It was done this way to preserve original authorship of changes and
bisectability should not be affected unless patch #8 is merged before
patch #7.

> I think this should be squashed into 3/8.

OK.

> Best regards,
> Krzysztof

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
