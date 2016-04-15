From: al.stone@linaro.org (Al Stone)
Date: Fri, 15 Apr 2016 10:41:02 -0600
Subject: [PATCH v3] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <20160415143719.GA8798@red-moon>
References: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
 <20160415143719.GA8798@red-moon>
Message-ID: <5711199E.9010508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:37 AM, Lorenzo Pieralisi wrote:
> Hi Al,
> 
> On Mon, Mar 28, 2016 at 06:06:42PM -0600, Al Stone wrote:
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
>> Changes for v3:
>>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>>    -- Whitespace cleanup as pointed out by checkpatch
>>
>> Changes for v2:
>>    -- Clean up white space (Harb Abdulhahmid)
>>    -- Clarification on _CCA usage (Harb Abdulhamid)
>>    -- IORT moved to required from recommended (Hanjun Guo)
>>    -- Clarify IORT description (Hanjun Guo)
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/arm64/acpi_object_usage.txt | 446 ++++++++++++++++++++++--------
>>  Documentation/arm64/arm-acpi.txt          |  28 +-
>>  2 files changed, 357 insertions(+), 117 deletions(-)
> 
> I went through this patch twice and before posting my review comments
> I have some questions to _ASK ;-):
> 
> -  Do we really need acpi_object_usage.txt to list all possible ACPI
>    methods in the ACPI specs ("Use as needed") and update them as the
>    specs evolve ?
>    IMO that's what the ACPI specs are for and that's what AML developers
>    will refer to, I do not see the point in listing all methods in that
>    file (can't it become an ARM addendum to the ACPI specs at least to
>    deprecate methods/tables that are obsolete in ARM's world) ?

The original intent was to provide guidance to those unfamiliar with ACPI,
and in particular provide some details on what usage makes sense on ARM.
In writing it, the objective was that arm-acpi.txt be primarily an overall
view, but that acpi_object_usage.txt answered specific questions about
specific objects, which we got asked about frequently since APCI was very
new on ARM at the time.  That being said, however, it is possible that
acpi_object_usage.txt has outlived its usefulness, as those that need to
have become familiar with ACPI.

It doesn't help in the ACPI specs since the idea was to try to document
recommended Linux-specific usage, which may or may not be OS-agnostic, but
would at least be in the open to encourage common usage.

> -  How do we keep acpi_object_usage.txt in sync with ACPI specs from now
>    onwards ? Is that what we really want/need ?
> 
> -  How do we keep arm-acpi.txt in sync with kernel supported ARM64 ACPI
>    features (if - given that this document is part of the Linux kernel docs -
>    its aim is to describe what bits of ACPI are supported on arm64 (?)) ?

Well, maintenance will be necessary as new spec revisions come out, just like
any other part of the kernel code.  I don't see anything unique about these
documents versus any other; is there something else in the question that I'm
not seeing?

I guess I just assumed that since I wrote these, I'd be responsible for keeping
them up to date.  If you're volunteering to do so, I would not object :-).

> So, agreed with fixing the typos, agreed with arm-acpi.txt (and with
> updating it) which describes how the ARM64 kernel is using ACPI
> methods/tables, but acpi_object_usage.txt and in particular describing
> in there what methods are _useful_ and what are not, honestly I think we
> should ask ourselves what that file is really meant to be.
> 
> Happy to send my review comments as a follow-up since overall the patch
> is OK, I wanted to ask the basic questions above first.
> 
> Thanks,
> Lorenzo
> [snip...]

Does that help clarify?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
