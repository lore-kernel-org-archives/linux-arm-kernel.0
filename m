From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 15 May 2016 14:29:29 +0200
Subject: Unclear BSD licensing (headers, MODULE_LICENSE, versions)
In-Reply-To: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
References: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
Message-ID: <57386BA9.9030607@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/15/2016 12:44 AM, Rafa? Mi?ecki wrote:
> Hi,

......

> Another problem is text of BSD license
> 
> 1) Some BSD 2-clause licensed sources don't link to its content.
> 
> In case of GPLv2 some sources simply mention this license and refer to
> COPYING. Few examples:
> a) drivers/bcma/main.c
> "Licensed under the GNU/GPL. See COPYING for details."
> b) drivers/block/umem.c
> "This driver is released to the public under the terms of the GNU
> GENERAL PUBLIC LICENSE version 2
> c) drivers/mfd/tps6507x.c
> "For licencing details see kernel-base/COPYING"

When I talked to some lawyers they did not like it when you only
reference a file and do not explicitly specify which license you are
using. The problem is that the code could be moved to an other project
with a different COPYING file. They were fine with b) because that
explicitly says which license text you mean. When you move this to
somewhere else you can still find our which license was meant here.

> I believe the same could be done for BSD 2-clause license, however
> there is no file that can be pointed. It results in some sources
> specifying 2-clause license in a header without really providing the
> content. Example:
> arch/arm/boot/dts/lpc4350.dtsi
> 
> 2) Some BSD 3-clause or Clear BSD licensed sources don't provide needed text
> 
> Many templates of BSD 3-clause license I found contain <organization>
> that should be replaced by a proper organization/company. That makes
> me suspect we can't have a generic text of BSD 3-clause or Clear BSD
> in any shared file like COPYING. However there are sources that
> specify one of above licenses without providing or linking its text.
> Few examples:
> arch/blackfin/mach-bf609/include/mach/anomaly.h
> drivers/block/zram/zram_drv.c

I like the text of the ISC license:
https://en.wikipedia.org/wiki/ISC_license
This license is a BSD license, but it does not have <organization> in it
and is even shorter that the ofter BSD licenses. Qualcomm Atheros used
this license text for ath9k and some other code. The main purpose was to
make it possible to integrate this code into *BSD. You can also put such
a short license text directly into your code.

This also allowed you to use the code in proprietary operating systems
like VxWorks.

> I'm wondering how we could improve this situation. I got 2 main ideas:
> 
> 1) Extend MODULE_LICENSE
> We could add new acceptable entries specifying BSD version. We could
> try to improve checkpatch.pl to look for a full license in a header
> (it seems to be required as it has to provide <organization>). Maybe
> we could figure out (with some lawyers?) how to treat sources using
> "Dual BSD/GPL" mentioning GPL only (without BSD) in their header.
> 
> 2) Get clear rules on how to write a header
> If you find extending MODULE_LICENSE a bad idea, maybe we can simply
> help people write proper headers. Explain the problem, provide
> examples, maybe add some check in checkpatch.pl.

I see MODULE_LICENSE more as a hint not as a legal binding thing. You
could also have a module which uses a file which is licensed under GPL
and one which is licensed under BSD license. Then the compiled module is
GPL, but parts of the cod is still BSD. I prefer to have the license
information in each source file, as a reference to a license (not some
generic file) or directly the license text.

Hauke
