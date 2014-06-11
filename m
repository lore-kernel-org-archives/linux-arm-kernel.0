From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 11 Jun 2014 12:33:30 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <539754E5.3030408@redhat.com>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
 <53973AA8.9020301@codeaurora.org>
 <CAFEAcA8RttCvbOAw-m-W6C-mh1o4hj6nqGMkDbRsSF6ZoQZ7Kg@mail.gmail.com>
 <539754E5.3030408@redhat.com>
Message-ID: <CACxGe6tPQFbbUcJJmoxkAdVAp9b1AcGB_Xdwh_Mu4m6P1j_zRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 7:56 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 10/06/2014 20:08, Peter Maydell ha scritto:
>
>> On 10 June 2014 18:04, Christopher Covington <cov@codeaurora.org> wrote:
>>>
>>> On 06/10/2014 10:42 AM, Peter Maydell wrote:
>>>>
>>>> I just noticed that this doesn't mandate that the platform
>>>> provides an RTC. As I understand it, the UEFI spec mandates
>>>> that there's an RTC (could somebody more familiar with UEFI
>>>> than me confirm/deny that?) so we should probably put one here.
>>>
>>>
>>> Pardon my ignorance, but what exactly disqualifies Generic Timer
>>> implementations from being used as Real Time Clocks?
>>
>>
>> So my naive view was that an RTC actually had to have
>> support for dealing with real (wall) clock time, ie
>> knowing it's 2014 and not 1970. The generic timers are
>> just timers. Or am I wrong and UEFI doesn't really
>> require that?
>
>
> The real-time clock provides four UEFI runtime services (GetTime, SetTime,
> GetWakeupTime, SetWakeupTime).  The spec says that you can return
> EFI_DEVICE_ERROR from GetTime/SetTime if "the time could not be
> retrieved/set due to a hardware error", but I don't think this is enough to
> make these two optional.  By comparison, GetWakeupTime/SetWakeupTime can
> also return EFI_UNSUPPORTED.

In practical terms, yes the VM needs to provide an RTC interface, but
I don't think it needs to appear in this spec, even if the kernel
accesses it directly. Portable images should use the UEFI service.

g.
