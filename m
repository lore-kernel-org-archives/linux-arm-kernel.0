From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 22:44:59 +0200
Subject: [PATCH] crypto: arm: workaround for building with old binutils
In-Reply-To: <51652361-AEE7-4C88-920A-5F0ED60EE275@linaro.org>
References: <3461827.FYLMCAIQyv@wuerfel> <2148670.W34n3asXfA@wuerfel>
 <51652361-AEE7-4C88-920A-5F0ED60EE275@linaro.org>
Message-ID: <2057328.zEoCGSuP0u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 April 2015 12:35:19 Ard Biesheuvel wrote:
> 
> Yes, that should work. Could we also move the CE objs to ce-obj-$() and put
> 
> ifneq ($(ce-obj-y)$(ce-obj-m),)
> if <as check>
> obj-y += $(ce-obj-y)
> obj-m += $(ce-obj-m)
> else
> $(warning ...)
> endif
> endif
> 
> around it so you only get the warning if you have selected any of these modules?

Sounds good, I had not thought of that.

> In any case, I strongly prefer to leave the .S files themselves alone if at all possible

Yes, makes sense.

	Arnd
