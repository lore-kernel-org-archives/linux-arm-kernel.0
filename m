From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 1 Jul 2015 10:30:26 +0800
Subject: [PATCH v2 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <559306E2.7000901@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>	<1434666968-1543-2-git-send-email-al.stone@linaro.org>
 <CAJZ5v0hO_nmccyGR58CO3rEy55E3PNJXWSmGxtimVsZHfPzQnw@mail.gmail.com>
 <559306E2.7000901@linaro.org>
Message-ID: <559350C2.90507@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/7/1 5:15, Al Stone wrote:
> On 06/30/2015 02:12 PM, Rafael J. Wysocki wrote:
>> Hi Al,
>>
>> On Fri, Jun 19, 2015 at 12:36 AM, Al Stone <al.stone@linaro.org> wrote:
>>> Add the ACPI_SPEC_VERSION() macro to build a proper version number from
>>> a major and minor revision number.  Add also the ACPI_FADT_SPEC_VERSION
>>> that constructs a proper version number from the entries in the current
>>> FADT.
>>>
>>> These macros are added in order to simplify retrieving and comparing ACPI
>>> specification version numbers, since this is becoming a more frequent need.
>>> In particular, there are some architectures that require at least a certain
>>> version of the spec, and there are differences in some structure sizes that
>>> have changed with recent versions but can only be tracked by spec version
>>> number.
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> ---
>>>  include/linux/acpi.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index a4acb55..33ed313 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -48,6 +48,11 @@
>>>  #include <acpi/acpi_io.h>
>>>  #include <asm/acpi.h>
>>>
>>> +#define ACPI_SPEC_VERSION(major, minor)        ((major<<8)|minor)
>> One nit here.
>>
>> acpi_gbl_FADT.header.revision is of type u8 originally, so shifting it
>> by 8 bit positions only works due to some implicit type casting I
>> suppose.
> Bah.  That was being sloppy on my part.  Sorry about that.  Will fix.
>
>> Moreover, it is not entirely clear why the macro is specific to the
>> computation of the ACPI spec version.
> As far as I know, that's the only way to extract the spec version from
> tables; I don't recall there being any other table with that info.  Since
> I will likely use this again, it seemed to make sense at the time.

That's true from ACPI 5.1, as we discussed in ACPI spec working group,
FADT Major Version and FADT Minor Version are recognized as ACPI Major/Minor
version. yes, the spec itself didn't state that explicitly, maybe a ECR
to make it explicit will be good, I can prepare one if that makes sense.

Thanks
Hanjun
