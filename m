From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Oct 2012 16:24:42 +0200
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
In-Reply-To: <20121011134458.GB15428@gmail.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <20121011134458.GB15428@gmail.com>
Message-ID: <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 3:44 PM, Lee Jones <lee.jones@linaro.org> wrote:

>> Patches are based on Linus Torvalds tree with latest commit as of okt 10.
>
> Hmm... I get:
>
> Applying: clk: ux500: Support for prcmu_scalable_rate clock
> error: drivers/clk/ux500/clk-prcmu.c: does not exist in index
> error: drivers/clk/ux500/clk.h: does not exist in index
> Patch failed at 0001 clk: ux500: Support for prcmu_scalable_rate clock
>
> So when did drivers/clk/ux500/* arrive?

Exactly here, 10 days ago on Torvalds' master branch:

commit 2c0c86d5b67ee04e8b71a2ea2a3af6d224611cfc
Merge: fdb2f9c 494bfec
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Oct 1 12:09:04 2012 -0700

    Merge tag 'clk-for-linus' of git://git.linaro.org/people/mturquette/linux

    Pull clk framework update from Michael Turquette:
     "The common clk framework changes for 3.7 are dominated by ARM platform
      ports to the framework along with one MIPS port, one MFD port, one
      minor framework enhancement and one helper function for platforms
      expressing their clock data through device tree."

    * tag 'clk-for-linus' of git://git.linaro.org/people/mturquette/linux:
      clk: add of_clk_src_onecell_get() support
      clk: ux500: Define smp_twd clock for u8500
      mfd: dbx500: Provide a more accurate smp_twd clock
      clk: ux500: Support for prmcu_rate clock
      clk: Provide option for clk_get_rate to issue hw for new rate
      clock: max77686: Add driver for Maxim 77686 32Khz crystal oscillator.
      ARM: ux500: Switch to use common clock framework
      clk: ux500: Clock definitions for u8500
      clk: ux500: First version of clock definitions for ux500
      clk: ux500: Adapt PRCMU and PRCC clocks for common clk
(...)

Yours,
Linus Walleij
