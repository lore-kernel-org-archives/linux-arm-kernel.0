From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 14 Mar 2012 15:32:49 +0530
Subject: [PATCH v3 0/4] ARM: Exynos4: Add irq domain and device tree
 support for wakeup interrupts
In-Reply-To: <4F5A30B8.6060801@samsung.com>
References: <1329912858-32750-1-git-send-email-thomas.abraham@linaro.org>
 <4F5A30B8.6060801@samsung.com>
Message-ID: <CAJuYYwQxiz9tcx=15MK2vvhR71yhQyFBXrVDR0QO4YDdJ4Xvbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Kim,

On 9 March 2012 22:02, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 02/22/12 04:14, Thomas Abraham wrote:
>>
>> Changes since v2:
>> - Reworked irq domain support based on v5 of the irq_domain generalization
>> ? patches.
>>
>> Changes since v1: (only patch 4/4 has changes)
>> - Fixes based on Rob's comments:
>> ? a. Fixed the function prototype of exynos4_init_irq_eint(void)
>> ? b. Included interrupt-parent as an optional property for wakeup
>> interrupt
>> ? ? ? controller node.
>>
>> Samsung Exynos4 includes 32 external wakeup interrupt sources. The first
>> 16
>> of these interrupts are connected to GIC SPI[31:16]. The last 16 of these
>> interrupts are grouped together into one interrupt and connected to GIC
>> SPI[32].
>>
>> This patchset adds irq domain and device tree support for these
>> interrupts.
>> Since there are users of fixed linux irq numbers of the external wakeup
>> interrupts, the legacy mapping is used for the irq domain.
>>
>> This patchset is based on
>> http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> [for-next]
>>
>> with all irq_domain (v5) patches merged from
>> http://git.secretlab.ca/git/linux-2.6.git [irqdomain/next]
>>
>> This patchset should be applied after applying the following patch.
>> [PATCH] ARM: Exynos: Add irq domain and device tree support for interrupt
>> combiner
>
>
> Looks ok to me this series, but I lost above patch in my mail box.
> Thomas, could you please send updated it so that I can apply this series?

The device tree support patches for wakeup interrupts and interrupt
combiner do not apply cleanly to the for-next branch due to the
Exynos5 additions.  So I will rebase, test and post an updated version
of these patches.

Thanks,
Thomas.
