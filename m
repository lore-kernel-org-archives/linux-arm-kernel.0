From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Mar 2014 07:50:24 +0100
Subject: [PATCH v6 6/6] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <20140310215600.GA14968@bart.dudau.co.uk>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <1469359.kil5iaOqdU@wuerfel> <20140310215600.GA14968@bart.dudau.co.uk>
Message-ID: <4254618.BlpDUOctDb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 21:56:00 Liviu Dudau wrote:
> 
> PCI_IOBASE is always defined. See the discussion with Russell on this subject.
> 
> include/asm-generic/io.h has at line 118:
> 
> #ifndef PCI_IOBASE
> #define PCI_IOBASE ((void __iomem *) 0)
> #endif

That is only defined for those that use asm-generic/pci.h, which most architectures
don't.
 
> I will go with my idea tomorrow. arm64 overwrite the implementation anyway, I
> find it cleaner rather than having to do #ifdefs and/or ifs.

I'd really hope we can get to a point where arm64 doesn't need any architecture
specific code for this. It doesn't do anything special.

	Arnd
