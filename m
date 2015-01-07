From: jcm@redhat.com (Jon Masters)
Date: Tue, 06 Jan 2015 23:55:58 -0500
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54AC5C57.7050504@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
 <54AC0C4B.1000907@redhat.com> <1596791.jNp4rCPpnN@wuerfel>
 <54AC5C57.7050504@redhat.com>
Message-ID: <54ACBC5E.3040905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 05:06 PM, Jon Masters wrote:
> Hi Arnd,
> 
> Happy New Year!
> 
> On 01/06/2015 02:21 PM, Arnd Bergmann wrote:
>> On Tuesday 06 January 2015 11:24:43 Jon Masters wrote:
>>> On 01/06/2015 06:20 AM, Catalin Marinas wrote:
>>>
>>>> Now, what's preventing a vendor firmware from providing only ACPI
>>>> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
>>>> that both DT and ACPI are supported, or at least that dts files are
>>>> merged in the kernel first?
>>>
>>> I know of some (server) firmware that will only provide ACPI in the
>>> medium term, so this is coming.
>>
>> Medium term is fine, as long as they are not expecting their hardware
>> to be supported by Linux before ACPI support is stable enough for
>> general consumption.
> 
> To be clear, I think that's reasonable for upstream. I may love ACPI,
> but vendors can always ship kernels with a config supporting ACPI only
> platforms in the interim period if they have a commercial justification
> and that doesn't have to be supported in terms of the upstream default.
> 
> But, perhaps there's a way to have it both ways, you could consider also
> a CONFIG_EXPERT option that would allow you to build a kernel with ACPI
> only support in the medium term. That way, if someone is running a
> vendor kernel, but wants to track upstream development more closely,
> they can do so on such hardware by enabling the expert config bit.

Clarification: I'm suggesting that in the medium term the dependency
upon CONFIG_EXPERT either goes away or is replaced with requiring ACPI
and DTB in the non "expert" case and requiring "expert" selected to
allow a kernel that will boot with ACPI only. But only a suggestion.

Jon.
