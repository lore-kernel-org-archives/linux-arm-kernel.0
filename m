From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Feb 2011 10:33:43 +0900
Subject: [PATCH 1/2] ARM: S5PC110: disable unused power regulators on Goni
	board
In-Reply-To: <01f301cbd343$d0af4c90$720de5b0$%kim@samsung.com>
References: <1297760784-8486-1-git-send-email-m.szyprowski@samsung.com>
	<1297760784-8486-2-git-send-email-m.szyprowski@samsung.com>
	<01f301cbd343$d0af4c90$720de5b0$%kim@samsung.com>
Message-ID: <022a01cbd3c2$e335ef70$a9a1ce50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Marek Szyprowski wrote:
> >
> > A lot of power regulator has been enabled by default causing the board
> > to consume a lot of power. This patch fixes this issue.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pv210/mach-goni.c |   10 +---------
> >  1 files changed, 1 insertions(+), 9 deletions(-)

(snip)

> > @@ -371,7 +369,6 @@ static struct regulator_init_data goni_ldo11_data =
{
> >  		.min_uV		= 2800000,
> >  		.max_uV		= 2800000,
> >  		.apply_uV	= 1,
> > -		.always_on	= 1,
> >  	},
> >  };

Oops, already merged above changes by Sylwester's "Add supplies for CIF
camera on GONI board" into my for-next.
So will apply this with removing above changes.

(snip)

> > @@ -391,7 +387,6 @@ static struct regulator_init_data goni_ldo13_data =
{
> >  		.min_uV		= 2800000,
> >  		.max_uV		= 2800000,
> >  		.apply_uV	= 1,
> > -		.always_on	= 1,
> >  	},
> >  };

Same as above.

> > @@ -401,7 +396,6 @@ static struct regulator_init_data goni_ldo14_data =
{
> >  		.min_uV		= 1800000,
> >  		.max_uV		= 1800000,
> >  		.apply_uV	= 1,
> > -		.always_on	= 1,
> >  	},
> >  };

Same as above.

(snip)

> > --
> 
> Ok...will apply this.
> And how about "mach-aquila.c"?
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
