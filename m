From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 21 Mar 2017 12:43:25 -0500
Subject: [PATCH 0/2] ThunderX external PCI fixes for legacy&new ACPI
 firmware
In-Reply-To: <1489564155-3881-1-git-send-email-tn@semihalf.com>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
Message-ID: <20170321174325.GB13150@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 08:49:13AM +0100, Tomasz Nowicki wrote:
> This patch series update ThunderX PEM driver to be able to boot with legacy
> and new ACPI firmware:
> 1. New firmware uses registered Cavium harware ID "CAV", but kernel instead
>    uses "THRX". Fix kernel to use "CAV".
> 2. Legacy firmware misses PEM quirks information so for this case kernel
>    should not assume anything from FW and figure out PEM resources on its own.
> 
> Fix this all together in the following branch:
> git at github.com:semihalf-nowicki-tomasz/linux.git (thunderx-pci-legacy-fw-v1)
> 
> Tomasz Nowicki (2):
>   PCI: Use Cavium assigned hardware ID for ThunderX host controller
>   PCI: Add legacy firmware support for Cavium ThunderX host controller
> 
>  drivers/pci/host/pci-thunder-pem.c | 58 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 3 deletions(-)

Applied with Robert's acks to pci/host-thunder for v4.12, thanks!
