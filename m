From: al.stone@linaro.org (Al Stone)
Date: Wed, 27 Apr 2016 09:48:23 -0600
Subject: [Linaro-acpi] Additional ACPI requirements
In-Reply-To: <20160427112513.GC12598@leverpostej>
References: <5720341F.3040702@redhat.com> <20160427112513.GC12598@leverpostej>
Message-ID: <5720DF47.9060504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 05:25 AM, Mark Rutland wrote:
> On Tue, Apr 26, 2016 at 11:38:07PM -0400, Jon Masters wrote:
>> Hi Folks,
>>
>> There are a few requirements that I would like to ensure are documented
>> in various revised documentation. I'm curious to know whether you'd like
>> the current in-kernel documentation to include things at the level of
>> "GICv3 use requires that every processor have a Processor Device in the
>> DSDT". Is that too much detail for the kernel documentation?
> 
> If this is about catching oversights and mistakes (as seems to be the
> case for the example), having {boot,run}time checks in the kernel is
> much more likely to have an impact, especially if there is a helpful
> diagnostic.
> 
> Otherewise, this kind of requirement, if anything, belongs in the ACPI
> spec. If it's in the ACPI spec, having it in the kernel is redundant. If
> it's not in the ACPI spec, it will be an uphill struggle to convince
> people to implement Linux-flavoured ACPI rather than generic, standard
> ACPI.
> 
> Thanks,
> Mark.

I would agree with Mark that this is more appropriate to the ACPI spec
where it can be fairly unambiguously described -- for example, something
along the lines of "for every processor ID used in an MADT subtable,
there must be a corresponding ACPI Device object with _HID ACPI0007...".

That being said, why should this be required?  MADT subtables may have
the info needed.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
