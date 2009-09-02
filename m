From: laforge@gnumonks.org (Harald Welte)
Date: Wed, 2 Sep 2009 21:11:58 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902100500.GA4012@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
Message-ID: <20090902121158.GU32606@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Sep 02, 2009 at 11:05:01AM +0100, Mark Brown wrote:
 
> > === Sound ===
> > * needs further investigation, there are many different drivers/versions/options
> 
> Merge any changes in with the mainline drivers - there's relatively
> little difference from the s3c24xx IPs.  There's a reasonable chance
> I'll get round to this myself for the 64xx series since I have one which
> I'm using for some of my development.

please note there are something like four different versions of the audio IP
core in Samsung SoCs.  I myself am not familiar with the detailed technical
differences.  So in any case we'll try to submit the current code in a way
that will not create conflicts or issues with code that is pending further
down the road for s5pc100. or s5pc110.

Apparently there are also features like operating the SoC codec in slave mode
as well as different clock configurations wich mainline is missing.

Jaswinder (you know him from previous mails) today stated he will look into
this.  We have just not defined yet in detail what features will be submitted
and what are the priorities.

If you (Mark) would want to work on this, pleaes coordinate with Jaswinder so
there is no duplication of work.  I believe the most current driver source is
the one in the 2.6.29-samsung branch - but that one already has the s5pc stuff,
which will have to be removed for mainline right now.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
