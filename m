From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 13:02:38 -0700
Subject: [PATCH] PCI: tegra: replace devm_request_and_ioremap by
 devm_ioremap_resource
In-Reply-To: <1377508269-9664-1-git-send-email-treding@nvidia.com>
References: <1377508269-9664-1-git-send-email-treding@nvidia.com>
Message-ID: <20130829200238.GM18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 11:11:09AM +0200, Thierry Reding wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Use devm_ioremap_resource instead of devm_request_and_ioremap.
> 
> This was done using the semantic patch
> scripts/coccinelle/api/devm_ioremap_resource.cocci
> 
> Error-handling code was manually removed from the associated calls to
> platform_get_resource.
> 
> Adjust the comment at the third platform_get_resource_byname to make clear
> why ioremap is not done at this point.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi,
> 
> This is a small cleanup patch on top of the recently merged Tegra PCIe
> driver. Can someone please apply this to the same branch that Tegra's
> tegra-for-3.12-soc branch was merged? I think Kevin Hilman pulled it
> into next/soc.

Applied. 


-Olof
