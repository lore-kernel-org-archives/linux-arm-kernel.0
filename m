From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 03 Mar 2010 17:08:28 -0500 (EST)
Subject: board/device file names, and machine names
In-Reply-To: <20100302235137.GC29715@n2100.arm.linux.org.uk>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<20100302235137.GC29715@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1003031651400.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Mar 2010, Russell King - ARM Linux wrote:

> On Tue, Mar 02, 2010 at 01:29:58PM -0800, Daniel Walker wrote:
> > So one device has at least three names (more I'm sure),
> > 
> > 	Passion
> > 	Mahimahi
> > 	Nexus One
> > 
> > Google has most of the code support under board files with the name
> > mahimahi.
> 
> I see no reason why the internal names can't be used in the code; just
> make the configuration option texts user-friendly so that the common
> names for the devices are used.
> 
> A comment at the top of the file may also help.
> 
> As far as filenames go, let's keep them the same for now; we can rename
> the filenames later once stuff is merged - while git can sort out
> subsequent _merges_ with files renamed, but what it can't do is apply
> patches on top of renamed files.  That's just something to be aware of
> when chosing when to rename.

IMHO using the internal name in the code is the most sensible thing to 
do.  Why? Because marketing people are a very emotional and influential 
bunch, and they often change their mind about naming and (re)branding.

Been there already.  And it also happened that marketing people just 
asked of us developers that the name of the files and functions in the 
source tree be changed to the marketing name du jour.  They especially 
don't want customers to ever notice that the new product out of the shop 
with all those revolutionary features and performances is in fact 
(technically speaking) just a minor revision of the previous product 
which can be supported by the same code as the previous product.  This 
has to be pushed back of course.

While the marketing names do change, normally the internal project names 
are more stable and more easily related to amongst developers.  And if 
there are many internal names, then the most widely used is the best.  
And if one name is already established in the source base then it is 
best to just keep it and not play renaming games unless really necessary 
(e.g. the old name is creating more confusion to _developers_ than if 
things were renamed).

The kernel tree is _not_ a medium for marketing campaign.  Those 
marketing names are best placed in the Kconfig text.  In this case I 
think that mahimahi for the board support is just fine.


Nicolas
