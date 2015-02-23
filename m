From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Mon, 23 Feb 2015 20:48:39 +0200
Subject: [PATCH 3/4] arm: am33xx: DT quirks for am33xx based beaglebone
 variants
In-Reply-To: <54EB73DC.4090507@hurleysoftware.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-4-git-send-email-pantelis.antoniou@konsulko.com>
 <20150219181656.GF32521@atomide.com>
 <9C7BFC7C-0751-4233-927F-D01AF078704B@antoniou-consulting.com>
 <20150219183600.GG32521@atomide.com>
 <145DEB3E-A20E-4390-84B1-4B30E7C3D841@antoniou-consulting.com>
 <54EB73DC.4090507@hurleysoftware.com>
Message-ID: <8252298C-4249-49F8-91CA-8398ADEB1348@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> On Feb 23, 2015, at 20:39 , Peter Hurley <peter@hurleysoftware.com> wrote:
> 
> Hi Pantelis,
> 
> On 02/19/2015 01:44 PM, Pantelis Antoniou wrote:
>> Hi Tony,
>> 
>>> On Feb 19, 2015, at 20:36 , Tony Lindgren <tony@atomide.com> wrote:
>>> 
>>> * Pantelis Antoniou <panto@antoniou-consulting.com> [150219 10:32]:
>>>>> On Feb 19, 2015, at 20:16 , Tony Lindgren <tony@atomide.com> wrote:
>>>>> 
>>>>> Uhh I don't like the idea of duplicating the i2c-omap.c driver under
>>>>> arch/arm.. And in general we should initialize things later rather
>>>>> than earlier.
>>>>> 
>>>>> What's stopping doing these quirk checks later on time with just
>>>>> a regular device driver, something like drivers/misc/bbone-quirks.c?
>>>>> 
>>>> 
>>>> We have no choice; we are way early in the boot process, right after
>>>> the device tree unflattening step.
>>> 
>>> To me it seems the dt patching part should be done with minimal
>>> code before any driver like features..
>>> 
>> 
>> The way it?s done right now is with minimal code. Reading the EEPROM
>> is required.
>> 
>>>> I?ve toyed with the idea of using early platform devices but the omap-i2c driver
>>>> would need some tender love and care to make it work, and I didn?t want to get
>>>> bogged down with i2c driver details at this point.
>>> 
>>> ..so how about just parse a kernel cmdline for the quirks to apply
>>> based on a version string or similar? That can be easily populated
>>> by u-boot or set manually with setenv.
>>> 
>>> That leaves out the need for tinkering with i2c super early in
>>> the kernel for revision detection.
>>> 
>> 
>> You assume there?s going to be a bootloader?
> 
> So does this patch.
> 

Proof of concept, first iteration? The beaglebone is just the prototype stage.

>> diff --git a/arch/arm/mach-omap2/am33xx-dt-quirks.c b/arch/arm/mach-omap2/am33xx-dt-quirks.c
> [...]
>> + * Note that we rely on the bootloader setting up the muxes
>> + * (which is the case for u-boot).
> 
> Regards,
> Peter Hurley
> 

Regards

? Pantelis
