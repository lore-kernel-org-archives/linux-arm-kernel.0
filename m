From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Aug 2014 17:56:27 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
References: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>	<CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>	<CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>	<53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
Message-ID: <53FE7E3B.1010500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/14 15:33, Olof Johansson wrote:
> On Wed, Aug 27, 2014 at 3:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> Is there any reason why the virtual counter can't be read? Maybe we're
>> the hyp and we need to make sure we don't use the virtual timer so that
>> the guest can use it, but that doesn't have any effect on the usage of
>> the virtual counter for the clocksource.
> There are several cases where virtual is unusable -- in particular it
> might not have been configured properly (i.e. the phys/virt offset is
> at a bad value).
>

Any specifics? It would be nice to say so in the commit text so that
others using such devices know they need this patch. I'm guessing the
firmware can't be fixed?

In this particular case is there actually a virtual interrupt but we've
explicitly removed it from the DT so that the driver can be forced into
using the physical counter? Or are we getting saved by the hyp check?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
