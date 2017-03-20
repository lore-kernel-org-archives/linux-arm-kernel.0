From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Mon, 20 Mar 2017 12:19:32 +0530
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
Message-ID: <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I looked at Exynos Pseudo Random Nubmer Generator driver
> (drivers/char/hw_random/exynos-rng.c) and noticed that it always seeds
> the device with jiffies.  Then I looked at few other drivers and found
> that they do not seed themself (or at least I couldn't find this).

HW random interface is meant for true RNG, not pseudo RNG. Actually
PRNGs should use AF_ALG interface. I think exynos-rng.c should follow
the same.

> I think the hw_random API does not provide generic infrastructure for
> seeding.
>
> What is the preferred approach for seeding a PRNG device? Use jiffies or
> a fixed value?
>
> Or maybe the interface should be abandoned in favor of crypto API?

AF_ALG interface for rng does have seeding support. I think hw_random
does not provide seeding support intentionally as I understand that
True RNG need not require seeding (please correct me if I am wrong).

Regards,
PrasannaKumar
