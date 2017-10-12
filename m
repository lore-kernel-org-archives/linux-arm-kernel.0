From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Oct 2017 15:27:16 -0700
Subject: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
In-Reply-To: <20171012205220.130048-1-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
Message-ID: <CAD=FV=VyERPq9yGE27Uvj6bs4Mru81gZAiqCOP=yQv3ai6-YDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 12, 2017 at 1:52 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi,
>
> This patch series should mostly be self-descriptive, but it's motivated by the
> fact that I've found differing requirements from PCIe endpoint makers regarding
> the state of PERST# when in system suspend (S3). Additionally, some existing
> boards are not especially well suited for holding PERST# low in S3 (e.g., the
> pin is driven by a non-PMU GPIO, so it's hard or impossible to keep it
> asserted). So the solution is...give it a device tree property!
>
> Brian
>
> Brian Norris (3):
>   Documentation/devicetree: Add pcie-reset-suspend property
>   of/pci: Add of_pci_get_pcie_reset_suspend() to parse
>     pcie-reset-suspend
>   PCI: rockchip: Support configuring PERST# state via DT
>
>  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
>  drivers/of/of_pci.c                           | 25 +++++++++++++++++++++++++
>  drivers/pci/host/pcie-rockchip.c              |  7 +++++++
>  include/linux/of_pci.h                        |  7 +++++++
>  4 files changed, 50 insertions(+)

I'm nowhere near an expert on PCIe, but overall the series seems sane
to me.  ...and I'd agree that the discussions I've seen from different
vendors seem to have different opinions about what we should do with
this line in S3.  ...so FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
