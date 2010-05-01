From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 23:44:29 +0100
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	<t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	<q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	<20100422110025.GC20008@n2100.arm.linux.org.uk>
	<g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
Message-ID: <20100501224429.GA17693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 01, 2010 at 03:00:09PM -0700, Dan Williams wrote:
> Just to clarify are you nak'ing these patches for upstream inclusion
> until this testing occurs?  Or do we just need a !ARCH_VERSATILE
> somewhere to allow any incompatibilities to be worked out later
> in-tree?

What I don't want to do is to get into the situation where we throw
this patchset into the kernel and then find that we have to invent a
whole new implementation in the various primecell drivers to support
the Versatile hardware.

Versatile has some MUXing on three of the DMA signals, so (eg) we
really don't want UARTs claiming DMAs just because they're in existence
and not in use - that would prevent DMAs from being used for (eg) AACI
or MMC.

The alternative is that we could just take the attitude that Versatile/
Realview will never have DMA support implemented, but that seems rather
silly, as they've tended to be the first platforms I get new CPU
architectures for.  (This is why DMA coherency stuff on new architectures
tends to be left for others to do...)
