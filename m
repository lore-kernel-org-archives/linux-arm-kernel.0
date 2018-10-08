From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 8 Oct 2018 16:30:06 -0500
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <20181008212021.GB4440@sirena.org.uk>
References: <E1g9cV0-0008Sg-4U@optimist> <20181008212021.GB4440@sirena.org.uk>
Message-ID: <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:20:21PM +0100, Mark Brown wrote:
> On Mon, Oct 08, 2018 at 09:51:30PM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm allmodconfig caused by:
> 
> > 	arm-allmodconfig
> > ../drivers/pci/pcie/aer_inject.c:444:6: error: 'struct pt_regs' has no member named 'ip'
> 
> introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
> hooks).  This field is not present on arm.

I dropped e3fbcc7c4b130 and related patches already, so this should be gone
in my current "next" branch (18b4baa4d9fc).
