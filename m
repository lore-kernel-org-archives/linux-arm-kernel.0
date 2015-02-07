From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 07 Feb 2015 11:36:42 +0800
Subject: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
In-Reply-To: <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>	<1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>	<20150202134033.GR4278@bivouac.eciton.net>	<20150202135051.GA3825@xora-haswell.xora.org.uk>	<20150202163253.GG21175@leverpostej>
 <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
Message-ID: <54D5884A.6050009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?06? 18:34, G Gregory wrote:
[...]
>>>>>   --------------------------------------------------------------------------------
>>>>>   linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
>>>>>   --------------------------------------------------------------------------------
>>>>> +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB provided by
>>>>> +                        |      | firmware.
>>>>> +--------------------------------------------------------------------------------
>>>>
>>>> Apologies for the late bikeshedding, but the discussion on this topic
>>>> previsously was lively enough that I thought I'd let it die down a bit
>>>> before seeing if I had anything to add.
>>>>
>>>> That, and I just realised something:
>>>> One alternative to this added DT entry is that we could treat the
>>>> absence of a registered UEFI configuration table as the indication
>>>> that no HW description was provided from firmware, since the stub does
>>>> not call InstallConfigurationTable() on the DT it generates. This does
>>>> move the ability to detect to after efi_init(), but this should be
>>>> fine for ACPI-purposes.
>>>>
>>> That would not work as expected in the kexec/Xen use case though as they
>>> may genuinely boot with DT from an ACPI host without UEFI.
>>
>> I'm a little concerned by this case. How do we intend to pass stuff from
>> Xen to the kernel in this case? When we initially discussed the stub
>> prior to merging, we weren't quite sure if ACPI without UEFI was
>> entirely safe.
>>
>> The linux,uefi-stub-kern-ver property was originally intended as a
>> sanity-check feature to ensure nothing (including Xen) masqueraded as
>> the stub, but for some reason the actual sanity check was never
>> implemented.
>>
>>>> If that is deemed undesirable, I would still prefer Catalin's
>>>> suggested name ("linux,bare-dtb"), which describes the state rather
>>>> than the route we took to get there.
>>>>
>>> I agree.
>>
>> I guess this would be ok, though it would be nice to know which agent
>> generated the DTB.
>>
>
> The most obvious scheme then is
>
> linux,bare-dtb = "uefi-stub";
>
> otherwise we generate a new binding for every component in the boot path.

Leif, Mark, any comments on this?

Thanks
Hanjun
