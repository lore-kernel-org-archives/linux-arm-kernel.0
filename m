From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 13 Aug 2015 14:02:26 +0300
Subject: [PATCH 0/2] x86/KASAN updates for 4.3
In-Reply-To: <20150813090119.GA10280@arm.com>
References: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
 <20150813065040.GA17983@gmail.com>
 <20150813081641.GA14402@gmail.com> <20150813090119.GA10280@arm.com>
Message-ID: <CAPAsAGxk2+v5VG77cOHAThsXyWx-_UJ1XVeJProaa0gQWH5jvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-13 12:01 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> Hi Ingo,
>
> On Thu, Aug 13, 2015 at 09:16:41AM +0100, Ingo Molnar wrote:
>> * Ingo Molnar <mingo@kernel.org> wrote:
>> > * Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> >
>> > > These 2 patches taken from v5 'KASAN for arm64' series.
>> > > The only change is updated changelog in second patch.
>> > >
>> > > I hope this is not too late to queue these for 4.3,
>> > > as this allow us to merge arm64/KASAN patches in v4.4
>> > > through arm64 tree.
>> > >
>> > > Andrey Ryabinin (2):
>> > >   x86/kasan: define KASAN_SHADOW_OFFSET per architecture
>> > >   x86/kasan, mm: introduce generic kasan_populate_zero_shadow()
>> > >
>> > >  arch/x86/include/asm/kasan.h |   3 +
>> > >  arch/x86/mm/kasan_init_64.c  | 123 ++--------------------------------
>> > >  include/linux/kasan.h        |  10 ++-
>> > >  mm/kasan/Makefile            |   2 +-
>> > >  mm/kasan/kasan_init.c        | 152 +++++++++++++++++++++++++++++++++++++++++++
>> > >  5 files changed, 170 insertions(+), 120 deletions(-)
>> > >  create mode 100644 mm/kasan/kasan_init.c
>> >
>> > It's absolutely too late in the -rc cycle for v4.3!
>>
>> Stupid me, I have read 'v4.2' ...
>>
>> So yes, it's still good for v4.3, the development window is still open.
>>
>> The rest still stands:
>>
>> > I can create a stable topic tree for it, tip:mm/kasan or so, which arm64 could
>> > pull and base its own ARM specific work on, if that's OK with everyone.

OK with me.


> Yes please, works for me! If we're targetting 4.3, then please can you base
> on 4.2-rc4, as that's what our current arm64 queue is using?
>

Does this mean that we are targeting arm64 part for 4.3 too?


> Cheers,
>
> Will
