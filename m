From: greg@kroah.com (Greg KH)
Date: Tue, 27 Oct 2009 09:57:50 -0700
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <20091027081921.GG5019@elf.ucw.cz>
References: <20091022091333.GA31023@elf.ucw.cz>
	<20091026234332.GB26583@kroah.com>
	<20091027001702.GA5019@elf.ucw.cz>
	<20091027030039.GA6195@kroah.com>
	<20091027081921.GG5019@elf.ucw.cz>
Message-ID: <20091027165750.GA24477@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2009 at 09:19:21AM +0100, Pavel Machek wrote:
> On Mon 2009-10-26 20:00:39, Greg KH wrote:
> > On Tue, Oct 27, 2009 at 01:17:03AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > This adds generic_gpio and pmem support, both are needed for other
> > > > > dream drivers.
> > > > > 
> > > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > > 
> > > > I'd prefer to get the existing code building, before adding new stuff :(
> > > 
> > > Well, unfortunately other pieces depend on these.
> > 
> > The pieces already in the tree? 
> 
> Yes :-(.
> 
> > Why are you sending me patches that do
> > not build?
> 
> I did not realize how much was those drivers depenend on arch-specific part.
> 
> > > I have it building with this patch (but note that it uses -I magic; I
> > > started to write script rewriting files so that -I is not neccessary,
> > > but I did not have time to finish it yet).
> > 
> > Ok, should I just delete the whole drivers/staging/dream/ directory as
> > there seems no goal to get this to build properly?  I've just marked the
> > code as BROKEN, any chance to get it building again soon?
> 
> Could we perhaps use -I to let it build before I find time to do
> search&replace of 100 #includes? Yes, I'm working on that, but no, it
> obviously does not progress as fast as I expected...
> 
> 								Pavel
> 
> Add missing files/includes neccessary for Dream compilation.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Ick, no.  I'm not going to take the wakelock and other header files that
are "generic" to android into the dream subdir.  That's not ok.

If this code requires this mess to build, I think we should just delete
the whole thing and start over with patches that add code that can
actually build properly.

Any objection to that?

thanks,

greg k-h
