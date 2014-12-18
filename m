From: jonathan@jonmasters.org (Jon Masters)
Date: Thu, 18 Dec 2014 09:36:15 -0500
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <54926052.5000105@jonmasters.org>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216154842.GI19412@leverpostej> <5490D042.3060901@linaro.org>
 <54926052.5000105@jonmasters.org>
Message-ID: <5492E65F.1010301@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/14, 12:04 AM, Jon Masters wrote:
> On 12/16/14, 7:37 PM, Al Stone wrote:
>> On 12/16/2014 08:48 AM, Mark Rutland wrote:
>
>>> I am rather concerned about the relationship between items described
>>> with _DSD and ACPI's existing device model. Describing the relationship
>>> between devices and their input clocks, regulators, and so on defeats
>>> much of the benefit ACPI is marketed as providing w.r.t. abstraction of
>>> the underlying platform (and as Arnd mentioned above, that's not the
>>> kind of platform we want to support with ACPI).
>>
>> My belief is that all those things should be set up into a known good
>> state by UEFI on initial boot.
>
> Correct. There should never be a situation in which any clocks are
> explicitly exposed in the DSDT. Clock state should be set as a side
> effect of calling ACPI methods to transition device state. _DSD is
> intended to implement simple additions to the core spec, such as
> metadata describing the MAC address, interface type, and PHY on a
> network device. But it should never be used to expose clock nets.
>
> I've spoken with nearly everyone building a 64-bit ARM server using ACPI
> and in nearly every case also reviewed their tables. Nobody is going to
> be so foolish on day one. The trick to some of the ongoing
> discussion/planning is to ensure that guidance prevents mistakes later.

Btw a little clarification. RH of course has commercial relations with 
many of those building first/second/third generation 64-bit ARM server 
designs. In that capacity we have reviewed nearly every SoC design as 
well as the firmware platform (including ACPI tables). We have a vested 
interest in ensuring that nobody builds anything that is crazy, and 
we're not the only OS vendor that is working to ensure such sanity.

Jon.
