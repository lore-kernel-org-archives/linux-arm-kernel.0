From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 4 Jul 2013 13:07:42 +0200
Subject: On common struct clk in clock framework.
In-Reply-To: <201307041258.49200.heiko@sntech.de>
References: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
 <2625323.Iy4l3LBv4H@amdc1227> <201307041258.49200.heiko@sntech.de>
Message-ID: <201307041307.42397.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. Juli 2013, 12:58:48 schrieb Heiko St?bner:
> Hi,
> 
> Am Donnerstag, 4. Juli 2013, 12:32:26 schrieb Tomasz Figa:
> > On Thursday 04 of July 2013 10:21:27 mind entropy wrote:
> > > On Wed, Jul 3, 2013 at 11:37 PM, Tomasz Figa <tomasz.figa@gmail.com>
> > 
> > wrote:
> > > > The examples you pointed are not using Common Clock Framework. See
> > > > Documentation/clk.txt and drivers/clk/ for more information about
> > > > CCF.
> > > > 
> > > > As for s3c24xx, CCF driver for the whole platform is already merged
> > > > for Linux 3.11.
> > > > 
> > > > Best regards,
> > > > Tomasz
> > > 
> > > Thanks TomasZ. I have gone through the docs and was quite confused. I
> > > will have a look at the merge.
> > 
> > Oops. It seems like s3c24xx clk driver is not merged yet. I don't know
> > why I thought it is. Heiko (on CC) has been working on it and I remember
> > seeing some patches from him. Sorry for misinformation.
> 
> the ccf conversion should be ready, but at the time I submitted them, the
> pwm rework [that got rid of the pwm-internal clocks] was still missing.
> 
> At some point in the threads I lost track of its state, did the pwm rework
> make it into 3.11 after all, or is it an early 3.12 change?

of course I forgot the most important thing :-)

There is a big red line between the clocks starting with the s3c2443 and the 
other s3c24xx before it - they have nearly nothing in common. The ccf driver I 
created [0] therefore only provides the clocks for s3c2443, s3c2416 and 
s3c2450, which are very similar.


Heiko

[0] http://patches.sntech.de/projects/linux-kernel/01_mailinglist/s3c2416-
common-clk/
