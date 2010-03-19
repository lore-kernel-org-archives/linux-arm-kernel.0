From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Mar 2010 13:59:28 -0400 (EDT)
Subject: Highmem issues with MMC filesystem
In-Reply-To: <20100319132750.GE21280@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003181205020.31128@xanadu.home>
	<20100319015523.GD14108@shareable.org>
	<alpine.LFD.2.00.1003190908330.31128@xanadu.home>
	<20100319132750.GE21280@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:

> On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> > And in this case, the same SATA driver is used on two different system, 
> > one being ARMv5 with absolutely no issues with highmem, and the other 
> > being ARMv6 with highmem problems.  So that pretty much rules out IDE 
> > driver bugs.
> 
> No it doesn't - there's more changes between ARMv5 and ARMv6 than just
> the cache model.  There's weak memory ordering effects too.

Sure.  But at the moment we have:

 - ARMv5 without highmem -> works

 - ARMv5 with highmem -> works

 - ARMv6 without highmem -> works

 - ARMv6 with highmem -> fails

In all four cases the SATA driver, the hard disk and the filesystem on 
it are identical.  In the two ARMv5 cases the system and the kernel are 
identical.  Ditto for the two ARMv6 cases.

And the kernel used is the very latest i.e. v2.6.34-rc1-1642-gfc7f99c.


Nicolas
