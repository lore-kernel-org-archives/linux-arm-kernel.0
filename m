From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 24 May 2011 20:44:57 -0400 (EDT)
Subject: [PATCH v6 00/18] ARM: Add support for the Large Physical Address
	Extensions
In-Reply-To: <8yapqn7fyab.fsf@huya.qualcomm.com>
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
	<8yapqn7fyab.fsf@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1105242042340.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 May 2011, David Brown wrote:

> On Tue, May 24 2011, Catalin Marinas wrote:
> 
> > This set of patches adds support for the Large Physical Extensions on
> > the ARM architecture (available with the Cortex-A15 processor). LPAE
> > comes with a 3-level page table format (compared to 2-level for the
> > classic one), allowing up to 40-bit physical address space.
> 
> Do you expect non LPAE targets to be able to boot with these changes
> applied (and LPAE enabled)?  I am able to build this tree for the
> MSM8660 (with a minor patch below), but it fails to boot with LPAE
> enabled.  It seems to work fine with LPAE not enabled.

I wouldn't expect a LPAE kernel to boot on non LPAE capable hardware.

And I don't think we'll ever try to support both LPAE and non-LPAE modes 
in the same kernel binary either since this has implications all over 
the place in core kernel mm code.


Nicolas
