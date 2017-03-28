From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Tue, 28 Mar 2017 19:41:47 +0200
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170328164824.3qjaojqzf2riwpqj@kozik-lap>
References: <20170325162654.3827-1-krzk@kernel.org>
 <1564458.pWTRdRYEuG@positron.chronox.de>
 <20170328164824.3qjaojqzf2riwpqj@kozik-lap>
Message-ID: <93183073.lKE0KLq0vu@tauon.atsec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. M?rz 2017, 18:48:24 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> I tested a little bit and:
> 1. Seeding with some value
> 2. generating random,
> 3. kcapi_rng_destroy+kcrng_init, (I cannot do a hardware reset except
>    reboot of entire system)
> 4. seeding with the same value as in (1) - different random numbers.
> 
> Doing a system reboot and repeating above - different random numbers
> (all are different: step (2) and in (4)).
> 
> Your test case also produces different random values every time.

Then I would assume that simply adding an outer loop to your for() loop to 
inject seed larger than the minimum required seed size should be fine.
> 
> Best regards,
> Krzysztof



Ciao
Stephan
