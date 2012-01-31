From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 Jan 2012 21:59:06 -0800
Subject: [GIT PULL] DaVinci fixes for v3.3-rc
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317A99AD@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6317A70FB@DBDE01.ent.ti.com>
 <CAOesGMgkkO1B7fk6gDYvh+N32rtzJuPB34Hyz=nQ2OimXU1azw@mail.gmail.com>
 <DF0F476B391FA8409C78302C7BA518B6317A99AD@DBDE01.ent.ti.com>
Message-ID: <CAOesGMhyOp88DchMuVnGqyiXYUNbitJOFfLb7NjLPgszYq2m7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 30, 2012 at 9:16 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Olof,
>
> On Mon, Jan 30, 2012 at 04:09:37, Olof Johansson wrote:
>> Hi,
>>
>> On Fri, Jan 27, 2012 at 9:26 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
>> > Hi Olof, Arnd,
>> >
>> > Can you please pull these DaVinci fixes for the next v3.3-rc?
>> > Both the patches have not been stable tagged. The fix by me
>> > is a v3.3 regression. The fix by Bas van den Berg is not critical
>> > enough to get into stable kernels.
>> >
>> > Thanks,
>> > Sekhar
>> >
>> > The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
>> > ?Linus Torvalds (1):
>> > ? ? ? ?Linux 3.3-rc1
>> >
>> > are available in the git repository at:
>> >
>> > ?git://gitorious.org/linux-davinci/linux-davinci.git fixes
>> >
>> > Bas van den Berg (1):
>> > ? ? ?ARM: davinci: DA850: remove non-existing pll1_sysclk4-7 clocks
>> >
>> > Sekhar Nori (1):
>> > ? ? ?ARM: davinci: update mdio bus name
>>
>> Looks like the clock removal is almost crossing over into cleanup
>> territory not a fix. In the future please help us out by briefly
>> motivate why it's a fix (for something that is broken) and not a
>> cleanup if it's not obvious from reading it -- noncritical fixes are
>> usually saved for the next merge window instead.
>
> I categorized it as a fix since the path removes clocks which don't
> exist in hardware. Accessing such clocks will cause undefined behavior.
>
> The patch description does say that the clocks don't exist in hardware.
> Code without the patch is definitely outside the specification.
>
> In this regard, what could have been done better in the patch description?

A brief note as to why this should be cleaned up in time for 3.3
instead of wait for the 3.4 merge window (i.e. explain what breaks
with using the kernel if this isn't picked up).

If the definitions are wrong, and there are no in-tree users of them,
it's less critical to get an urgent fix in -- especially if the broken
code wasn't added in this merge window. Later in the -rc release cycle
this becomes more important, since technically only regressions and
critical bugfixes are supposed to go in then.

Anyway, I am splitting hairs here. The fix was good to go in, and I'm
not looking to argue over it. :)


-Olof
