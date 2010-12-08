From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 11:03:36 +0000
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
In-Reply-To: <233071.45934.qm@web180308.mail.gq1.yahoo.com>
References: <233071.45934.qm@web180308.mail.gq1.yahoo.com>
Message-ID: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 7:43 AM, David Brownell <david-b@pacbell.net> wrote:
>
> --- On Tue, 12/7/10, Dave Martin <dave.martin@linaro.org> wrote:
>
>> From: Dave Martin <dave.martin@linaro.org>
>> Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6...
>
>> This makes sense, because Thumb-2
>> code can't execute on anything
>> prior to ARMv7.
>
> WRONG ... but you may be overlooking the
> fact that there are at least three
> flavors of Thumb-2 ...
>
> ?- Original, as on some ARMv6 chips ARM1156 was
> the introductory Thumb2 core).? It's Thumb1
> plus a very few 32-bit instructions.? (And
> maybe the SIMD instructions too; I forget.? Not
> suitable for OS work like IRQ handling, ISTR; or
> at least, not as suitable as the ARMv7 flavors.
>
> ?-Microcontroller ... ARMv7M chips, and likely
> not available on Linux-capable hardware ...???Suitable for RTOS work like IRQ
> handling.

You're correct on some points ... *but* v7-M is not supported in the
kernel yet, and in any case full linux is not applicable - this will
be ucLinux territory.  v7-M shares much of the instruction set with
v7-A/R, bit it's a substantially different architecture when it comes
to things like exception handling etc.

The v6T2 architecture supported by arm1156 does have comprehensive
Thumb-2 support (not just a few 32-bit instructions), and arm1156
supports taking of exceptions in Thumb-2 etc., so in principle the
complete OS could be built in Thumb-2 as is the case for v7.  But this
particular processor is rare and I believe it's not supported in the
kernel right now ... and not likely to be.  No other processors
implement v6T2, and no new processors will implement it either.

The rules might need to be refined later, but !CPU_V6 seems sensible for now.

Cheers
---Dave
