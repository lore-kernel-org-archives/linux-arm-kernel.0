From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 15 Aug 2014 09:32:16 -0700
Subject: [PATCH v2] cpuidle/cpuidle-big_little: fix reading cpu id part
 number
In-Reply-To: <1408004865-27525-1-git-send-email-juri.lelli@arm.com> (Juri
 Lelli's message of "Thu, 14 Aug 2014 09:27:45 +0100")
References: <1408004865-27525-1-git-send-email-juri.lelli@arm.com>
Message-ID: <7hwqa9ww6n.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juri Lelli <juri.lelli@arm.com> writes:

> Commit af040ffc9ba1 ("ARM: make it easier to check the CPU part number
> correctly") changed ARM_CPU_PART_X masks, and the way they are returned and
> checked against. Usage of read_cpuid_part_number() is now deprecated, and
> calling places updated accordingly. This actually broke cpuidle-big_little
> initialization, as bl_idle_driver_init() performs a check using an hardcoded
> mask on cpu_id.
>
> Create an interface to perform the check (that is now even easier to read).
> Define also a proper mask (ARM_CPU_PART_MASK) that makes this kind of checks
> cleaner and helps preventing bugs in the future. Update usage accordingly.

[...]

Tested-by: Kevin Hilman <khilman@linaro.org>

FWIW, I can confirm that this patch is needed for cpuidle-big_little to
work on the Exynos5800/Chromebook2.

Kevin
