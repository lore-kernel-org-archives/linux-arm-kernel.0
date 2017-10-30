From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Oct 2017 23:53:21 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for
 v4.15
In-Reply-To: <CAK8P3a3oKP-5hgZ+zBZGBgHV8YdCnKpif8-nArsKqVydsajWxw@mail.gmail.com>
References: <CAK7LNARKAivEyNYDMO7GKjTnnsVFk3TtsCZ_yDWLrEf80G-WOQ@mail.gmail.com>
 <CAK8P3a3oKP-5hgZ+zBZGBgHV8YdCnKpif8-nArsKqVydsajWxw@mail.gmail.com>
Message-ID: <CAK7LNAQS0AozzbmG5--m9_Ed_wfmYPgLgWJrF-oJSBG6W5SQWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2017-10-30 22:24 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Oct 23, 2017 at 7:40 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> UniPhier ARM64 SoC DT updates for v4.15
>>
>> - add thermal monitor and thermal zone nodes
>> - add efuse nodes
>> - fix W=2 warnings
>> - add GPIO controller nodes and related properties
>> - add resets properties
>
> I noticed too late that your "ARM32 SoC DT" branch broke ARM64 (I
> don't normally test
> architectures that are not touched by a new branch. What happened here
> is that commit
> 2bef7ca3798f ("ARM: dts: uniphier: route on-board device IRQ to GPIO
> controller")
> added a reference to the non-existing "gpio" label, causing a build error:
>
> arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dtb: ERROR
> (phandle_references): Reference to non-existent node or label "gpio"
>
> Since merging the ARM64 branch fixes the problem, I decided it's not
> worth the trouble
> of reverting the original merge, but please be careful to avoid build
> problems like this
> in the future.
>
> The changes otherwise look all good, so I've pulled this into next/dt as well.
>

My bad - sorry about this.

Actually, some base boards and expansion boards are
shared between arm and arm64 by cross-arch reference.
So, touching one branch could affect the other.

If it had not been too late, I would have been happy to resend the PR.

I will be careful next time.




-- 
Best Regards
Masahiro Yamada
