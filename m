From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 12 Oct 2018 14:47:21 +0100
Subject: [RFC PATCH 00/40] Cleanup pci-keystone.c and Add AM654 PCIe
 Support
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20181012134721.GD23257@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 03:51:15PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> in keystone2 with certain modification. Hence AM654 will use the same
> pci wrapper driver pci-keystone.c
> 
> The initial support for AM654 was merged recently [1]
> 
> [1] -> https://lore.kernel.org/lkml/20180626162615.19194-1-nm at ti.com/
> 
> Patch series includes the following
>  *) Merge pci-keystone-dw.c into pci-keystone.c so that we have single
>     file for PCIe keystone driver.
>  *) Cleanup the pci-keystone driver. In certain cases the DT binding is
>     also modified since PCIe in keystone has never worked in mainline
>     due to lack of PHY support.
>  *) Included the PHY driver here for completeness (though the driver
>     might go via linux-phy tree)
>  *) Included the device tree patches here. Once this series is reviewed
>     it'll be sent to be merged via Tony's tree.
>  *) Patch to fix ATU identification for designware version >= 4.80 in
>     designware core is also included here.
> 
> TODO:
>  *) Add Endpoint Support for AM654
>  *) Send a patch to fix the MRRS after the correct value is identified.
> 
> Once this series is reviewed I'll split the series and send to
> corresponding subsytem Maintainers after removing RFC in subject.

Hi Kishon,

I started reviewing the series, I noticed that some patches are
clean-ups that I would like to queue to cut the delta so that you
can rebase on top of them, do you have time to post the clean-up
patches (no functional changes) stand-alone so that I can queue
them up please ?

I think you should drop the RFC tag from this series.

Thanks,
Lorenzo
