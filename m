From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 15 Jul 2014 17:09:22 -0600
Subject: [PATCH 0/2] Fix GPL v2 license string typos
In-Reply-To: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CAErSpo4nVjnu_fmFa1M5eZmu+fFfb=xcyd2meHYZ=JkAs2qzuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 4:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Thierry posted similar patches for tegra and mvebu.  These change the rest
> of the occurrences in drivers/pci from:
>
>   -MODULE_LICENSE("GPLv2");
>   +MODULE_LICENSE("GPL v2");

I should have done the research earlier, but the relevant code that
checks these strings is license_is_gpl_compatible().  That looks for
"GPL v2" but not "GPLv2".

> ---
>
> Bjorn Helgaas (2):
>       PCI: generic: Fix GPL v2 license string typo
>       PCI: rcar: Fix GPL v2 license string typo
>
>
>  drivers/pci/host/pci-host-generic.c |    2 +-
>  drivers/pci/host/pcie-rcar.c        |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
