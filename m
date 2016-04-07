From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Apr 2016 15:18:32 +0100
Subject: [PATCH] arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip
In-Reply-To: <5704D13E.6060701@arm.com>
References: <1459245786-11905-1-git-send-email-suzuki.poulose@arm.com>
 <5704D13E.6060701@arm.com>
Message-ID: <57066C38.6000902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/16 10:05, Andre Przywara wrote:
> Hi,
>
> On 29/03/16 11:03, Suzuki K Poulose wrote:
>> Commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option"),
>> added support for ARCH_SUNXI on arm64, but failed to select
>> GENERIC_IRQ_CHIP, which is required for drivers/irqchip/irq-sunxi-nmi.c
>> and causes build failures like :
>
> Thanks for the catch! GENERIC_IRQ_CHIP somehow gets selected by
> defconfig, so I didn't see the issue.
>
> Currently we don't need the irq-sunxi-nmi driver, but we may in the
> future and it depends on CONFIG_ARCH_SUNXI only, so I guess this patch
> is the easiest solution (rather than creating a separate config symbol
> for it, which may be an option for later).

...

>> Fixes: commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option")
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Acked-by: Andre Przywara <andre.przywara@arm.com>


Olof, Arnd,

Please could you pick this for rc3 ?

Thanks
Suzuki
