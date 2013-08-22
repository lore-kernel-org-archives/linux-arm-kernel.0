From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Aug 2013 09:20:24 -0700
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <1c7e01ce9f1d$bf4967d0$3ddc3770$@org>
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
 <13b101ce9a14$2cebd700$86c38500$@org>
 <CAOesGMiyNM6VdNzKQU3XwoiacJV8hc60mcLiH+vHoS6xJM6q-A@mail.gmail.com>
 <159201ce9b36$2a513f30$7ef3bd90$@org> <8738q5lnjc.fsf@kernel.org>
 <1c7e01ce9f1d$bf4967d0$3ddc3770$@org>
Message-ID: <CAOesGMhSsWp1ECuGfoB1P4TmZzc-bbDET5DwwdbvvJfJ2k2xJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Thu, Aug 22, 2013 at 2:55 AM, Kukjin Kim <kgene@kernel.org> wrote:
> Yeah, it can be used for test. But there are many differences between
> exynos_defconfig and exynos5440_defconfig...PCIe, GbE, HugeTLB and KVM...so
> I'm still wondering how to handle it without other defconfig.
>
> Olof, do you still having objection for exynos5440_defconfig? If so, OK I
> will revert exynos5440_defconfig for now so that I could pull out the
> 'defconfig' branch to arm-soc for upcoming merge window. Then, let's discuss
> again :)

As far as I see it, you have two options:

1. Add the needed drivers to multi_v7_defconfig and use that for your platform.
2. Add them to both multi_v7_defconfig and exynos_defconfig.

Enabling the new drivers on exynos_defconfig does no harm.

I don't want to see a new defconfig for this.


-Olof
