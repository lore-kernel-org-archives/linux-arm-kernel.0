From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 Jan 2014 09:53:13 +0900
Subject: [PATCH 0/9] Renesas RSPI/QSPI DT support
In-Reply-To: <CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
Message-ID: <20140114005312.GF18217@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 01:55:19PM +0100, Geert Uytterhoeven wrote:
> On Sun, Jan 12, 2014 at 12:13 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:

        [1/9] spi: rspi: Add missing clk_disable() calls in error and cleanup paths
        [2/9] spi: rspi: Convert to clk_prepare_enable/disable_unprepare           
        [3/9] spi: rspi: Use NULL as the clock ID
        [4/9][V3] spi: rspi: Add DT support

> >     [5/9] ARM: shmobile: r7s72100: Add RSPI clocks for DT
> >     [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
> >     [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
> >     [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
> >     [9/9] ARM: shmobile: koelsch: Add QSPI nodes
> 
> Forgot to mention:
> 
> The ARM/shmobile part is based on renesas-devel-v3.13-rc7-20140109v2, with
> Magnus' pinctrl, Wolfram's riic, Simon's sh_eth, Valentine's i2c pinctrl
> and Laurent's SCIF DT work applied on top.
> [Simon: I don't know in which order you will merge these. If you want me
>  to rebase my patches, just ask! Thanks!]

Firstly, I would like an Ack from Magnus on the shmobile patches.

With regards to merge order, my preference is to merge patches
in parallel once their dependencies will no longer change.

So for this series it lools like.

5/9: Can be merged independently of other patches in the series.
     But there isn't much point in merging it until the rest of the
     series is acked and tested.
6-9/9: Needs to wait until 4/9 has at least been acked by Mark
       Also, is 1/9 a run-time dependency of these changes?
