From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 18 Dec 2016 07:06:27 +0900
Subject: [PATCH v8 6/8] ARM: EXYNOS: remove secondary startup
 initialization from smp_prepare_cpus
In-Reply-To: <20161217184806.GB30265@kozik-lap>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
 <1481375323-29724-7-git-send-email-pankaj.dubey@samsung.com>
 <20161217184806.GB30265@kozik-lap>
Message-ID: <CAGTfZH2WiaKBrZqv6GsLiScs--A=tfer6H7PS6Ok+ADi20e9NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

2016-12-18 3:48 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sat, Dec 10, 2016 at 06:38:41PM +0530, Pankaj Dubey wrote:
>> We are taking care of setting secondary cpu boot address in
>> exynos_boot_secondary just before sending ipi to secondary CPUs,
>> so we can safely remove this setting from smp_prepare_cpus.
>
> Indeed setting boot address is doubled. However between them, the power
> is turned on and Exynos3250 is being restarted.
>
> It would be nice to test it on Exynos3250 (Artik5 or Gear2?) and some of
> Exynos4 family. Beside that looks good to me, I just want to see some
> tested-by.

I'll test it on Exynos3250(gear2,artik5) and Exynos4(trats2) on Monday
and send the test result.

Best Regards,
Chanwoo Choi

[snip]
