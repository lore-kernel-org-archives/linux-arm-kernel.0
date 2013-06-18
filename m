From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Jun 2013 13:15:20 -0700
Subject: [PATCH v2 00/38] Thirty eight patches big Exynos cleanup
In-Reply-To: <201306182029.09790.arnd@arndb.de>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <51C09E3C.5050108@samsung.com> <44244927.ekNqhkrd4q@flatron>
 <201306182029.09790.arnd@arndb.de>
Message-ID: <CAOesGMi_M445-1Myd0Xd2b2okWxKRnvo=gAffgChMjGWVVpxzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 18 June 2013, Tomasz Figa wrote:
>> OK. Looking forward to it.
>>
>> Btw. This leaves us with two things broken:
>>  - sdhci-s3c checks for defined(CONFIG_SOC_EXYNOS4212), but does not check
>> for defined(CONFIG_SOC_EXYNOS4412),
>>  - exynos-thermal checks for defined(CONFIG_SOC_EXYNOS4412), but does not
>> check for defined(CONFIG_SOC_EXYNOS4212).
>>
>> I think this must be fixed, because selecting only Exynos4212 in kernel
>> config you end up without exynos-thermal, while selecting only Exynos4412
>> breaks sdhci-s3c.
>
> I wonder what we actually gain by having all these fine-grained checks
> in the kernel. Why not just reduce the compile-time checks to just
> EXYNOS4 and EXYNOS5?
>
> The drivers can easily implement code for all variants using
> run-time checks, but I think it would be easier if building an EXYNOS4
> kernel would just run on all EXYNOS4 machines.

Agreed.

These fine-grained dependencies tend to be useful on very low-end
systems where every byte of memory counts, but on modern platforms
such as Exynos the maintainability of the code trumps the last few
bytes of savings, I'd say.


-Olof
