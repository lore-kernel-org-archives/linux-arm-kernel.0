From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 30 Sep 2018 14:38:28 +0200
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
In-Reply-To: <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
 <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
 <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
 <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
Message-ID: <20180930123828.GA10619@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 06:34:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> 
> On 09/28/2018 03:54 PM, Krzysztof Kozlowski wrote:
> > On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> >>
> >> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> >> config option) is not working properly (debug messages are not
> >> displayed after resume) on Exynos platforms because GPIOs restore
> >> code is not implemented.
> > 
> > AFAIR, it worked properly for the suspend part showing more logs.
> > Unless it changed, the feature looks still useful.
> 
> Yes, it shows few additional messages from mach/plat specific suspend
> code but it breaks the assumption that features (even debug ones)
> work correctly and make you invest time in debugging known broken
> code.

OK, let's remove it. However in such case this change leaves useless
S3C_PMDBG and other s3c_pm_* in Exynos code. They should go away along
with SAMSUNG_PM_DEBUG.

Best regards,
Krzysztof

> 
> In case it is needed/useful (which should be rather rare situation)
> one can always easily revert the commit locally.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
