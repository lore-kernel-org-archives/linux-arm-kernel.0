From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jun 2011 14:41:24 +0200
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <BANLkTikQGFA7XcuAtEEi7_4m-j6-00sZ6Q@mail.gmail.com>
References: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
	<1309430517-23821-2-git-send-email-s.hauer@pengutronix.de>
	<BANLkTikQGFA7XcuAtEEi7_4m-j6-00sZ6Q@mail.gmail.com>
Message-ID: <201106301441.24493.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 June 2011, Bill Gatliff wrote:
> I'm completely against this effort.
> 
> The objections to my submission weren't ever because I was changing
> the user-visible API, so I don't think you can claim any advantage to
> mine in that regard.
> 
> I will take some blame for not getting my API finished, but I have
> been fighting some serious non-work issues that have consumed nearly
> all of my available time--- including the professional time I would
> otherwise have to invest in getting my code finished.
> 
> Is there the possibility that we could cooperate to get my patches
> finished, rather than discarding and reinventing them completely?

I've looked at your patches again, and it seems that you are doing
two distinct changes, both good:

1. You provide a generic framework for pwm drivers that makes it
possible for multiple drivers to coexist and simplifies the way
that these drivers interact with the core OS.

2. You extend and fix a number of aspects in the global PWM API.

Sascha's patch does only part 1, not part 2, but I don't think that
makes his patches any worse. The introduction of the framework
now is very similar to what you had suggested, and you should
probably be mentioned in the changelog, even though the two
implementations were done independently.

A lot of people want to see a framework get merged, and I think it's
great that Sascha has volunteered to do the work to push that
through this time, especially since you have not been able to
finish your work.

What I think would be the best plan forward is to merge Sascha's
patches as soon as we can, then get all currently existing pwm
drivers converted to that and moved to drivers/pwm, and finally
do the interface changes that you have proposed earlier.

I would also hope that you can give constructive feedback to
the submission and point out potential problems that you see
where the code should be changed now in order to make your
interface changes more easy later.

I realize that it's annoying to spend a lot of time on a specific
implementation and then see competing code get merged. Unfortunately,
this happens all the time, and the code we merge is often not
the one that has had the most effort spent on it, but the one that
looks most promising at the time when it gets merged.

	Arnd
