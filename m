From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 06 May 2014 16:37:05 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <5367AE6B.3010105@ahsoftware.de>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <97692EF2-013E-4E4B-BC16-E0915D67EFEC@antoniou-consulting.com>
 <53673866.9000105@ahsoftware.de> <69387177.zGLDjZS0ln@wuerfel>
 <5367AE6B.3010105@ahsoftware.de>
Message-ID: <20140506153705.75C55C40A19@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 May 2014 17:29:47 +0200, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 05.05.2014 16:41, schrieb Arnd Bergmann:
> > On Monday 05 May 2014 09:06:14 Alexander Holler wrote:
> >>
> >> A bit late (I don't follow the ML (or what happens in the ARM world)
> >> closely, but as I've recently read that ARM64 will go UEFI and ACPI, I
> >> wonder what was the reasoning behind that decision.
> >>
> >> Does anyone really assume we will become high quality UEFI and ACPI
> >> blobs from vendors? And such with reasonable support/update periods?
> >>
> >> For me that sounds like someone asked dreamers and was unable to adjust
> >> those answers in regard to reality.
> >
> > Where did you read that? It's simply not true and we should make sure
> > people stop spreading dangerous misinformation.
> 
> I've recently read Grant Likely's blog entry about armv8 servers: 
> http://www.secretlab.ca/archives/27 (I've read the disclaimer too ;) )

The purpose of that blog post was to address the questions around ARM
server architecture requirements including ACPI and UEFI, but there is a
big gap between the requrement and what actually works now. ARM server
hardware is going to be available well before UEFI and ACPI
(especially ACPI) infrastructure has stablized. I was trying to lay a
roadmap that acknowledges the gap and provides a way for vendors to ship
hardware now that is supported by the mainline kernel.

The constraints that are driving all of this on servers simply don't
exist on embedded and mobile. There really is zero advantage to using
ACPI if the only OS that will ever run on the device is Linux.

g.
