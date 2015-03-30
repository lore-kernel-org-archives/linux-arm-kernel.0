From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 14:58:18 -0700
Subject: [PATCH v2 0/3] clk: sunxi: Add muxable AHB clock to fix hstimer
 issues
In-Reply-To: <CAGb2v66JqdGLZSAtAds+On3vBe-9Z=o7eQM0MPh42A5jx1fO-g@mail.gmail.com>
References: <1427217729-10017-1-git-send-email-wens@csie.org>
 <20150325185152.GM23664@lukather>
 <CAGb2v66e=ssx=gPMVkc=u0WbhtwCHgbR2Vg3Q3wNTSsBZniaMA@mail.gmail.com>
 <20150325215309.GN23664@lukather>
 <CAGb2v66JqdGLZSAtAds+On3vBe-9Z=o7eQM0MPh42A5jx1fO-g@mail.gmail.com>
Message-ID: <20150330215818.GV23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> For sun8i the default divider results in 300 MHz for AHB, which might
> >> be too fast.
> >
> > I guess you're talking about AHB1? APB2 should be muxed to PLL6 as
> > well.
> 
> Ah, AHB1 yes. Is APB2 muxed from OSC 24MHz too slow?

If it's clocked from the HOSC by default, I guess we're fine.

> >> And we can't do clock rate assignment yet. The clock drivers need
> >> to be split out.
> >
> > Why?
> 
> The clock rate is propagated down the tree from the root OSC 24M
> clock. Unfortunately it is registered after all the A23 clocks,
> due to the way the sunxi clock driver works. So at the time the
> AHB1 clock is registered, the parent clocks all have rate=0,
> as there is no proper reference value for all the factor clocks
> to calculate their rates.

Too bad. I guess we will be able to switch to this when we will have
converted all the clocks.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/fe9694ef/attachment-0001.sig>
