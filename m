From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 21:47:58 +0800
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <20100316132305.GA8875@rakim.wolfsonmicro.main>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
	<20100316125955.GB7287@rakim.wolfsonmicro.main>
	<f17812d71003160604q38846792i18efbcf9fb7208f@mail.gmail.com>
	<20100316132305.GA8875@rakim.wolfsonmicro.main>
Message-ID: <f17812d71003160647v22569487k4f767da7dae6d298@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 9:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 16, 2010 at 09:04:22PM +0800, Eric Miao wrote:
>
>> So do you have any detailed plan in your mind? I'm basically thinking if
>> it's possible to setup a common topic branch with pxa-ssp changes to
>> be a common baseline for both trees.
>
> How about creating a branch off 2.6.34-rc1, doing the updates that need
> to be shared on that branch and then when we're happy pulling that topic
> branch into both the PXA and ASoC development trees? ?If required we can
> always merge that branch multiple times into our trees.
>

Sounds good to me. Yet I doubt I won't have many changes to the SSP
from now on, as it's almost very close to what I want at the moment, so
next step work would be:

1. resolve the above conflict
2. merge the pxa168 SSP support

After that, there could be only minor changes, which could be easily
merged either way, and I'd be happy to see ASoC tree add good
support the pxa ssp. So what I'm thinking now is actually which one
is easier, to merge asoc into pxa and get ssp cleaned up or to rebase
asoc onto this ssp cleanup branch. I might need to take a look into
what's going on inside asoc to evaluate this.
