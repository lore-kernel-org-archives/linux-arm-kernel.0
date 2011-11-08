From: dirk.behme@googlemail.com (Dirk Behme)
Date: Tue, 08 Nov 2011 18:20:12 +0100
Subject: [PATCH] distclean: Remove generated .dtb files
In-Reply-To: <4EB7E24D.8080804@gmail.com>
References: <1320473955-4500-1-git-send-email-dirk.behme@de.bosch.com>
 <4EB7E24D.8080804@gmail.com>
Message-ID: <4EB964CC.5050004@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.11.2011 14:51, Rob Herring wrote:
> On 11/05/2011 01:19 AM, Dirk Behme wrote:
>> The patch 'arm/dt: Add dtb make rule' adds support to
>> create a .dtb file. But this is never removed afterwards.
>> Remove the generated .dtb file if 'distclean' is called.
>>
>> Signed-off-by: Dirk Behme<dirk.behme@de.bosch.com>
>> CC: Rob Herring<rob.herring@calxeda.com>
>> CC: Shawn Guo<shawn.guo@freescale.com>
>> CC: Jason Liu<jason.hui@linaro.org>
>> CC: Grant Likely<grant.likely@secretlab.ca>
>> ---
>
> Acked-by: Rob Herring<rob.herring@calxeda.com>
...
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Submitted to Russell King's Patch Tracking System:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7152/1

Thanks

Dirk

>>   arch/arm/boot/Makefile |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
>> index 1cd9b0a..08f0d35 100644
>> --- a/arch/arm/boot/Makefile
>> +++ b/arch/arm/boot/Makefile
>> @@ -71,6 +71,8 @@ $(obj)/%.dtb: $(src)/dts/%.dts
>>
>>   $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
>>
>> +clean-files := *.dtb
>> +
>>   quiet_cmd_uimage = UIMAGE  $@
>>         cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
>>   		   -C none -a $(LOADADDR) -e $(STARTADDR) \
>
>
