From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 20 Oct 2014 19:31:48 +0530
Subject: [PATCH v5 0/6] Add initial support for pinctrl on Exynos7
In-Reply-To: <54397DAA.4020607@gmail.com>
References: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
 <54397DAA.4020607@gmail.com>
Message-ID: <CAM4voa=k=bq67mTMtaQiFp-m2byY=U-gMyWoeckvhW-HTaRhag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Oct 12, 2014 at 12:27 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Abhilash, Linus,
>
> On 09.10.2014 15:54, Abhilash Kesavan wrote:
>> Changes since v4:
>>       - Rebased over Tomasz Figa's pinctrl clean-up patches[1]
>>
>> Changes since v3:
>>       - Changed variable name from exynos_wkup_irq_chip to irq_chip
>>       - Added acked-by tag from Tomasz Figa
>>
>> Changes since v2:
>>       - Added a .irq_chip field to the samsung_pin_bank struct
>>       - Consolidated the wakeup and gpio irqd_ops
>>
>> Changes since v1:
>>       - Marked the newly created irq_chip instances as __initdata
>>       - Used kmemdup to keep a copy of the irq_chip
>>       - Change the pinctrl name from sd0_rdqs to sd0_ds as per UM
>>       - Moved the pinctrl enablement for exynos7 into a separate patch
>>       - Added tested-by and reviewed-by tags from Thomas Abraham
>>
>> This series has been tested on linux-next (20141008)
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/ with
>> the following dependencies and [1].
>>
>> a) Samsung Serial symbol clean-up for exynos7 serial driver enablement (v2)
>>    http://www.spinics.net/lists/arm-kernel/msg366947.html
>>    http://www.spinics.net/lists/arm-kernel/msg366948.html
>> b) "dts, kbuild: Implement support for dtb vendor subdirs" patchset - rebased
>>    http://comments.gmane.org/gmane.linux.kbuild.devel/12131
>> c) "arch: arm64: enable support for Samsung Exynos7 SoC" patchset (v5) - rebased
>>    http://www.spinics.net/lists/arm-kernel/msg364014.html
>>
>> [1] https://lkml.org/lkml/2014/10/2/476
>>
>> Abhilash Kesavan (3):
>>   pinctrl: exynos: Generalize the eint16_31 demux code
>>   pinctrl: exynos: Consolidate irq domain callbacks
>>   pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts
>>
>> Naveen Krishna Ch (3):
>>   pinctrl: exynos: Add initial driver data for Exynos7
>>   arm64: dts: Add initial pinctrl support to EXYNOS7
>>   arm64: exynos: Enable pinctrl support for Exynos7
>>
>>  .../bindings/pinctrl/samsung-pinctrl.txt           |    3 +
>>  arch/arm64/Kconfig                                 |    2 +
>>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  560 ++++++++++++++++++++
>>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |   66 +++
>>  drivers/pinctrl/samsung/pinctrl-exynos.c           |  188 +++++--
>>  drivers/pinctrl/samsung/pinctrl-exynos.h           |    3 +
>>  drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
>>  drivers/pinctrl/samsung/pinctrl-samsung.h          |    3 +
>>  8 files changed, 791 insertions(+), 36 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
>>
>
> No further comments from me. Thanks Abhilash for addressing all of them.
>
> Linus, feel free to apply this series with my ACK (which seems to be
> already present in all patches).

Can you please pick this series up.

Thanks,
Abhilash
>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
