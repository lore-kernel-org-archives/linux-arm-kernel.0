From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 13 Feb 2015 15:50:32 +0800
Subject: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <003301d04727$1390fcb0$3ab2f610$@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <a314cdbbefb349acbb8f47d6e806989f@NASANEXM01D.na.qualcomm.com>
 <003301d04727$1390fcb0$3ab2f610$@codeaurora.org>
Message-ID: <54DDACC8.1010509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On 2015?02?13? 08:50, Jonathan (Zhixiong) Zhang wrote:
> On 02/02/2015 05:45 AM, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Two more documentation files are also being added:
>> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant
> Likely,
>>      which is also summarized in arm-acpi.txt, and
>>
>> (2) A section by section review of the ACPI spec (acpi_object_usage.txt)
>>      to note recommendations and prohibitions on the use of the numerous
>>      ACPI tables and objects.  This sets out the current expectations of
>>      the firmware by Linux very explicitly (or as explicitly as I can, for
>>      now).
>>
> [snip....]
>> +ERST	Section 18.5 (signature == "ERST")
>> +	== Error Record Serialization Table ==
>> +	Must be supplied if RAS support is provided by the platform.  It
>> +	is recommended this table be supplied.
>
> The above text related to ERST table could lead to misunderstanding.
> Following is what the ACPI spec (section 18.5) says:
> "The error record serialization feature is used to save and retrieve
> hardware error information to and from a persistent store. OSPM interacts
> with the platform through a platform interface. On UEFI-based platforms, the
> UEFI runtime variable services can be used to carry out error record
> persistence operations. On non-UEFI based platforms, the ACPI solution
> described below is used."

Thanks for the reminding, it is well documented in the spec as you
mentioned here.

>
> When RAS support is provided by the platform, ERST table may not be supplied
> when it is UEFI-based and when UEFI run time service provides the ability to
> save and retrieve hardware error information to and from a persistent store
> (UEFI spec section 7.2.3). Therefore, following text might be more accurate:
> " On a platform supports RAS, this table must be supplied if it is not
> UEFI-based; if it is UEFI-based, this table may be supplied, consult your
> firmware vendor if you are not sure.

We can scan all the ACPI tables to see if we have one, so we just meed
to scan all the table then we will know if ERST table is available.

> When this table is not present, UEFI
> run time service will be utilized to save and retrieve hardware error
> information to and from a persistent store."

Other than that, the comments pretty fine to me :)

Thanks
Hanjun
