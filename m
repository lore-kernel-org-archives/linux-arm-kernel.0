From: ben@trinity.fluff.org (Ben Dooks)
Date: Wed, 2 Sep 2009 20:09:34 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
Message-ID: <20090902190934.GN25153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 10:44:35PM +0900, jassi brar wrote:
> On Wed, Sep 2, 2009 at 9:11 PM, Harald Welte<laforge@gnumonks.org> wrote:
> > On Wed, Sep 02, 2009 at 11:05:01AM +0100, Mark Brown wrote:
> >> > === Sound ===
> >> > * needs further investigation, there are many different drivers/versions/options
> >>
> >> Merge any changes in with the mainline drivers - there's relatively
> >> little difference from the s3c24xx IPs. ?There's a reasonable chance
> >> I'll get round to this myself for the 64xx series since I have one which
> >> I'm using for some of my development.
> >
> > Apparently there are also features like operating the SoC codec in slave mode
> > as well as different clock configurations wich mainline is missing.
> 
> Yes, none of mainline SMDK supports SoC-Slave mode or sourcing I2S IP with
> various possible clocks(PCLK, EPLL, CDCLK) etc yet. Samsung tree has
> implemented
> and fully tested these features for 6410, 6440 and C100.
> 
> My idea is to submit only "better enabled" I2S driver with Slave support.
> Clock sourcing related patch maybe later added when the EPLL etc clock
> support has been submitted.

Nope, the extant driver can do slave mode, all you need to do is write
the correct codec<>dai driver and it will do it. 

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
