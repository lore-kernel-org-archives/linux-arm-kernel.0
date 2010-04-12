From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:43:13 +0100
Subject: [RFC,PATCH] arm: use param address to establish params mapping
In-Reply-To: <1270090784.325445.260542527481.1.gpush@pororo>
References: <1270090784.325445.260542527481.1.gpush@pororo>
Message-ID: <20100412184313.GE3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 10:59:44AM +0800, Jeremy Kerr wrote:
> Currently, __create_page_tables assumes that the boot params are within
> the first MB of physical memory, and creates a translation from the kernel
> direct mapping region based on this assumption.
> 
> Rather than guessing, use the atags/params address instead. This also
> means we don't have to rely on PHYS_ADDR to create the mapping.

As we still potentially have boot loaders which don't pass a valid value
in r2, can you please add some protection against random values being
passed rather than assuming that it always contains a valid value?
