From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 6 Aug 2011 23:29:32 +0200
Subject: experience with the new arm-soc workflow (Was: Re:
	[Ksummit-2011-discuss] ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
Message-ID: <20110806212932.GT31521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Aug 06, 2011 at 06:59:00AM -0700, Olof Johansson wrote:
> I'd like to hear from Arnd what his experiences from this first merge
> window were -- what worked well and where's room for improvement? Any
> particular SoC workflow that should be tuned to make his life easier?
> Where are the gaps where he needs help right now? And how did it work
> out for the SoC maintainers?
I'm neither Arnd nor a SoC maintainer, but another level further down
(read: contributor).
My thoughts about the fixes-cleanups-newfeatures separation is that it
makes contributing harder than before.

Consider I want to contribute a series consisting of a cleanup and a new
feature (that depends on the cleanup). And I want (or even need) to base
this on (say) Sascha's imx tree that already has some other features.
Now the cleanup patch should go on Sascha's (eventually empty) cleanup
branch. But for the feature patch to go on top of both Sascha's feature
branch and his new cleanup branch, he either needs so rebase his feature
branch (which is (at least considered) bad) or he has to merge. I'd say
merging is the correct approach, but the history tends to be more ugly
than without the separation between cleanups and new features.
And if Sascha wants to pull from me (opposed to apply the patches
himself) he needs two merges. 
(So it results in one merge more than before for both cases.)

I'm not sure how welcomed these additional merges are by Linus.

The obvious (to me) ways out are:
 a) Linus can live with these merges; or
 b) drop the separation between cleanup and features; or
 c) Sascha doesn't publish a (fast-forward-only) tree but works with
    a patch queue or git-rebase; or
 d) Sascha keeps my series separate from his other stuff and requests
    Arnd to pull two (or more) cleanup branches and two (or more)
    feature branches; or
 e) Sascha needs something like topgit;

As this problem didn't occur yet in real life, there might be

 f) there is no real problem.

I fear a) and f) don't apply, I don't like c) and d) and I know
Sascha won't like e).
So there might only be b) left unless there is some g) I don't see.
YMMV.

I think separating between fixes and (cleanup+features) isn't a real
problem.

Just my 2?
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
