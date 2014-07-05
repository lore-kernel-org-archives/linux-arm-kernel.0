From: joe@perches.com (Joe Perches)
Date: Sat, 05 Jul 2014 14:14:21 -0700
Subject: [PATCH 1/3] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <20140705210359.GA19441@electric-eye.fr.zoreil.com>
References: <1404498697-21978-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404498697-21978-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140705210359.GA19441@electric-eye.fr.zoreil.com>
Message-ID: <1404594861.6384.75.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-07-05 at 23:03 +0200, Francois Romieu wrote:
> Partial review below.

trivia:

> > diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
[]
> > +static int mvpp2_prs_tcam_first_free(struct mvpp2 *pp2, int start, int end)
> > +{
> > +	int tid;
> > +	bool found = false;
> > +
> > +	if (start < end)
> > +		for (tid = start; tid <= end; tid++) {
> > +			if (!pp2->prs_shadow[tid].valid) {
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> > +	else
> > +		for (tid = start; tid >= end; tid--) {
> > +			if (!pp2->prs_shadow[tid].valid) {
> > +				found = true;
> > +				break;
> > +			}
> > +		}
> 
> Missing parenthsesis in "if ... else ..." block.

Perhaps it's better to use swap if start > end

	if (start > end)
		swap(start, end);

so there's just one loop
