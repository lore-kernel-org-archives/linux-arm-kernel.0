From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Mar 2010 14:08:34 +0000
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
	<f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
Message-ID: <20100316140834.GB9365@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 09:47:58PM +0800, Eric Miao wrote:

> After that, there could be only minor changes, which could be easily
> merged either way, and I'd be happy to see ASoC tree add good
> support the pxa ssp. So what I'm thinking now is actually which one
> is easier, to merge asoc into pxa and get ssp cleaned up or to rebase
> asoc onto this ssp cleanup branch. I might need to take a look into
> what's going on inside asoc to evaluate this.

Rebasing isn't an option for ASoC - it gets merged into Takashi's tree
for one thing (and I don't see any reason why rebasing would be required
anyway, no point in discarding history).  A merge into ASoC should be
sufficient, right now there's no changes at all in the SSP code against
Linus' tree so that'll be trivial anyway at the minute.

There's also no need to pick one route for the merge - if we do merges
and avoid rebasing then git will cope fine.
