From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 16 Jan 2017 11:44:22 +0000
Subject: [PATCH] PCI: mvebu: change delay after reset to the PCIe spec
 mandated 100ms
In-Reply-To: <20170116111142.6866-1-l.stach@pengutronix.de>
References: <20170116111142.6866-1-l.stach@pengutronix.de>
Message-ID: <20170116114422.GA25924@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Jan 16, 2017 at 12:11:42PM +0100, Lucas Stach wrote:
> The current default of 20ms cause some devices, which are slow to initialize,
> to not show up during the bus scanning. Change this to the PCIe spec mandated
> 100ms and document this in the DT binding.
> 
> From PCIe base spec rev 3.0, chapter "6.6.1. Conventional Reset":
> 
> "To allow components to perform internal initialization, system software must
> wait a specified minimum period following the end of a Conventional Reset of
> one or more devices before it is permitted to issue Configuration Requests to
> those devices.
> 
> With a Downstream Port that does not support Link speeds greater than
> 5.0 GT/s, software must wait a minimum of 100 ms before sending a
> Configuration Request to the device immediately below that Port."
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 3 ++-
>  drivers/pci/host/pci-mvebu.c                        | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
