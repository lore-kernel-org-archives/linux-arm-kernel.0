From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Mon, 25 Jan 2010 10:32:16 +0000
Subject: Default machine include placements
In-Reply-To: <20100125100546.GA16340@n2100.arm.linux.org.uk>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
Message-ID: <20100125103216.GB5772@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:05:47AM +0000, Russell King - ARM Linux wrote:
> > The first question is about adding include/mach directories to
> > eitehr plat-s5p or plat-samsung to mop up the files that keep
> > getting repeated (since the plat-* directories are processed after
> > the machine directory includes the mach-xxx are still free to overide
> > these as necessary)
> > 
> > The second question is whether some of these files should have defaults
> > in arch/arm/include? I think this might be less useful as build failures
> > for new ports ensure that at-least these files are thought about
> 
> No - doing this means it's harder to find out what's going on.  Rather
> than being able to look in arch/arm/mach-*/include for the relevant
> mach header file and know you've got the right one, you have to instead
> consider whether the one you're using is the one found in
> arch/arm/mach-*/include/mach, arch/arm/plat-*/include/mach or
> arch/arm/include/mach.
> 
> Having multiple places where include files can live is a nightmare; you
> only have to look at glibc to know that - where you have to search the
> entire source looking for the header file you want.

As a suggestion; how about one of symbolic links; or headers of the form:

/* arch/arm/mach-s5pc100/include/mach/foo.h
 *
 */

#include <plat-samsung/include/mach/generic-foo.h>

?

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
