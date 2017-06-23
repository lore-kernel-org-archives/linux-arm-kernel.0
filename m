From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 16:44:10 +0200
Subject: [GIT PULL] CCN drivers fixes for 4.13
In-Reply-To: <1498228494.6830.8.camel@arm.com>
References: <1498228494.6830.8.camel@arm.com>
Message-ID: <CAK8P3a2wKDThMvqivHAENhjZCoOOhyrohZqMQx8xboESgomu2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 4:34 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> Greetings,
>
> I've got a small series of fixes for the CCN driver. A long belated
> one... Apologies to all authors for delaying it way over any sensible
> time frame!
>
> If possible, they could go in for 4.13, they are pretty small and
> independent from anything else.

Did you mean 4.12 rather than 4.13?

> bus: ARM CCN PMU driver updates
>
> * Fixed missing module aliases, thus autoloading.
> * Use appropriate (c)allocation function for arrays of structures.
> * Add compatibility string (thus support) for CCN-502 variant.
>
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       bus: arm-ccn: Fix module autoload
>
> Markus Elfring (1):
>       bus: arm-ccn: Use devm_kcalloc() in arm_ccn_probe()
>
> Velibor Markovski (2):
>       dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
>       bus: arm-ccn: Enable stats for CCN-502 interconnect

If it's for 4.12, I'd prefer this to not contain the second patch, which seems
to be just a cosmetic cleanup (there can't be any overflow here).

If you want them in 4.13 instead, please rebase the branch on top of
4.12-rc1 to avoid backmerging -rc6 into our driver branch.

        Arnd
