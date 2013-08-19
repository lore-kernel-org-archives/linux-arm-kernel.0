From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 19 Aug 2013 08:15:35 -0700
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <159201ce9b36$2a513f30$7ef3bd90$@org> (Kukjin Kim's message of
 "Sat, 17 Aug 2013 19:40:18 +0900")
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
 <13b101ce9a14$2cebd700$86c38500$@org>
 <CAOesGMiyNM6VdNzKQU3XwoiacJV8hc60mcLiH+vHoS6xJM6q-A@mail.gmail.com>
 <159201ce9b36$2a513f30$7ef3bd90$@org>
Message-ID: <8738q5lnjc.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene@kernel.org> writes:

[...]

> If we could make LPAE enabled defconfig for all ARM platforms, I'm fine. I
> think your concern is creating SoC specific defconfig and I agree with you.
> But I'm not sure how we can support LPAE enabled defconfig for ARM
> platforms.

Here's a simple way to keep a single base defconfig, and enable LPAE:

$ echo CONFIG_ARM_LPAE=y > /tmp/lpae.config
$ ./scripts/kconfig/merge_config.sh arch/arm/config/exynos_defconfig /tmp/lpae.config

Kevin
