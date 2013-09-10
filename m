From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 10 Sep 2013 13:19:21 +0100
Subject: [PATCH v2 00/03] ARM: shmobile: r8a7790 APMU SMP support
In-Reply-To: <20130904083934.GG17329@verge.net.au>
References: <20130828232148.7321.45739.sendpatchset@w520>
 <20130829001834.GD10207@verge.net.au>
 <CANqRtoTq=w-dsK-fkfWTO+B+VoOMRkuFjCpY=+5qjBZGxDxd+Q@mail.gmail.com>
 <20130829043424.GA20593@verge.net.au> <20130904083934.GG17329@verge.net.au>
Message-ID: <522F0E49.9070307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 09:39, Simon Horman wrote:
> On Thu, Aug 29, 2013 at 01:34:28PM +0900, Simon Horman wrote:
>> On Thu, Aug 29, 2013 at 01:11:37PM +0900, Magnus Damm wrote:
>>> On Thu, Aug 29, 2013 at 9:18 AM, Simon Horman <horms@verge.net.au> wrote:
>>>> On Thu, Aug 29, 2013 at 08:21:48AM +0900, Magnus Damm wrote:
>>>>> ARM: shmobile: r8a7790 APMU SMP support
>>>>>
>>>>> [PATCH v2 01/03] ARM: shmobile: Shared APMU SMP support code without DT
>>>>> [PATCH v2 02/03] ARM: shmobile: Add r8a7790 SMP support using APMU code
>>>>> [PATCH v2 03/03] ARM: shmobile: Add r8a7790 CA15 CPU cores
>>>>>
>>>>> This series adds SMP support to r8a7790 using the included APMU code.
>>>>> The previous version of r8a7790 support depended on the APMU code in
>>>>> "[PATCH] ARM: shmobile: Shared APMU SMP support code", but in this
>>>>> version the APMU code has been reworked to not use DT. In the future
>>>>> r8a73a4 and other SoCs may make use of the APMU as well, but the
>>>>> r8a73a4 code first needs to be adjusted to work with the CCI driver.
>>>>>
>>>>> With these patches applied r8a7790 CA15 support for SMP boot
>>>>> and CPU Hotplug is known to be working.
>>>>>
>>>>> Thanks to Sudeep for his feedback.
>>>>>
>>>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>>>
>>>> Hi Magnus,
>>>>
>>>> can I clarify that these patches are targeted at mainline?
>>>
>>> Hi Simon, yes, that's correct. It's possible to back port too if needed.
>>
>> Thanks for the clarification.
>>
>>> Actual merge is not rushing though, so please don't interpret this as
>>> any last minute v3.12 merge attempt.
>>
>> No problem, I didn't interpret it that way.
> 
> I have queued these up for v3.13 and they are present
> in the freshly baked renesas-devel-20130904 tag.
> 
As I already mentioned I asked not to add any custom bindings to support
multiple cluster. But this version removed APMU node from DT completely
which is not correct.

Also you removed multi cluster support to avoid CCI and MCPM reuse. I
think you may have to rework these completely when adding multi-cluster
support. I strongly recommend to reuse the CCI and MPCM code from first
instead of reworking again, but I leave it SH platform maintainer to
decide.

Regards,
Sudeep
