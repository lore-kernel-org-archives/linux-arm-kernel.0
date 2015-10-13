From: pat-lkml@erley.org (Pat Erley)
Date: Mon, 12 Oct 2015 21:06:41 -0700
Subject: [Linaro-acpi] [PATCH v5 0/5] Provide better MADT subtable sanity
 checks
In-Reply-To: <561C1D87.8010106@linaro.org>
References: <1443570346-15378-1-git-send-email-al.stone@linaro.org>
 <560BA4C9.7090607@huawei.com> <560C0968.6020904@redhat.com>
 <2808057.teMg2oCLf6@vostro.rjw.lan> <5612AF64.4060900@redhat.com>
 <561B2442.9050600@erley.org> <561B2DAD.5070601@linaro.org>
 <561B2FCA.1010504@erley.org> <561C1D87.8010106@linaro.org>
Message-ID: <561C8351.3030304@erley.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 01:52 PM, Al Stone wrote:
> On 10/11/2015 09:58 PM, Pat Erley wrote:
>> On 10/11/2015 08:49 PM, Hanjun Guo wrote:
>>> On 10/12/2015 11:08 AM, Pat Erley wrote:
>>>> On 10/05/2015 10:12 AM, Al Stone wrote:
>>>>> On 10/05/2015 07:39 AM, Rafael J. Wysocki wrote:
>>>>>> On Wednesday, September 30, 2015 10:10:16 AM Al Stone wrote:
>>>>>>> On 09/30/2015 03:00 AM, Hanjun Guo wrote:
>>>>>>>> On 2015/9/30 7:45, Al Stone wrote:
>>>>>>>>> NB: this patch set is for use against the linux-pm bleeding edge
>>>>>>>>> branch.
>>>>>>>>>
>>>>>>>
>>>>>>> [snip...]
>>>>>>>
>>>>>>>>
>>>>>>>> For this patch set,
>>>>>>>>
>>>>>>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> Hanjun
>>>>>>>
>>>>>>> Thanks, Hanjun!
>>>>>>
>>>>>> Series applied, thanks!
>>>>>>
>>>>>> Rafael
>>>>>>
>>>>>
>>>>> Thanks, Rafael!
>>>>>
>>>>
>>>> Just decided to test out linux-next (to see the new nouveau cleanups).
>>>> This change set prevents my Lenovo W510 from booting properly.
>>>>
>>>> Reverting: 7494b0 "ACPI: add in a bad_madt_entry() function to
>>>> eventually replace the macro"
>>>>
>>>> Gets the system booting again.  I'm attaching my dmesg from the failed
>>>> boot, who wants the acpidump?
>>>
>>> [    0.000000] ACPI: undefined version for either FADT 4.0 or MADT 1
>>> [    0.000000] ACPI: Error parsing LAPIC address override entry
>>> [    0.000000] ACPI: Invalid BIOS MADT, disabling ACPI
>>>
>>> Seems the MADT revision is not right, could you dump the ACPI MADT
>>> (APIC) table and send it out? I will take a look :)
>>>
>>> Thanks
>>> Hanjun
>>
>> Here ya go, enjoy.  Feel free to CC me on any patches that might fix it.
>
> Pat,
>
> Would you mind sending a copy of the FADT, also, please?  The first of the
> ACPI messages is a check of version correspondence between the FADT and MADT,
> while the second message is from looking at just an MADT subtable.  Thanks
> for sending the MADT out -- that helps me quite a lot in thinking this through.
>
> BTW, whoever is providing the BIOS (Lenovo, I assume) may want to have a look
> at these, also:
>
> [    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in
> FADT/Pm1aControlBlock: 16/32 (20150818/tbfadt-623)
> [    0.000000] ACPI BIOS Warning (bug): Invalid length for
> FADT/Pm1aControlBlock: 32, using default 16 (20150818/tbfadt-704)
>
> Not inherently dangerous, but definitely sloppy and mind-numbingly easy to
> avoid, IIRC.
>

Here ya go.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: facp.dsl
Type: text/x-dsl
Size: 9173 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/59eac2f5/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: facp.dat
Type: application/x-ns-proxy-autoconfig
Size: 244 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/59eac2f5/attachment-0001.bin>
