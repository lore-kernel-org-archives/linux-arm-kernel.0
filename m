From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 3 Feb 2017 15:07:40 -0600
Subject: [PATCH 1 0/4] PCI: Use of_device_get_match_data() to simplify
 probe
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170203210740.GC24162@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 02:19:51PM -0600, Bjorn Helgaas wrote:
> This turned into much ado about nothing, but Shailendra's hisi patch
> prompted similar cleanups in other drivers.  It's a minor simplification,
> but I think worth doing consistently across drivers.
> 
> Basically this is Geert's observation that when the driver probe function
> is called only as a result of matching something in <match_table>, a
> subsequent of_match_device(<match_table>, dev) call should never fail.
> 
> Therefore, instead of this:
> 
>   struct of_device_id *match;
> 
>   match = of_match_device(<match_table>, dev);
>   ... = match->data;
> 
> we can do this:
> 
>   ... = of_device_get_match_data(dev);
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: iproc: Use of_device_get_match_data() to simplify probe
>       PCI: layerscape: Use of_device_get_match_data() to simplify probe
>       PCI: rcar: Use of_device_get_match_data() to simplify probe
> 
> Shailendra Verma (1):
>       PCI: hisi: Use of_device_get_match_data() to simplify probe
> 
> 
>  drivers/pci/host/pci-layerscape.c      |    7 +------
>  drivers/pci/host/pcie-hisi.c           |    8 +++-----
>  drivers/pci/host/pcie-iproc-platform.c |    7 +------
>  drivers/pci/host/pcie-rcar.c           |    7 +------
>  4 files changed, 6 insertions(+), 23 deletions(-)

I applied these to pci/host-layerscape, pci/host-hisi, pci/host-iproc,
pci/host-rcar for v4.11.
