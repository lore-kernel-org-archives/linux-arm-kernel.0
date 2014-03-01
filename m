From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 01 Mar 2014 19:25:37 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <11174980.YJ21cfsHoG@wuerfel>
References: <20140226183454.GA14639@cbox> <20140226214843.GD12169@bivouac.
 eciton.net> <alpine.DEB.2.02.1402271229370.31489@kaball.uk.xensource.com> <
 11174980.YJ21cfsHoG@wuerfel>
Message-ID: <20140301192537.3B2AAC40951@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014 15:00:44 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 27 February 2014 12:31:55 Stefano Stabellini wrote:
> > On Wed, 26 Feb 2014, Leif Lindholm wrote:
> > > > >   no FDT.  In this case, the VM implementation must provide ACPI, and
> > > > >   the OS must be able to locate the ACPI root pointer through the UEFI
> > > > >   system table.
> > > > > 
> > > > > For more information about the arm and arm64 boot conventions, see
> > > > > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > > > > Linux kernel source tree.
> > > > > 
> > > > > For more information about UEFI and ACPI booting, see [4] and [5].
> > > > 
> > > > What's the point of having ACPI in a virtual machine? You wouldn't
> > > > need to abstract any of the hardware in AML since you already know
> > > > what the virtual hardware is, so I can't see how this would help
> > > > anyone.
> > > 
> > > The point is that if we need to share any real hw then we need to use
> > > whatever the host has.
> 
> I would be more comfortable defining in the spec that you cannot share
> hardware at all. Obviously that doesn't stop anyone from actually
> sharing hardware with the guest, but at that point it would become
> noncompliant with this spec, with the consequence that you couldn't
> expect a compliant guest image to run on that hardware, but that is
> exactly something we can't guarantee anyway because we don't know
> what drivers might be needed.

I don't think this spec should say *anything* about sharing hardware.
This spec is about producing portable disk images. Assigning hardware
into guests is rather orthogonal to whether or not hardware is assigned.

g.
