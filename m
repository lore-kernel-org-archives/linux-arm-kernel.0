From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Tue, 13 Nov 2018 10:24:22 +0000
Subject: [PATCH 06/27] kernel: Define gettimeofday vdso common code
In-Reply-To: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
 <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
Message-ID: <61f77f06-396e-9293-c8cc-28fe7ea32af5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/11/2018 16:18, Arnd Bergmann wrote:
> On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
>>
>> This patch tries to unify the gettimeofday vdso implementation
>> introducing lib/vdso. The code contained in this library can
>> ideally be reused by all the architectures avoiding, where
>> possible, code duplication.
>>
>> In doing so, tries to maintain the performances using inlining as much
>> as possible and consequently reduces the surface for ROP type of attacks.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> I just noticed that this new version misses some of the cleanups
> that Thomas recently did in the x86 version, e.g. f3e839384164
> ("x86/vdso: Replace the clockid switch case").
> 
> I haven't looked at all the details, but I'd suggest using the latest
> x86 code as a base.
> 

Ok, I will have a look at Thomas' work. Thanks for pointing this out. 

>         Arnd
> 

-- 
Regards,
Vincenzo
