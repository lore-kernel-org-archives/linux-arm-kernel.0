From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 18 Mar 2017 11:25:54 +0200
Subject: Question - seeding the hw pseudo random number generator
Message-ID: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I looked at Exynos Pseudo Random Nubmer Generator driver
(drivers/char/hw_random/exynos-rng.c) and noticed that it always seeds
the device with jiffies.  Then I looked at few other drivers and found
that they do not seed themself (or at least I couldn't find this).

I think the hw_random API does not provide generic infrastructure for
seeding.

What is the preferred approach for seeding a PRNG device? Use jiffies or
a fixed value?

Or maybe the interface should be abandoned in favor of crypto API?

Best regards,
Krzysztof
