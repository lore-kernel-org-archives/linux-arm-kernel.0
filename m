From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Feb 2018 13:37:20 +0800
Subject: [PATCH v4 0/8] ARM: sun9i: SMP and CPU hotplug support
In-Reply-To: <CAGb2v67WeUPx2X0aJev0ezu5aO6TYsZMuxM2njictxPHRePPYA@mail.gmail.com>
References: <20180117084654.8234-1-wens@csie.org>
 <CAGb2v67WeUPx2X0aJev0ezu5aO6TYsZMuxM2njictxPHRePPYA@mail.gmail.com>
Message-ID: <CAGb2v64STu=qsWO2aZqqngVjqpN94hwt=ASgA-8C499Gkkh47w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 4:15 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi Nicolas, Dave,
>
> On Wed, Jan 17, 2018 at 4:46 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> This is v4 of my sun9i SMP/hotplug support series which was started
>> over two years ago [1]. We've tried to implement PSCI for both the A80
>> and A83T. Results were not promising. The issue is that these two chips
>> have a broken security extensions implementation. If a specific bit is
>> not burned in its e-fuse, most if not all security protections don't
>> work [2]. Even worse, non-secure access to the GIC become secure. This
>> requires a crazy workaround in the GIC driver which probably doesn't work
>> in all cases [3].
>>
>> Version 3 completely did away with the MCPM framework, instead just
>> implementing a set of smp_ops. Most of the code from the previous
>> version was reused, so the structure still has some traces of MCPM.
>> As our hardware has CCI-400, we still need some sort of MMU/cache
>> disabled trampoline code to enable cache coherency. Code for this
>> was adapted from the MCPM framework. This and the entry code are done
>> in inline assembly. Most of the other sunxi-specific code is derived
>> from Allwinner code and documentation, with some references to the
>> other MCPM implementations, as well as the Cortex's Technical Reference
>> Manuals for the power sequencing stuff.
>>
>> In version 4, all traces of MCPM have been removed, except in the
>> comments for atttributing code sources. Thumb2 mode is also fixed.
>> It failed due to an unaligned word access.
>
> Any more comments on this series? Or is it OK for you guys now that
> there are no traces of MCPM? :)
>
> We'll merge this series later this week for 4.17 if nothing else.

Merged for 4.17.

Thanks
