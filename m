From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 22 Aug 2013 18:55:35 +0900
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <8738q5lnjc.fsf@kernel.org>
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
 <13b101ce9a14$2cebd700$86c38500$@org>
 <CAOesGMiyNM6VdNzKQU3XwoiacJV8hc60mcLiH+vHoS6xJM6q-A@mail.gmail.com>
 <159201ce9b36$2a513f30$7ef3bd90$@org> <8738q5lnjc.fsf@kernel.org>
Message-ID: <1c7e01ce9f1d$bf4967d0$3ddc3770$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> 
> Kukjin Kim <kgene@kernel.org> writes:
> 
> [...]
> 
> > If we could make LPAE enabled defconfig for all ARM platforms, I'm fine.
> I
> > think your concern is creating SoC specific defconfig and I agree with
> you.
> > But I'm not sure how we can support LPAE enabled defconfig for ARM
> > platforms.
> 
> Here's a simple way to keep a single base defconfig, and enable LPAE:
> 
> $ echo CONFIG_ARM_LPAE=y > /tmp/lpae.config
> $ ./scripts/kconfig/merge_config.sh arch/arm/config/exynos_defconfig
> /tmp/lpae.config
> 
Yeah, it can be used for test. But there are many differences between
exynos_defconfig and exynos5440_defconfig...PCIe, GbE, HugeTLB and KVM...so
I'm still wondering how to handle it without other defconfig.

Olof, do you still having objection for exynos5440_defconfig? If so, OK I
will revert exynos5440_defconfig for now so that I could pull out the
'defconfig' branch to arm-soc for upcoming merge window. Then, let's discuss
again :)

Thanks,
Kukjin
