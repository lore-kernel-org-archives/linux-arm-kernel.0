From: olof@lixom.net (Olof Johansson)
Date: Mon, 23 Jul 2018 09:22:42 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.19
In-Reply-To: <CAMuHMdVbyUa5PtQf4LZQDv-=aqToahX5Eb4TEDvsJniYm-trNQ@mail.gmail.com>
References: <cover.1532086504.git.horms+renesas@verge.net.au>
 <20180721220343.yuwrfxz3fo25krzv@localhost>
 <CAMuHMdVbyUa5PtQf4LZQDv-=aqToahX5Eb4TEDvsJniYm-trNQ@mail.gmail.com>
Message-ID: <CAOesGMh09Do+Yv-C+4hE0KdShajr0hVRfLEPmeoH0AmM5kVAmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 2:11 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Olof,
>
> On Sun, Jul 22, 2018 at 12:27 AM Olof Johansson <olof@lixom.net> wrote:
>> On Fri, Jul 20, 2018 at 02:03:54PM +0200, Simon Horman wrote:
>> > Please consider these Renesas ARM based SoC defconfig updates for v4.19.
>
>> > * Set CONFIG_LOCALVERSION to shmobile_defconfig
>> >
>> >   This follows what appears to be common practice in defconfigs
>> >   and allows easier management of the kernel flavour at run-time.
>>
>> I replied to the multi-versions of defconfig for this patch -- it's not a good
>> way to solve the problem of detecting config at runtime. Please drop this
>> patch. See:
>>
>> https://lore.kernel.org/lkml/CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ at mail.gmail.com/
>
> One more comment to the rescue: it does complicate regression testing,
> as the test software running on the DUT has no easy way to distinguish
> between e.g. shmobile_defconfig and multi_v7_defconfig (and whatever
> other board-specific configs I use for testing).
> Yes, I can have these as local patches in my tree (of course I already have ;-),
> but when bisecting, I have to remember to (un)apply them in every step.

Hi,

It looks like scripts/setlocalversion will look for files named
localversion* in the directory you build in, git won't touch the file
so you don't have to re-apply it every time.

I do see the usefulness for bisect and so on, but there's such a high
chance that people will start changing configs without changing
localversion that the value of it will diminish immediately for
downstream trees. Also, the "local" in localversion sort of indicates
that it shouldn't be set in a central place. :)


-Olof
