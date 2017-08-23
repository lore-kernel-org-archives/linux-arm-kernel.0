From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 16:15:15 +0200
Subject: [PATCH] [RFC] ARM: vdso: work around gcc-8 warning
In-Reply-To: <20170823141148.GB10088@leverpostej>
References: <20170823140538.1590432-1-arnd@arndb.de>
 <CAKv+Gu-jCzN0K+fhe9GsEwbwuaK6VJrfdLoPnPXnGaQ9qt3WOg@mail.gmail.com>
 <20170823141148.GB10088@leverpostej>
Message-ID: <CAK8P3a1Qb77Y_9+EJ=eJ7UUEpFj2GUcwPrfc3+v+GZVE-3DCTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 4:11 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Aug 23, 2017 at 03:07:04PM +0100, Ard Biesheuvel wrote:
>> On 23 August 2017 at 15:05, Arnd Bergmann <arnd@arndb.de> wrote:

>> > diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
>> > index d0295f1dd1a3..eff7d3a1d1ce 100644
>> > --- a/arch/arm/include/asm/vdso.h
>> > +++ b/arch/arm/include/asm/vdso.h
>> > @@ -11,7 +11,7 @@ struct mm_struct;
>> >
>> >  void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
>> >
>> > -extern char vdso_start, vdso_end;
>> > +extern int vdso_start, vdso_end;
>> >
>> >  extern unsigned int vdso_total_pages;
>>
>> May I suggest
>>
>> extern char vdso_start[], vdso_end[];

This was my first attempt, but when I ran into a build error I did not
even look further

> FWIW, arm64 does this to solve this problem, since commit:
>
> dbbb08f500d61463 ("arm64, vdso: Define vdso_{start,end} as array")
>
> ... and x86 has done likewise for a while.

Yes, this looks good, I'll send a patch to do the same.

    Arnd
