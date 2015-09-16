From: ahs3@redhat.com (Al Stone)
Date: Wed, 16 Sep 2015 13:26:32 -0600
Subject: [PATCH v3 0/5] ACPI: Provide better MADT subtable sanity checks
In-Reply-To: <55F9988D.5080002@redhat.com>
References: <1441832991-28200-1-git-send-email-al.stone@linaro.org>
 <55F889E8.3070706@redhat.com> <1880799.vMhNVMG5Vc@vostro.rjw.lan>
 <55F997C1.20606@linaro.org> <55F9988D.5080002@redhat.com>
Message-ID: <55F9C268.5000604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2015 10:27 AM, Al Stone wrote:
> On 09/16/2015 10:24 AM, Al Stone wrote:
>> On 09/15/2015 08:44 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, September 15, 2015 03:13:12 PM Al Stone wrote:
>>>> On 09/09/2015 03:09 PM, Al Stone wrote:
>>>>> Currently, the BAD_MADT_ENTRY macro is used to do a very simple sanity
>>>>> check on the various subtables that are defined for the MADT.  The check
>>>>> compares the size of the subtable data structure as defined by ACPICA to
>>>>> the length entry in the subtable.  If they are not the same, the assumption
>>>>> is that the subtable is incorrect.
>>>>>
> 
> [snip...]
> 
>>> I'm going to apply this series if people have no problems with it.  I do think
>>> it is slightly overkill, but then as long as it works ...

Indeed it does.  We've found and fixed two MADTs with legitimate errors in them
with these patches (both arm64 tables still in development).

>>> Thanks,
>>> Rafael
>>>
> 
> Would you prefer I send out the updated version with Sudeep's fix to apply
> instead of this version?  Or have you picked that up already?  Easily updated
> and sent out, if it'll make your life simpler....
> 

Bah.  Never mind.  An inadvertent use of the 01day builder by someone else
found another nit; I'll spin out a v4 later today just so everything is very
clear.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
