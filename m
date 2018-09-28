From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 28 Sep 2018 18:34:55 +0200
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
In-Reply-To: <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
 <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
 <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
Message-ID: <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/28/2018 03:54 PM, Krzysztof Kozlowski wrote:
> On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
>> config option) is not working properly (debug messages are not
>> displayed after resume) on Exynos platforms because GPIOs restore
>> code is not implemented.
> 
> AFAIR, it worked properly for the suspend part showing more logs.
> Unless it changed, the feature looks still useful.

Yes, it shows few additional messages from mach/plat specific suspend
code but it breaks the assumption that features (even debug ones)
work correctly and make you invest time in debugging known broken
code.

In case it is needed/useful (which should be rather rare situation)
one can always easily revert the commit locally.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
