From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Oct 2018 12:09:44 +0200
Subject: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
In-Reply-To: <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
 <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
 <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
 <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
Message-ID: <CAJKOXPfRcNQb2yd0oaLStDDcQZBV+MXnhWesSBvOCyT7mCd+FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Oct 2018 at 11:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> Is it still valid that the Exynos has locking issues?

The prepare lock of clocks was not solved entirely. We just
implemented a set of workarounds.

> Or is it enabled 'just-in-case'?

Yes, all debugging features are implemented just in case to spot any
issue as early as possible.

> On arm64 the config misses that setting.
> Should be enabled there as well?

Because it is a shared defconfig among all platforms and apparently no
one wanted to convincing others to enable it.

> You have introduced this entry a year ago, probably during bug
> investigation.

Actually not, I enabled it much later after issues where discovered.

> The issue is in lockdep, the setting which enables it in Exynos
> is prove_locking. For now, just get rid of the second.
> My tests showed lockdep impact and not other minor debug features
> enabled.

You did not reply directly to my comment - you disabled all debug for
locking. It seems you are unaware of this so I question your test
results. If you run tests on this patch, then basically you compared
existing config with a config stripped out of debugging around locks.
I understand that this is not what you wanted...

Best regards,
Krzysztof
