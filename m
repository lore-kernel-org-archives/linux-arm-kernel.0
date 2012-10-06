From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 6 Oct 2012 09:03:30 +0200
Subject: [PATCH v3 0/2] ARM: pci: Prepare for Tegra PCIe controller driver
In-Reply-To: <1348127025-29461-1-git-send-email-thierry.reding@avionic-design.de>
References: <1348127025-29461-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20121006070330.GA4842@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 09:43:43AM +0200, Thierry Reding wrote:
> Hi Russell,
> 
> These are two patches I've been carrying in a larger series that
> converts the Tegra PCIe controller driver to a proper platform driver.
> Since the complete series didn't get much feedback, I've begun to post
> smaller subsets in an effort to get them merged more easily.
> 
> The first patch in this series removes the __init annotations from the
> pci_common_init() function (and pcibios_init_hw(), pcibios_swizzle() as
> well as pcibios_init_resources() because they end up being called from
> the former) to make sure that they stay around after the init stage.
> This is required because the Tegra driver depends on regulators that
> become available only very late during boot and uses deferred probing to
> handle this situation. It turned out that this postpones the PCI bus
> initialization until after init, thus this patch.
> 
> The second patch is used to pass per-controller or per-host-bridge data
> to the driver, such that it can be associated with the corresponding
> bus. This is also required by the Tegra driver in order to pass a
> driver-private structure to the PCI bus (or more precisely the
> pci_sys_data structure associated with a bus). It is subsequently used
> to obtain the root port private data given the corresponding PCI bus.
> 
> Note that v3 is pretty much the same as v2, except that it is rebased on
> linux-next and contains the removal of the __init annotation from the
> pcibios_init_resources() function which is only in linux-next.

Hi Russell,

have you had a chance to look at these yet?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121006/cb6f89f7/attachment.sig>
