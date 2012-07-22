From: robherring2@gmail.com (Rob Herring)
Date: Sun, 22 Jul 2012 13:09:30 -0000
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <201207212156.43941.arnd@arndb.de>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <5005A8A4.6040608@gmail.com>
 <20120721143122.GA26790@mudshark.cambridge.arm.com>
 <201207212156.43941.arnd@arndb.de>
Message-ID: <CAL_JsqJmN3+1Gb5dF+9eL5c742_-mzg61VcvYhEQpabh5VE=kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 21, 2012 5:56 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
> On Saturday 21 July 2012, Will Deacon wrote:
> > Hi Rob,
> >
> > On Tue, Jul 17, 2012 at 07:02:12PM +0100, Rob Herring wrote:
> > > On 07/17/2012 12:04 PM, Will Deacon wrote:
> > > > On Sat, Jul 14, 2012 at 10:49:47PM +0100, Linus Walleij wrote:
> > > >> I think the PCI bus on my Integrator/AP is tilted and not suitable
> > > >> for tests. But IIRC Will Deacon actually has one of these machines
> > > >> and managed to get ethernet going on it. Maybe he can even test
> > > >> this patch?
> > > >
> > > > I can try digging out my integrator at the weekend if you like. Are
these
> > > > patches sitting in a branch anywhere that I can grab?
> > > >
> > >
> > > git://sources.calxeda.com/kernel/linux.git io-cleanup-pci
> >
> > I dusted off the integrator, but I'm failing to boot at all if I build
from
> > that branch:
> >
> >       Uncompressing Linux... done, booting the kernel.
> >       <silence>
> >
> > Using the same .config, I can boot v3.5-rc7 just fine (I even rebased
your
> > branch onto that in case something had been fixed in mainline, but it
made
> > no difference).
>
> I've looked at integrator_defconfig, and could not find any code that
> actually uses the PIO accessors. Is your configuration different to that?
> Do you actually have PCI enabled and present on the machine? Do things
> change if you turn PCI off?
>

Could be overlapping static mappings. I manually checked that, but may have
missed something.

Can you turn on earlyprintk?

Rob
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120722/d40637a6/attachment-0001.html>
