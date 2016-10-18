From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 18 Oct 2016 13:38:52 -0700
Subject: [PATCH v2] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <CAOesGMhSic4k3K6oSxf+GMWVFZvvJYE4aZpmzS29qZLwakvLsA@mail.gmail.com>
References: <1476298306-9138-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMijByw1FYt42toNF6pAEykks_agetQybhgMQj8nAc6xdg@mail.gmail.com>
 <207706e2-8fd4-748f-2ee7-3c372b447a7d@broadcom.com>
 <CAOesGMhSic4k3K6oSxf+GMWVFZvvJYE4aZpmzS29qZLwakvLsA@mail.gmail.com>
Message-ID: <89501c0e-b544-8d5c-a158-7a3484af935d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 16-10-17 05:04 PM, Olof Johansson wrote:
> On Mon, Oct 17, 2016 at 4:24 PM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Hi Olof,
>>
>> On 16-10-17 02:58 PM, Olof Johansson wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Oct 12, 2016 at 11:51 AM, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>>
>>>> Enable support for on board SPI EEPROM by turning on
>>>> CONFIG_EEPROM_AT25.  This needs to be on in order to
>>>> boot and test the kernel with a static rootfs image
>>>> that is not rebuilt everytime the kernel is rebuilt.
>>>
>>>
>>> If we did this for every kernel option we'd get a huge kernel.
>>>
>>> In general, we've said that static options for what's needed to boot
>>> to rootfs (i.e. storage and network drivers for nfsroot) are fine to
>>> enable statically.
>>>
>>> I doubt you need the EEPROM driver to boot to rootfs on your system,
>>> so please enable it as a module instead.
OK, I will upstream as module and need config fragments maintained 
locally in order to test defconfig on our test setup.
>>>
>>> Look into using config fragments in case you need to modify the
>>> options for local builds, it should be a convenient way to have a
>>> small delta to apply to fit your internal needs, instead of completely
>>> forking the config file.
>>
>>
>> Do you allow such config fragments to be upstreamed or do we need to
>> maintain these in our tree?
>
> There's no place for them upstream. Maintain locally or in a separate repo.
If that is the case - shall we cleanup arch/arm/configs and delete 
dram_0x00000000.config that was introduced in the 4.4 kernel?
>
>
> -Olof
>

Thanks,
  Scott
