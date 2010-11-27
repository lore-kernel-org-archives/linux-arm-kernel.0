From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Sat, 27 Nov 2010 14:01:20 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<AANLkTikkVqWgpYEg505DwQ+pSegQv1g-Q8cDEpE-JCrV@mail.gmail.com>
	<alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
Message-ID: <AANLkTinbAVFE+HZrx+9KUwx8=MKFHPqrhpOpAWAEQFv-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 27 listopada 2010 13:16 u?ytkownik Hans Ulli Kroll
<ulli.kroll@googlemail.com> napisa?:
> On Fri, 26 Nov 2010, Micha? Miros?aw wrote:
>> 2010/11/20 Hans Ulli Kroll <ulli.kroll@googlemail.com>:
>> > Add support for PCI Bus on Gemini Devices SL3516
>> >
>> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>> > ---
>> [...]
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index a19a526..5d4b398 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -307,6 +307,7 @@ config ARCH_GEMINI
>> > ? ? ? ?select CPU_FA526
>> > ? ? ? ?select ARCH_REQUIRE_GPIOLIB
>> > ? ? ? ?select ARCH_USES_GETTIMEOFFSET
>> > + ? ? ? select PCI
>> > ? ? ? ?help
>> > ? ? ? ? ?Support for the Cortina Systems Gemini family SoCs
>> >
>> [...]
>> I think it's better to add ARCH_GEMINI to CONFIG_PCI dependencies.
>> AFAIK IB-4220B NAS does not use PCI and doesn't need all that code.
>> Board support entries could select PCI if the board is useless without
>> it.
> I know this, I have some.
>
> There are many boards with PCI i.e WBD 222.
> Other ARM devices uses the same select inside ARCH_*
> I don't want to pollute drivers/pci/Kconfig.

I meant 'config PCI' entry in arch/arm/Kconfig, see following diff.

Best Regards,
Micha? Miros?aw

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..74ea522 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1164,7 +1164,7 @@ config ISA_DMA_API
 	bool

 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX ||
ARCH_GEMINI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
