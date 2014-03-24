From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Mon, 24 Mar 2014 15:53:48 +0100
Subject: imx-drm: screen flickering
In-Reply-To: <201402012356.45736.marex@denx.de>
References: <CAH9NwWe673znThNPWRvOCyAU2o7M-oouHD7+1tyRcmWTeJ8YFw@mail.gmail.com>
 <201401291553.15040.marex@denx.de> <20140130074526.GQ16215@pengutronix.de>
 <201402012356.45736.marex@denx.de>
Message-ID: <CAH9NwWcAGM7qL3ADqObL784T6=nDwbZ+6iM1NA79+9reUguMeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> On Thursday, January 30, 2014 at 08:45:26 AM, Sascha Hauer wrote:
> > On Wed, Jan 29, 2014 at 03:53:14PM +0100, Marek Vasut wrote:
> > > On Wednesday, January 29, 2014 at 12:15:57 PM, Sascha Hauer wrote:
> > > > Hi Christian,
> > > >
> > > > On Tue, Jan 28, 2014 at 09:11:32AM +0100, Christian Gmeiner wrote:
> > > > > Hi all.
> > > > >
> > > > > From time to time it happens that my LVDS display is flickering (look
> > > > > at scroll bar in the video).
> > > > > https://drive.google.com/file/d/0B_fznDimUHVubWtvVFlMTkdBbUU/edit?usp
> > > > > =sha ring
> > > > >
> > > > > I really want to find the root cause of it, but I do not know where
> > > > > to start. I can trigger this
> > > > > sometimes after xscreensever "blanks" the screen and the screensafer
> > > > > gets disabled
> > > > > via user input.
> > > > >
> > > > > Any hints?
> > > >
> > > > Sorry, no idea. Philipp and me watched the video, but we both haven't
> > > > seen something like this before.
> > >
> > > Isn't it the clock polarity being inverted thing again [1]?
> >
> > Could be, at least the result should look similar. I just wonder why it
> > only happens after a few times doing something. I would expect the clock
> > is always inverted then.
>
> I actually noticed a rather strange behavior when the clock polarity was
> inverted as well. The flicker was not always there in my case either, but I used
> parallel LCD .

I need to check this polarity thing again.

I found some time to look deeper into my screen flickering issue and
did some measurements.

green:   LVDS_0
blue:     LVDS_1
purple:  LVDS_2
yellow:  LVDS_Clk

https://drive.google.com/folderview?id=0B_fznDimUHVuWGZrT0puSldyZ1E&usp=sharing

In theory both measurements should look almost the same but for me it
looks like LVDS_0 and LVDS_1 are wrong.
IPU and LDB are - in my eyes - the only two components involved here.
So I had a look at the imx6 datasheet
and it could only be the IPU causing this kind of problems as the ldb
is does nothing really fancy here.
There is a IPU debug bus but there is quite almost no information on
how to use it. Also I am not sure if
it would help me to identify the issue.

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
