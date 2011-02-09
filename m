From: davidb@codeaurora.org (David Brown)
Date: Wed, 09 Feb 2011 13:54:17 -0800
Subject: [PATCH] msm: Remove arch-specific gpiomux tables
In-Reply-To: <AANLkTimOAOirgH7haDJjf265zdbvoei=f=GGxQEh+5dh@mail.gmail.com>
	(Dima Zavin's message of "Wed, 9 Feb 2011 12:59:33 -0800")
References: <4D4CAB63.4050301@codeaurora.org>
	<AANLkTimOAOirgH7haDJjf265zdbvoei=f=GGxQEh+5dh@mail.gmail.com>
Message-ID: <8yaei7gq3g6.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09 2011, Dima Zavin wrote:

> I don't like this solution of putting the magicly named array into the
> board file. What if I want multiple boards to be built into the same
> kernel? What if I want multiple tables in case I have different
> revisions of the board?

Especially since there is a push by some to be able to build everything
into a single kernel.

> The more correct way would be to add a function to gpiomux.c to be
> able to apply a list of gpiomux configs, something like:
>
> int msm_gpiomux_config_table(struct msm_gpiomux_cfg *table, int num);

Good idea.  Although, I think a name like msm_gpiomux_add_configs()
might fit better with other namings.

David
