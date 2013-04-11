From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 11 Apr 2013 22:14:43 +0200
Subject: [PATCH v8 1/7] media: V4L2: add temporary clock helpers
In-Reply-To: <20130411185258.7915.67263@quantum>
References: <CAGsJ_4zCRBvEX9xEDCr27JLK6wYp_2T_wk2hzVjqpKinbL=9pg@mail.gmail.com>
 <Pine.LNX.4.64.1304110921480.23859@axis700.grange>
 <CAGsJ_4xXRHDbpuqT3e5=0vz9_NxxCXfvrci+h567HP9=AhwRiQ@mail.gmail.com>
 <Pine.LNX.4.64.1304111028090.23859@axis700.grange>
 <CAGsJ_4yXE7SYLgPucW9kAEYgKg+z93j8yN3d+gvhqeLAn-sSOw@mail.gmail.com>
 <20130411185258.7915.67263@quantum>
Message-ID: <516719B3.8060502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/11/2013 08:52 PM, Mike Turquette wrote:
[...]
>>> So, you enable CFF, it provides its own clk_* implementation like
>>> clk_get_rate() etc. Now, PXA already has it defined in
>>> arch/arm/mach-pxa/clock.c. Don't think this is going to fly.
>>
>> agree.
>
> Hi,
>
> I came into this thread late and don't have the actual patches in my
> inbox for review.  That said, I don't understand why V4L2 cares about
> the clk framework *implementation*?  The clk.h api is the same for
> platforms using the common struct clk and those still using the legacy
> method of defining their own struct clk.  If drivers are only consumers
> of the clk.h api then the implementation underneath should not matter.

I came to similar conclusions previously, but in case when one of the two
drivers is the clock provider I think there is still an issue there.

The drivers are supposed to be platform agnostic, but the clock provider
would have to include mach specific declarations of struct clk, wouldn't
it ?

Regards,
Sylwester
