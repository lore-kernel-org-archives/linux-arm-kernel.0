From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 May 2010 00:27:11 +0200
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	<t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	<q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	<20100422110025.GC20008@n2100.arm.linux.org.uk>
	<g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
Message-ID: <l2q63386a3d1005011527m3ae92787z2e46189affd1396b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/2 Dan Williams <dan.j.williams@intel.com>:
> On Thu, Apr 22, 2010 at 4:00 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> So has this (which has now been applied to Dan's tree) been tested
>> as I asked on Versatile platforms, or do we have something that could
>> be incompatible with those platforms?
>>
>> I'm basically not acking or applying these patches until something
>> along those lines has happened. ?(And unfortunately I don't have the
>> resources to apply to this at present.)
>
> Just to clarify are you nak'ing these patches for upstream inclusion
> until this testing occurs? ?Or do we just need a !ARCH_VERSATILE
> somewhere to allow any incompatibilities to be worked out later
> in-tree?

None of the stuff you have applied is included in the objects compiled
for Versatile boards. The PL022 driver probably works with Versatile
but noone has tested it and it's not included in any defconfigs.

What I though Russell was worried about was the PL011 and PL180
drivers which *are* in use by Versatile.

So to be clear: none of the stuff that touches the Versatile platform
has been applied so far. Only the U300/U8500 specific stuff has
been patched in, and I'm suggesting also the PL022 driver which
is currently only used by U300 and U8500 to be patched.

That said I hope to bring in help, run QEMU or similar ASAP
so that also the PL011 and PL180 can be cleanly applied for
2.6.35...

Yours,
Linus Walleij
