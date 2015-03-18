From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 18 Mar 2015 15:16:45 +0100
Subject: [PATCH v3 1/4] ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on
 Exynos3250
In-Reply-To: <1426685545.23982.2.camel@AMDC1943>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
 <3449559.PngGo6WKuq@amdc1032> <1426685545.23982.2.camel@AMDC1943>
Message-ID: <5511908.Xj1ZIW6HbI@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 18, 2015 02:32:25 PM Krzysztof Kozlowski wrote:
> On ?ro, 2015-03-18 at 14:23 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> > 
> > On Wednesday, March 18, 2015 02:10:31 PM Krzysztof Kozlowski wrote:
> > > 2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> > > >
> > > > +       while (!pmu_raw_readl(S5P_PMU_SPARE2))
> > > > +               udelay(10);
> > > > +       udelay(10);
> > > 
> > > We really need to start documenting this. Please add short description
> > > why this SPARE2 check is here and who uses it. Without documenting
> > > this behavior future generations won't be able to debug this stuff.
> > > Imagine replacing sboot with uboot by someone...
> > 
> > I've already planned to do this for this code and for coupled cpuidle
> > use of SPARE2 as well.  However I would really prefer to do it in
> > an incremental patch if there are no other issues with this patchset.
> 
> OK, please do so in incremental patch. Usage of various memory regions

OK.

> of sysram also should be documented. In patch 2 you add usage of 0x28 +
> 4*cpu. The various sysrams regions are spread over different files...

I completely agree that there should be some Documentation file with
the SYSRAM layout.  I'll do it later unless someone beats me to it (please
also add this to our internal TODO list of open issues, thanks!).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
