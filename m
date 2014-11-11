From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 11 Nov 2014 20:01:10 +0100
Subject: [PATCH v3 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <20141111150139.A904BC416AF@trevor.secretlab.ca>
References: <1415283784-10885-1-git-send-email-romain.perier@gmail.com>
 <1415283784-10885-2-git-send-email-romain.perier@gmail.com>
 <20141111150139.A904BC416AF@trevor.secretlab.ca>
Message-ID: <CABgxDoLfGYRnGCLmxnW6XCwJo3AoecO3=sLNBsOUAHig3P8New@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-11 16:01 GMT+01:00 Grant Likely <grant.likely@linaro.org>:
> So, to be a little pendantic, the 'ti,' prefix is basically just for
> backwards compatibility with the old binding, and that old binding is
> only used on palmas.c, tps65*.c and twl4030-power.c, correct?

No, the backward compatibility here is only useful for drivers which
used "ti,system-power-controller" in the past and recently switched to
the new property through the standard helper function. As most of the
dts were not updated to use the new property, previous patches broke
compatibility with "ti,system-power-controller" (this compat would be
reverted with this serie). Only one driver has this problem, it is
tps65910.

So, What you propose is that I should handle the old property directly
from tps65910, and keep the standard helper generic right ?

Romain




>
> We don't actually want a ti comparison in the generic code. Normally
> what you'd do here is have the fixup in the ti driver code, possibly
> with a ti specific helper for those 4 files.
>
> I'm not going to nak this patch and I know you need to get things cleaned
> up, but the static inline really should be reduced back to just checking
> only for "system-power-controller". The current mainline code does the
> right thing anyway, and it is a *tiny* amount of extra code in 4 drivers
> file.
>
> g.
>
>
>>  }
>>
>>  #endif /* _LINUX_OF_H */
>> --
>> 1.9.1
>>
>
