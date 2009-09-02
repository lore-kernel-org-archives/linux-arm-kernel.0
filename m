From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 2 Sep 2009 20:22:14 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902121158.GU32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
Message-ID: <20090902192214.GQ25153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 09:11:58PM +0900, Harald Welte wrote:
> Hi Mark,
> 
> On Wed, Sep 02, 2009 at 11:05:01AM +0100, Mark Brown wrote:
>  
> > > === Sound ===
> > > * needs further investigation, there are many different drivers/versions/options
> > 
> > Merge any changes in with the mainline drivers - there's relatively
> > little difference from the s3c24xx IPs.  There's a reasonable chance
> > I'll get round to this myself for the 64xx series since I have one which
> > I'm using for some of my development.
> 
> please note there are something like four different versions of the audio IP
> core in Samsung SoCs.  I myself am not familiar with the detailed technical
> differences.  So in any case we'll try to submit the current code in a way
> that will not create conflicts or issues with code that is pending further
> down the road for s5pc100. or s5pc110.

There's pretty good support for the style that was first in the s3c2412,
which I belive was the last of the two-channel I2S blocks.
 
> Apparently there are also features like operating the SoC codec in slave mode
> as well as different clock configurations wich mainline is missing.

I've run an WM8530 in slave mode on an S3C6410, so it was working last
time I tried it. It was one of the test cases to check the code out before
it was submitted.

What we don't yet have in the mainline is any of the 'V40' which are for
5.1 style I2S links (multiple tx paths).

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
