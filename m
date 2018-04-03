From: joe@perches.com (Joe Perches)
Date: Tue, 03 Apr 2018 11:17:03 -0700
Subject: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
In-Reply-To: <20180403173044.GA6031@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch> <1522770597.11653.49.camel@perches.com>
 <20180403173044.GA6031@lenoch>
Message-ID: <1522779423.11653.63.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-03 at 19:30 +0200, Ladislav Michl wrote:
> On Tue, Apr 03, 2018 at 08:49:57AM -0700, Joe Perches wrote:
> > On Tue, 2018-04-03 at 15:45 +0200, Ladislav Michl wrote:
> > > On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Hello Colin,
> > > 
> > > > Trivial fix to spelling mistake in pr_debug message text
> > > 
> > > would you mind making this patch a bit less non-trivial and
> > > change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> > 
> > Presumably, then all the pr_<foo> calls should be changed.
> Yes, that's what non-trivial means here :)

More useful would be less specific originally.

> > diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
[]
> > @@ -1050,21 +1047,18 @@ static void asoc_ssc_exit(struct device *dev)
> >  int atmel_ssc_set_audio(int ssc_id)
> >  {
> >  	struct ssc_device *ssc;
> > -	int ret;
> >  
> >  	/* If we can grab the SSC briefly to parent the DAI device off it */
> >  	ssc = ssc_request(ssc_id);
> >  	if (IS_ERR(ssc)) {
> >  		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
> > -			PTR_ERR(ssc));
> > +		       PTR_ERR(ssc));
> 
> Well, these are usefull, but unrelated changes. But while there, above
> pr_error deserves to be replaced with dev_err as well.

No  dai device.
