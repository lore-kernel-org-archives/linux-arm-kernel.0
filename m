From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 18:14:58 -0400
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
Message-ID: <540F7BE2.8060403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 01:17 PM, Bjorn Helgaas wrote:
> On Mon, Sep 1, 2014 at 8:57 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Introduce one early parameters "off" for "acpi" to disable ACPI on
>> ARM64.
> 
> It might be worth mentioning the purpose of this in the changelog (and
> maybe the documentation).  I don't think this parameter is supported
> on ia64, and on x86 it seems like it's mostly used as a "fix" by
> Ubuntu users who consider the problem resolved when they find this
> parameter.  That just means we don't get a chance to fix the real
> underlying problem, so I'm not sure it's a real benefit to have the
> parameter.

>> -       acpi=           [HW,ACPI,X86]
>> +       acpi=           [HW,ACPI,X86,ARM]
>>                         Advanced Configuration and Power Interface
>>                         Format: { force | off | strict | noirq | rsdt }
>>                         force -- enable ACPI if default was off
>> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>                                 strictly ACPI specification compliant.
>>                         rsdt -- prefer RSDT over (default) XSDT
>>                         copy_dsdt -- copy DSDT to memory
>> +                       For ARM64, ONLY "acpi=off" is available.

Something along the lines of:

"The purpose of disabling ACPI on 64-bit ARM server platforms is to
allow for an orderly adoption of ACPI on early systems that may also
provide a DeviceTree based boot option initially. The acpi= option
disables both parsing of any tables passed in through the EFI System
Table RSDP and also disables the runtime ACPI interpreter on arm64".

On our internal systems, we've both ACPI and DeviceTree working with a
simple switch (acpi=) to determine the behavior, which is facilitating
an orderly total migration to ACPI that is in currently in flight.

Jon.
