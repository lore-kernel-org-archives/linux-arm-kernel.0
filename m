From: lftan@altera.com (Ley Foon Tan)
Date: Wed, 29 Jul 2015 11:03:55 +0800
Subject: [PATCH 2/6] arm: mach-socfpga: enable pci support
In-Reply-To: <CAL_JsqK8HbYMbQf+8vFuDiTe3j9THus+YwLZDdJpQM5faQTY3g@mail.gmail.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
 <1438080345-7233-3-git-send-email-lftan@altera.com>
 <CAL_JsqK8HbYMbQf+8vFuDiTe3j9THus+YwLZDdJpQM5faQTY3g@mail.gmail.com>
Message-ID: <CAFiDJ584tv9od635_+AVObFAuwu7OZHeBDZ2DRdwCzDz40RjHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 9:26 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 5:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> Enable CONFIG_ARCH_SUPPORT_MSI and CONFIG_PCI in SOCFPGA platform.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  arch/arm/mach-socfpga/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
>> index 90efdeb..7ff4576 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -1,6 +1,7 @@
>>  menuconfig ARCH_SOCFPGA
>>         bool "Altera SOCFPGA family" if ARCH_MULTI_V7
>>         select ARCH_SUPPORTS_BIG_ENDIAN
>> +       select ARCH_SUPPORTS_MSI
>
> This doesn't exist in mainline having been removed in 3.12.
Will removed this.
>
>>         select ARM_AMBA
>>         select ARM_GIC
>>         select CACHE_L2X0
>> @@ -9,6 +10,7 @@ menuconfig ARCH_SOCFPGA
>>         select HAVE_ARM_SCU
>>         select HAVE_ARM_TWD if SMP
>>         select MFD_SYSCON
>> +       select PCI
>
> This should not be selected by the platform, but be user selectable
> unless perhaps you require PCI to boot.

Will removed this as well.

Thanks for reviewing.

Regards
Ley Foon
