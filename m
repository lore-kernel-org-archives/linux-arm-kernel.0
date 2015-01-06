From: jcm@redhat.com (Jon Masters)
Date: Tue, 06 Jan 2015 11:37:08 -0500
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150106141630.GG8829@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <54ABC2CB.6@linaro.org> <20150106112929.GB8829@e104818-lin.cambridge.arm.com>
 <2647669.mQf6pODdjV@wuerfel>
 <20150106141630.GG8829@e104818-lin.cambridge.arm.com>
Message-ID: <54AC0F34.6040500@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 09:16 AM, Catalin Marinas wrote:
> On Tue, Jan 06, 2015 at 02:05:12PM +0000, Arnd Bergmann wrote:
>> On Tuesday 06 January 2015 11:29:29 Catalin Marinas wrote:
>>>>>> We will work on this both on ASWG and linux ACPI driver side, as Dong
>>>>>> and Charles pointed out, _OSI things can be solved in ACPI spec, when
>>>>>> that is done, we can modify the kernel driver to fix the problems above.
>>>>>
>>>>> Which driver?
>>>>
>>>> the ACPICA core driver as you suggested, sorry for the confusion.
>>>>
>>>>> What about ACPI_OS_NAME? Would you suggest it is fine to report
>>>>> "Microsoft Windows NT" on an ARM system? That _OS_ not _OSI.
>>>>
>>>> No, not at all. I prefer "Linux"
>>>> In include/acpi/acconfig.h, when ACPI_OS_NAME defined, it says:
>>>> "OS name, used for the _OS object.  The _OS object is essentially
>>>> obsolete,..."
>>>> for some legacy reasons, we needed  "Microsoft Windows NT", but ACPI
>>>> for ARM64 on linux is totally new, I think we can change it to
>>>> "Linux" when CONFIG_ARM64 as you suggested.
>>>
>>> We could ignore this change for now if we don't expect the _OS object to
>>> be used at all. But do we have any other way to check the AML code for
>>> this? Would FWTS catch such obsolete cases?
>>
>> How about just leaving it out? It's clearly not used for anything
>> good, so I don't see the point in passing either Linux or "Microsoft
>> Windows NT" here.
> 
> Do you mean defining it to NULL (so it ends up as NULL in
> acpi_gbl_pre_defined_names) or removing "_OS_" entirely from that array?
> I really can't tell what the implications are.

Setting it to NULL is almost certainly (99%+ likely IMO) going to result
in some firmware crashing nastily somewhere.

I think I've mentioned before that we're using the ACPI patches in an
early access program for partners that we announced last year. I've
pinged the team internally and asked that we swiftly change to use
whatever name is agreed in this thread so that we can get a lot of other
folks to begin testing with a correctly reported OS name.

Jon.
