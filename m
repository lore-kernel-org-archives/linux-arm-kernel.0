From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 30 Jan 2015 00:01:57 +0100
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4
In-Reply-To: <CAOesGMjf6mPhq3s9jf+kTvKFkYM+yLdZ7akLQM_q_TCj3qHF3g@mail.gmail.com>
References: <1422532272-32055-1-git-send-email-nicolas.ferre@atmel.com>
 <20150129220256.GG20785@quad.lixom.net>
 <CAOesGMjf6mPhq3s9jf+kTvKFkYM+yLdZ7akLQM_q_TCj3qHF3g@mail.gmail.com>
Message-ID: <20150129230157.GD4164@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29/01/2015 at 14:08:25 -0800, Olof Johansson wrote :
> On Thu, Jan 29, 2015 at 2:02 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Jan 29, 2015 at 12:51:12PM +0100, Nicolas Ferre wrote:
> >> Arnd, Olof, Kevin,
> >>
> >> This is a batch of cleanup/soc modifications that you may also stack on top of
> >> your "soc" branch as the previous one.
> >> It collects some more cleanup material and simplifies the AT91 boot code. Only
> >> some little details remain before having a classical DT boot (without additional
> >> mapping of registers for instance). This part will be addressed in 3.21.
> >>
> >> The switch to multi-platform is not included as it needs some patches in ASoC,
> >> ata and arm-soc/next/drivers to be able to compile. I may send patches or a
> >> pull-request that can be send to Linus late during the merge-window. Tell me
> >> how you feel it can be done (or delayed to 3.21).
> >>
> >> The conflict related to the rename of board-dt-sama5.c => sama5.c is solved in
> >> this branch:
> >> https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=arm-soc-for-next%2bat91-3.20-cleanup
> >>

The conflict is fixed there ;)

> Actually, this one might be causing a regression, since it conflicts
> with a fix that's in mainline now:
> 
> commit b8659752c37ec157ee254cff443b1c9d523aea22
> Refs: v3.19-rc1-4-gb8659752c37e
> Author:     Wenyou Yang <wenyou.yang@atmel.com>
> AuthorDate: Thu Dec 11 15:31:09 2014 +0800
> Commit:     Nicolas Ferre <nicolas.ferre@atmel.com>
> CommitDate: Mon Jan 12 15:50:23 2015 +0100
> 
>     ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree
> 
>     Appearance: On some SAMA5D4EK boards, after power up, the Eth1 doesn't work.
> 
>     Reason: The PIOE2 pin is connected to the NAND_Tree# of KSZ8081,
>     But it outputs LOW during the reset period, which cause the
> NAND_Tree# enabled.
> 
>     Add phy_fixup() to disable NAND_Tree by overriding the Operation
>     Mode Strap Override register(i.e. Register 16h) to clear the NAND_Tree bit.
> 
>     Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> 
> This conflicts since it changes board-dt-sama5.c which is removed by
> this branch, but I don't see the same fixup in your branch.
> 
> I've dropped this branch so that you can address the above without
> causing a bisectability issue -- please send fresh pull request when
> addressed.
> 
> 
> -Olof

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
