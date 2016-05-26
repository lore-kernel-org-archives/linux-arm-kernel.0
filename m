From: ahs3@redhat.com (Al Stone)
Date: Thu, 26 May 2016 16:31:24 -0600
Subject: [PATCH v5 0/1] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <44cda485-1c43-f7c3-676b-f9c47785daf6@linaro.org>
References: <20160516234441.GA7425@arm.com>
 <44cda485-1c43-f7c3-676b-f9c47785daf6@linaro.org>
Message-ID: <baa61d52-083f-574a-ed0e-6b57c9517d06@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2016 10:30 AM, Al Stone wrote:
> On 05/16/2016 05:44 PM, Alexey Klimov wrote:
>> On Mon, May 2, 2016 at 09:19 PM, Al Stone wrote:
>>> On 04/25/2016 03:21 PM, Al Stone wrote:
>>>> The ACPI 6.1 specification was recently released at the end of January
>>>> 2016, but the arm64 kernel documentation for the use of ACPI was written
>>>> for the 5.1 version of the spec.  There were significant additions to the
>>>> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
>>>> added to make it easier to define processors and low power idle states,
>>>> as well as the 6.1 addition allowing regular interrupts (not just from
>>>> GPIO) be used to signal ACPI general purpose events.
>>>>
>>>> This patch reflects going back through and examining the specs in detail
>>>> and updating content appropriately.  Whilst there, a few odds and ends of
>>>> typos were caught as well.  This brings the documentation up to date with
>>>> ACPI 6.1 for arm64.
>>>>
>>>> Changes for v5:
>>>>    -- Miscellaneous typos and corrections (Lorenzo Pieralisi)
>>>>    -- Add linux-acpi@ ML to the distribution list (Alexey Klimov)
>>>>    -- Corrections to CPPC information (Alexey Klimov)
>>>>    -- ACK from Lorenzo Pieralisi
>>>>    -- Updated bibliographic info (Al Stone)
>>>>
>>>> Changes for v4:
>>>>    -- Clarify that IORT can sometimes be optional (Jon Masters).
>>>>    -- Remove "Use as needed" descriptions of ACPI objects; they provide
>>>>       no substantive information and doing so simplifies maintenance of
>>>>       this document over time.  These have been replaced with a simpler
>>>>       notice that states that unless otherwise noted, do what the ACPI
>>>>       specification says is needed.
>>>>    -- Corrected the _OSI object usage recommendation; it described kernel
>>>>       behavior that does not exist (Al Stone).
>>>>
>>>> Changes for v3:
>>>>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>>>>    -- Whitespace cleanup as pointed out by checkpatch
>>>>
>>>> Changes for v2:
>>>>    -- Clean up white space (Harb Abdulhahmid)
>>>>    -- Clarification on _CCA usage (Harb Abdulhamid)
>>>>    -- IORT moved to required from recommended (Hanjun Guo)
>>>>    -- Clarify IORT description (Hanjun Guo)
>>>>
>>>>
>>>> Al Stone (1):
>>>>   ARM64: ACPI: Update documentation for latest specification version
>>>>
>>>>  Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++--------------
>>>>  Documentation/arm64/arm-acpi.txt          |  40 ++--
>>>>  2 files changed, 213 insertions(+), 170 deletions(-)
>>>>
>>>
>>> Ping?  If there are no further comments, can this be pulled in through
>>> either the documentation or arm64 tree?
>>>
>>> Thanks.
>>
>> Hi Al,
>> sorry for delay.
>>
>> CPPC and PCC corrections look fine. Thanks.
>>
>>
>> This comment is not to block your patch (maybe some to-do):
>> I greped sources and your patch and I don't see description of _PSD object.
>> This P-state dependancy object is optional but it's presense and correct data
>> are extremely useful for CPPC and can potentially descrease number of performance
>> changing requests.
>>
>> ACPI spec in section about CPPC tells that it may use _PSD (page 503 if I remember
>> correctly) to specify domain belongings of CPUs.
>>
>> You may consider to add description of _PSD object later.
>>
>> Best regards,
>> Alexey.
>>
> 
> Hrm.  Thanks, Alexey.  I'll take a look.  _PSD may be in one of
> the gray areas where we expect people to read the spec and follow
> it properly, but it may make sense to be very explicit about what
> they need to do to use it properly.  Perhaps this would make a good
> FWTS test, too.
> 

Yet another ping...

Just in case it is not clear, Alexey's comment and my reply here are
things that *might* need to be done in the future.  This version of the
patch I believe is sufficient for now, based on the comments received.

Lorenzo has ACKd; Hanjun has reviewed.  Do I need Will and/or Catalin
to ACK?  Any others?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
