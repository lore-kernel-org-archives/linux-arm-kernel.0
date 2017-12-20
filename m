From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 20 Dec 2017 14:39:18 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a363oaDdBSV3k2uAE0UVUbuBsHUeo94OBMX4F_7jC-T5Q@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900> <20171213095257.5cf424fb@jawa>
 <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
 <CAK8P3a22-Q6Ksqh3eeoq-iLcs9PA2kZ12Cjp5ibPUKvU8dhbrw@mail.gmail.com>
 <1513774853.1538.15.camel@Nokia-N900>
 <CAK8P3a363oaDdBSV3k2uAE0UVUbuBsHUeo94OBMX4F_7jC-T5Q@mail.gmail.com>
Message-ID: <1513777158.1538.24.camel@Nokia-N900>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd!

On Wed Dec 20 14:14:07 2017 Arnd Bergmann <arnd@arndb.de> wrote:
> > If it will be still possible to build the binary kernel of the same
> > size after the conversion, I'm in for testing, otherwise it will not
> > fit into Flash any more...
> 
> I think there is an increase in code size that comes mainly from the
> common clock layer itself, plus a few bytes here and there. Obviously
> the increase is much bigger if you actually enable multiple platforms.
> 
> Here is the size of the uncompressed vmlinux file with the current
> clk implementation, compared to a build with a build containing the
> common clk code but no clock driver, and the separate clock
> implementation we have today:
> 
>? ? ?  text? ? ?  data? ? ? ?  bss? ? ? ?  dec? ? ? ?  hex filename
> 4752655 1036028 128260 5916943 5a490f build/tmp/vmlinux-old-clk
> 4780174 1040524 128284 5948982 5ac636 build/tmp/vmlinux-common-clk
>? ? ?  2491? ? ?  1700? ? ? ? ? ?  0? ? ?  4191? ? ?  105f
> build/tmp/arch/arm/mach-ep93xx/clock.o
> 
> The difference would come to about 0.7% of the current image size,
> I guess around 1% when the other changes are included. Is that within
> the margins you have, or is this already critical?

No, your numbers are promising, I was afraid of the increase of other orders of magnitude. So this should be fine.

Thanks for this info.

--
Alex.
