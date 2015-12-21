From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Dec 2015 23:42:18 +0100
Subject: [PATCH V2 22/23] pci,
 acpi: Match PCI config space accessors against platfrom specific
 quirks.
In-Reply-To: <5678370B.1030102@caviumnetworks.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <201512211510.32029.arnd@arndb.de> <5678370B.1030102@caviumnetworks.com>
Message-ID: <201512212342.18960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 December 2015, David Daney wrote:
> On 12/21/2015 06:10 AM, Arnd Bergmann wrote:
> > On Monday 21 December 2015, Gabriele Paoloni wrote:
> 
> > or require the BIOS to work around the hardware
> > quirks differently (e.g. by trapping config space access through secure
> > firmware, or going through an AML method to be defined).
> 
> Some systems don't seem to have this capability.  For example, in ARMv8 
> (A.K.A. arm64), I haven't been able to figure out how to trap these 
> accesses to EL3 for emulation.  The specification is 5700 pages long 
> though, so perhaps I missed that bit.

How about using AML then? This would be similar to what CHRP used with
RTAS calls to do PCI config space access.

	Arnd
