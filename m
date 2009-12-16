From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Dec 2009 17:31:11 +0000
Subject: Enabling DEBUG in head.S file makes the kernel work
In-Reply-To: <OFBC3EDCAB.AF6E2F03-ON65257688.003CA125-65257688.00403272@lntemsys.com>
References: <OFBC3EDCAB.AF6E2F03-ON65257688.003CA125-65257688.00403272@lntemsys.com>
Message-ID: <20091216173111.GA13540@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 05:12:56PM +0530, Virupax.SS at Lntemsys.com wrote:
> I am using Linux 2.6.27 kernel on  at91sam9g20 Controller. The kernel 
> boots fine on all the boards i have here , but on one board kernel does 
> not boot and gives 

Quite possibly your board has bad SDRAM routing.  Enabling debug disables
the cache, and the decompressor without debug seems to be an excellent
test for identifying marginal SDRAM signal quality.

Basically, if you get a CRC error on decompression, it means that the
image was corrupted somehow.  Experience shows that's not the fault of
the code but tends to be hardware weaknesses.
