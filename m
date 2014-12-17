From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 17 Dec 2014 22:26:24 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <9355623.14GfrLxEB0@wuerfel>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
Message-ID: <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 11:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 December 2014 19:18:16 Al Stone wrote:
>> 6. How does the kernel handle_DSD usage?
>>    * Problem:
>>      * _DSD defines key-value properties in the DT style. How do we
>>        ensure _DSD bindings are well defined?
>>      * How do we ensure DT and _DSD bindings remain consistent with
>>        each other?
>>    * Solution: public documentation for all bindings, and a process
>>      for defining them
>>    * Status: proposal to require patch authors to point at public
>>      binding documentation; kernel Documentation/devicetree/bindings
>>      remains the default if no other location exists; UEFI forum has
>>      set up a binding repository.
>
> I think we also need to make a decision here on whether we want to use
> PRP0001 devices on ARM64 servers, and to what degree. I would prefer
> if we could either make them required for any devices that already have
> a DT binding and that are not part of the official ACPI spec, or we
> decide to not use them at all and make any PRP0001 usage a testcase
> failure.

Hmmm... having rules specifically for Aarch64 doesn't make a whole lot
of sense. Whatever rules we choose for PRP0001 should apply equally
regardless of architecture.

>> 7. Why is ACPI required?
>>    * Problem:
>>      * arm64 maintainers still haven't been convinced that ACPI is
>>        necessary.
>>      * Why do hardware and OS vendors say ACPI is required?
>>    * Status: Al & Grant collecting statements from OEMs to be posted
>>      publicly early in the new year; firmware summit for broader
>>      discussion planned.
>
> I was particularly hoping to see better progress on this item. It
> really shouldn't be that hard to explain why someone wants this feature.

I've written something up in as a reply on the firmware summit thread.
I'm going to rework it to be a standalone document and post it
publicly. I hope that should resolve this issue.

g.
