From: dianders@chromium.org (Doug Anderson)
Date: Wed, 1 Oct 2014 08:21:49 -0700
Subject: [PATCH v3] clocksource: arch_timer: Allow the device tree to
 specify the physical timer
In-Reply-To: <CAPz6YkWZWgm--6EJxoV1s3zqTNpAF6+CBOrRc5qxdm5=hFzj1w@mail.gmail.com>
References: <1410454801-14231-1-git-send-email-dianders@chromium.org>
 <20140926100025.GC4476@leverpostej>
 <CAPz6YkWZWgm--6EJxoV1s3zqTNpAF6+CBOrRc5qxdm5=hFzj1w@mail.gmail.com>
Message-ID: <CAD=FV=WaNGeaXbYcHHBBYosX_0bpZVGCiqi=iuCXamcN3VEEpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 29, 2014 at 10:30 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
> On Fri, Sep 26, 2014 at 3:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Sep 11, 2014 at 06:00:01PM +0100, Doug Anderson wrote:
>>> +** Optional properties:
>>> +
>>> +- arm,use-physical-timer : Don't ever use the virtual timer, just use the
>>> +  physical one.  Only supported for ARM (not ARM64).
>>
>> I'm still not keen on telling the kernel what to do rather than
>> describing the actual state of affairs and having the kernel decide what
>> to do. Perhaps what we actually need is:
>>
>> - cntvoff-not-fw-configured: Firmware does not configure CNTVOFF, which
>>   may reset to (different) arbitrary values on each CPU.
>>
>> This also doesn't describe that CNTHCTL.PL1PC(T)EN must both be 1. While
>> that is the reset state, it still feels dodbgy to me to rely on that.
>>
>> Mark.
>
> Mark, I'm happy to repost it with that name for Doug.
>
> I think it's fair to describe this state in the binding, and if a
> firmware were to put this property into the device-tree for and
> CNTHCTL.PL1P(T)CEN also have configured to 0, then the kernel can
> merely consider that to be a broken usage of this property.   We
> certainly can't protect against all of the possible invalid states
> caused and probably shouldn't try.  If we implement something like
> Christopher's suggestion for transitioning from secure svc to NS hyp
> mode then the kernel can simply ignore this property at that point.

I've already talked in person to Sonny about this, but just to post on
the list too...  I think Mark Rutland's suggestion is a good one and
I'm more than happy for Sonny to repost that way for me.  Thanks!  :)

-Doug
