From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 28 Feb 2018 21:29:50 +0900
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
Message-ID: <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Feb 28, 2018 at 9:17 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Jeffy,
>
> On Wed, Feb 28, 2018 at 12:11 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Currently we are adding all of the attached devices' clocks as pm clocks
>> and enable them when powering on the power domain.
>>
>> This seems unnecessary, because those clocks are already controlled in
>> the devices' drivers with better error handling.
>>
>> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> Thanks for your patch!
>
> Just wondering: so you prefer to handle the clocks explicitly in all drivers,
> instead of delegating this task to Runtime PM?

Is it already possible to gate clocks immediately when the device
idles, but defer turning the power domain off until time long enough
to cover the power down and up latency elapses?

Also, how about systems where runtime PM is disabled? I think that's
one of the reasons we control the clocks explicitly in the drivers
anyway.

Best regards,
Tomasz
