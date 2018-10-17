From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 17 Oct 2018 15:54:40 +0200
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <CAGkQfmNdp+Si9FseRjjRG4r272kRtu=7MqwHD6OUoRKCinXO-g@mail.gmail.com>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <20181017143849.1240d9bb@bbrezillon>
 <CAGkQfmOOv41vwYtt3rjgC6SmXOkAdASvjWt+YWAksGo-4HqvpQ@mail.gmail.com>
 <20181017150344.40d687d1@bbrezillon>
 <CAGkQfmNdp+Si9FseRjjRG4r272kRtu=7MqwHD6OUoRKCinXO-g@mail.gmail.com>
Message-ID: <20181017155440.10d34743@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 15:36:17 +0200
Romain Izard <romain.izard.pro@gmail.com> wrote:

> Le mer. 17 oct. 2018 ? 15:03, Boris Brezillon <boris.brezillon@bootlin.com>
> a ?crit :
> >
> > On Wed, 17 Oct 2018 14:49:27 +0200 Romain Izard
> > <romain.izard.pro@gmail.com> wrote:
> >  
> > > Le mer. 17 oct. 2018 ? 14:38, Boris Brezillon
> > > <boris.brezillon@bootlin.com> a ?crit :  
> > > >  
> [...]
> > > >
> > > > Is it 2 times slower or 2 times faster with the new approach? Is the
> > > > new calculation providing a working solution, or do you have data
> > > > corruption because of that? Is your NAND ONFI compliant?
> > > >  
> > > - The number of clock cycles for each configured timing is larger, so
> > > the access times are slower.  
> >
> > Okay. When calculating the timings by hand, what was reference freq you
> > used? Did you compare it to the clk freq we have when the NAND controller
> > driver tweaks the timings?
> >  
> I know that I did the calculations with a 83 MHz clock, but that the kernel
> code used a 166 MHz clock instead. The only question is to know whether it
> is me or the existing code that is right.

Actually, if you have a test point on the RE pin, there's an easy way
to know who's right: check the freq on RE and compare it to what you
expect it to be.
