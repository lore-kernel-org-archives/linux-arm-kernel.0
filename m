From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Dec 2012 18:49:26 -0800
Subject: [PATCH] ARM: EXYNOS: Fix compile error in dev-audio.c
In-Reply-To: <CAOesGMhgvsM7Fk-YpihjYM6h+xqK-ejBzPKEDypfdKEmHp6ZJg@mail.gmail.com>
References: <000701cdd9d3$3b6a6e10$b23f4a30$%choi@samsung.com>
 <CAOesGMhgvsM7Fk-YpihjYM6h+xqK-ejBzPKEDypfdKEmHp6ZJg@mail.gmail.com>
Message-ID: <001301cddd93$7956e000$6c04a000$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:

[...]
 
> Looks like the breakage was caused by the following commit:
> 
> commit 1974a042dd15f1f007a3a1a2dd7a23ca0e42c01d
> Author:     Padmavathi Venna <padma.v@samsung.com>
> AuthorDate: Wed Nov 28 16:17:48 2012 +0530
> Commit:     Mark Brown <broonie@opensource.wolfsonmicro.com>
> CommitDate: Wed Nov 28 19:18:00 2012 +0000
> 
>     ASoC: Samsung: Get I2S src_clk from clock alias id.
> 
> Padmavathi, you can't send out code that breaks all Samsung platforms
> like this, even if there are patches out there that fixes it. Changes
> have to be bisectable, which means that you can't break and unbreak
> the build, least of all if you merge through different maintainers.
> And you need to tell the other maintainer that there are dependent
> patches, you just sent the above patch to Mark without any such
> information.
> 
Oops, I thought the 'src_clk'  should be restored with my drop the commit
48a2050d ("ARM: SAMSUNG: Delete the unnecessary variable"), however, seems
other patch has same changes...What's happening?

See below,
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/134979.h
tml

> Kukjin, I see that Padmavathi has posted a V3 series of patches to
> remove all this from the dev-audio files on November 23. Are you ok
> with us picking them up and sending ASAP?
> 
Hmm, just Mark's following can fix it but I didn't look at it yet.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/134911.h
tml

- Kukjin
