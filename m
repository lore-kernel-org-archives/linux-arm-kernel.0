From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 20 Oct 2010 11:18:24 -0700
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <AANLkTinHOOPfke2dJrQ1=+vzsa=0BSQjkX5ai7mwpcF8@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Wed, 20 Oct 2010 15:00:22 +0200")
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
	<8739s2xfuk.fsf@deeprootsystems.com>
	<AANLkTinHOOPfke2dJrQ1=+vzsa=0BSQjkX5ai7mwpcF8@mail.gmail.com>
Message-ID: <87wrpcsp73.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Tue, Oct 19, 2010 at 7:16 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Ohad Ben-Cohen <ohad@wizery.com> writes:
>>
>>> From: Simon Que <sque@ti.com>
>>>
>>> Add driver for OMAP's Hardware Spinlock module.
>>>
>>> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
>>> provides hardware assistance for synchronization between the
>>> multiple processors in the device (Cortex-A9, Cortex-M3 and
>>> C64x+ DSP).
>>
> ...
>
>>> +config OMAP_HWSPINLOCK
>>> + ? ? bool "OMAP Hardware Spinlock module"
>>
>> Should be tristate
>
> Agree,
>
>> so it can also be built as a module by default.
>>
>> e.g., when building multi-OMAP kernels, no reason or this to be
>> built-in. ?It can then be loaded as a module on OMAP4 only.
>
> But considering the current built-in use cases (i2c) we would then
> need to have the relevant MACH_OMAP4_* select OMAP_HWSPINLOCK (only on
> the OMAP4 machines on which the I2C bus is shared).

Yes, that is ok.  At least then it can be tested by default as a module.

Kevin
