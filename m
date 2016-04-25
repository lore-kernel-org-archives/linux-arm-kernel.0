From: al.stone@linaro.org (Al Stone)
Date: Mon, 25 Apr 2016 12:49:38 -0600
Subject: [PATCH v4] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <20160419111545.GB9571@red-moon>
References: <1461007942-20969-1-git-send-email-al.stone@linaro.org>
 <20160419111545.GB9571@red-moon>
Message-ID: <571E66C2.3000007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2016 05:15 AM, Lorenzo Pieralisi wrote:
> On Mon, Apr 18, 2016 at 01:32:22PM -0600, Al Stone wrote:
>> The ACPI 6.1 specification was recently released at the end of January
>> 2016, but the arm64 kernel documentation for the use of ACPI was written
>> for the 5.1 version of the spec.  There were significant additions to the
>> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
>> added to make it easier to define processors and low power idle states,
>> as well as the 6.1 addition allowing regular interrupts (not just from
>> GPIO) be used to signal ACPI general purpose events.
>>
>> This patch reflects going back through and examining the specs in detail
>> and updating content appropriately.  Whilst there, a few odds and ends of
>> typos were caught as well.  This brings the documentation up to date with
>> ACPI 6.1 for arm64.
>>
[snip...]

>> @@ -185,9 +185,22 @@ tables (all section numbers refer to the ACPI 5.1 specfication):
>>      -- If PCI is supported, the MCFG (Memory mapped ConFiGuration
>>         Table), section 5.2.6, specifically Table 5-31.
>>  
>> +    -- If booting without a console=<device> kernel parameter is
>> +       supported, the SPCR (Serial Port Console Redirection table),
>> +       section 5.2.6, specifically Table 5-31.
>> +
>> +    -- If virtualization is supported, the IORT (Input Output Remapping
>> +       Table, section 5.2.6, specifically Table 5-31.
> 
> Why only "If virtualization is supported" ? Missing closing bracket.

Hrm.  I guess that is an unnecessary qualification.

> I still question sections of this document that IMHO do not belong
> in the kernel documentation (but in the ACPI specs - eg _PRx methods
> usage), anyway the information seems accurate so, pending changes above:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Thanks, Lorenzo.  The suggested changes all seem fine; I'll include them
in a v5.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
