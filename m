From: ajaynumb@gmail.com (Ajay kumar)
Date: Fri, 15 Jul 2011 11:57:37 +0530
Subject: [PATCH 0/6] ARM: S5P64X0: Add Framebuffer support
In-Reply-To: <4E1FDA4E.9010800@linaro.org>
References: <1310650036-28836-1-git-send-email-ajaykumar.rs@samsung.com>
	<4E1FDA4E.9010800@linaro.org>
Message-ID: <CAEC9eQMonzbcTOfb+2=UBCDpOrk-Qh+snQjTDLetz=jftb3AeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On Fri, Jul 15, 2011 at 11:42 AM, Tushar Behera
<tushar.behera@linaro.org> wrote:
> On Thursday 14 July 2011 06:57 PM, Ajay Kumar wrote:
>>
>> ? ? ? ?The patches are created against "for-next" branch of Kukjin Kim's
>> tree at:
>>
>> ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>
>> ? ? ? ?Patch [1/6]
>> ? ? ? ?-- add "s5p64x0-fb" type driver_data(s3c_fb_driverdata).
>> ? ? ? ?-- Display controller in S5P64X0 supports 3 windows.
>>
>> ? ? ? ?Patch [2/6]
>> ? ? ? ?-- Resource definitions(_MEM, _IRQ).
>>
>> ? ? ? ?Patch [3/6]
>> ? ? ? ?-- Set s3c_device_fb name as "s5p64x0-fb"
>> ? ? ? ? ? for S5P6440 and S5P6450.
>>
>> ? ? ? ?Patch [4/6]
>> ? ? ? ?-- GPIO settings for LCD in S5P6440 and S5P6450.
>> ? ? ? ?-- Select LCD interface type (RGB/i80)
>>
>> ? ? ? ?Patch [5/6]
>> ? ? ? ?-- Add support for LCD-LTE480 platform device in SMDK6440.
>> ? ? ? ?-- Platform data for FB and a basic window definition.
>> ? ? ? ?-- Enables FB support and platform-lcd support.
>> ? ? ? ?-- Add support for window 0 with 24 BPP.
>>
>> ? ? ? ?Patch [6/6]
>> ? ? ? ?-- Add support for LCD-LTE480 platform device in SMDK6450.
>> ? ? ? ?-- Platform data for FB and a basic window definition.
>> ? ? ? ?-- Enables FB support and platform-lcd support.
>> ? ? ? ?-- Add support for window 0 with 24 BPP.
>>
> Some of the patches have got some coding syntax (DOS LINE ending etc.).
> Consider running scripts/checkpatch.pl on the patches before sending the
> next version.
>
> scripts/cleanpatch can help you in fixing many of the style problems.
>

I have tried running checkpatch.pl on patches 1 to 6,
and I did not encounter any error like DOS_LINE as you have mentioned.
Can you please tell me which patch is showing that error when run with
checkpatch.pl?

>> ?o To Paul Mundt, Jingoo Han
>> ? ?[Patch 1/6] video: s3c-fb: Add S5P64X0 specific s3c_fb_driverdata
>>
>> ?o To Kukjin Kim
>> ? ?[Patch 2/6] ARM: S5P64X0: Add register base and IRQ for Framebuffer
>> ? ?[Patch 3/6] ARM: S5P64X0: Set s3c_device_fb name
>> ? ?[Patch 4/6] ARM: S5P64X0: Add GPIO and SPCON settings for LCD
>> ? ?[Patch 5/6] ARM: S5P6440: Add LCD-LTE480 and enable Framebuffer support
>> ? ?[Patch 6/6] ARM: S5P6450: Add LCD-LTE480 and enable Framebuffer support
>>
>>
>> ?arch/arm/mach-s5p64x0/Kconfig ? ? ? ? ? ? ? ? ?| ? 10 ++++
>> ?arch/arm/mach-s5p64x0/Makefile ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-s5p64x0/cpu.c ? ? ? ? ? ? ? ? ? ?| ? ?3 +
>> ?arch/arm/mach-s5p64x0/include/mach/irqs.h ? ? ?| ? ?4 ++
>> ?arch/arm/mach-s5p64x0/include/mach/map.h ? ? ? | ? ?3 +
>> ?arch/arm/mach-s5p64x0/include/mach/regs-fb.h ? | ? 19 +++++++
>> ?arch/arm/mach-s5p64x0/include/mach/regs-gpio.h | ? ?4 ++
>> ?arch/arm/mach-s5p64x0/mach-smdk6440.c ? ? ? ? ?| ? 63
>> +++++++++++++++++++++++
>> ?arch/arm/mach-s5p64x0/mach-smdk6450.c ? ? ? ? ?| ? 63
>> +++++++++++++++++++++++
>> ?arch/arm/mach-s5p64x0/setup-fb.c ? ? ? ? ? ? ? | ? 48 ++++++++++++++++++
>> ?arch/arm/plat-samsung/include/plat/fb.h ? ? ? ?| ? 14 +++++
>> ?drivers/video/s3c-fb.c ? ? ? ? ? ? ? ? ? ? ? ? | ? 64
>> ++++++++++++++++++++++++
>> ?12 files changed, 296 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-fb.h
>> ?create mode 100644 arch/arm/mach-s5p64x0/setup-fb.c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
>
> --
> Tushar Behera
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
