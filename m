From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Mar 2013 12:44:34 +0100
Subject: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
In-Reply-To: <20130326111729.GQ5627@lunn.ch>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
 <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
 <5151249D.4000602@ti.com> <51517F5C.3090505@linaro.org>
 <20130326111729.GQ5627@lunn.ch>
Message-ID: <51518A22.2040801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 12:17 PM, Andrew Lunn wrote:
>>> All above code is completly generic and I would rather create
>>> some thing like "drivers/cpuidle/generic-idle.c" where it can
>>> handle all the registration stuff for all arch's rather than
>>> just ARM. There is nothing ARM specific in above code IMHO.
>> Yes, it seems generic but it won't be.
> It very much sounds like you are going in the wrong direction.  You
> should be moving towards generic code, not away from generic code.

Well, I am going to the right direction but with an intermediate step :)

But indeed, I will introduce this init function in the generic code
directly and rebase the patchset.

Rafael, is possible to apply the patches 1 - 5 ? Or shall I resend the
subset ?

> Yes, you at some point will need ARM specific code, but that should be
> a minor part and can be placed somewhere else, and called by a
> function pointer, or the generic code can be in a library and called
> from the ARM specific code, etc.
>
>      Andrew
>
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
>
