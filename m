From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Aug 2016 18:06:33 +0200
Subject: [PATCH 0/3] pcie-designware: support for external MSI controller
In-Reply-To: <000c01d202d5$a3809bd0$ea81d370$@gmail.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160830172447.65d10772@free-electrons.com>
 <000c01d202d5$a3809bd0$ea81d370$@gmail.com>
Message-ID: <20160830180633.67d6479d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Aug 2016 11:46:13 -0400, Jingoo Han wrote:

> > Please discard this patch series, it's just pure crap. No changes at all
> > are needed on the pcie-designware driver, using the msi-parent property
> > already works, and my new code does nothing good.
> > 
> > The of_pci_find_msi_chip_by_node() API is on its way to being removed, and
> > it doesn't return anything useful.
> > 
> > Only PATCH 3/3 is needed, which I'll resubmit separately.
> > 
> > Sorry for the noise.  
> 
> Oh, good.
> The support for External MSI controller is really necessary.
> Thank you for your patch!

Well, no change in the driver is needed to use an external MSI
controller. Just specify:

	msi-parent = <&....>

in the DT description of your Designware PCIe controller. And that's
it. I've tested it with the GIC v2m MSI controller on an ARM64
platform, and it works as expected.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
