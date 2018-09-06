From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 6 Sep 2018 14:00:35 -0700
Subject: [RESEND PATCHv2 1/4] ARM: dts: add support for building DT
 overlays
In-Reply-To: <CAL_JsqLKNnYD_hrpiV+34Mwf6xLfQQWZVJE7nuPYDL3ExDPemw@mail.gmail.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-2-git-send-email-t-kristo@ti.com>
 <71d48595-f40f-acce-2660-ce1630ffc398@gmail.com>
 <CAL_JsqLKNnYD_hrpiV+34Mwf6xLfQQWZVJE7nuPYDL3ExDPemw@mail.gmail.com>
Message-ID: <cdcf2a18-d407-e466-2d23-1a00a74925cf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/18 14:13, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 3:36 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> +cc: devicetree-compiler at vger.kernel.org
>>
>>      For context on the device-tree compiler list, this patch is for
>>      the Linux kernel.
>>
>> On 09/04/18 01:05, Tero Kristo wrote:
>>> Add simple support for building DT overlays. This just compiles any
>>> given .dtso file under the base arch/arm/boot/dts directory into
>>> a .dtbo.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>  arch/arm/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>>> index d1516f8..ab555a0 100644
>>> --- a/arch/arm/Makefile
>>> +++ b/arch/arm/Makefile
>>> @@ -339,7 +339,7 @@ $(BOOT_TARGETS): vmlinux
>>>  $(INSTALL_TARGETS):
>>>       $(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
>>>
>>> -%.dtb: | scripts
>>> +%.dtb %.dtbo: | scripts
> 
> This will need to change with my rework of the DT build rules[1].
> 
>>>       $(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
>>>
>>>  PHONY += dtbs dtbs_install
>>>
>>
>> The idea of adding knowledge of .dtso and .dtbo files to the dtc
>> compiler, but that idea and the related patches have fallen by
>> the wayside.
>>
>> Current overlay sources and blobs are properly handled by dtc when
>> they are .dts and .dtb files.
>>
>> If the dtc compiler is updated with knowledge of .dtso and .dtbo
>> then these changes would be needed.  At the moment the distinction
>> of a .dtso and .dtbo is a naming convention that provides a clue
>> about the intended use of the file.  But dtc does not know these
>> file name extensions, requiring a specific flag to tell dtc to
>> treat them as .dts or .dtb files.  I think the negative outweighs
>> the positive for this patch.
> 
> I don't follow what you are proposing. We should decide on a convention though.
> 
> We shouldn't need .dtso because that is identified with the /plugin/
> tag. Distinguishing overlay dtbs with .dtbo seems like a good idea
> though.

I noted technical reasons that using .dtbo has both good and bad aspects.
I too at times just fall back to a "sounds good" or "sounds bad" type
response (and will continue to do so in the future), but in this case
please provide a somewhat stronger reasoning for using .dtbo since I
stated that I feel the in technical balance the negatives outweigh the
positives.  If dtc adds knowledge of .dtbo my opinion of the balance
will immediately reverse.

> 
> Rob
> 
> [1] https://lkml.org/lkml/2018/8/21/770
> 
