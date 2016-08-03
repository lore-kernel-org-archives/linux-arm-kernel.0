From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Wed, 3 Aug 2016 14:39:00 +0100
Subject: Support for configurable PCIe endpoint
In-Reply-To: <57A18927.9070003@ti.com>
References: <57A18927.9070003@ti.com>
Message-ID: <7c696488-eb78-d6d9-dc70-49fa5b4e3317@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 8/3/2016 7:03 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> The PCIe controller present in TI's DRA7 SoC is capable of operating either in
> Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core). I'd
> assume most of the PCIe controllers on other platforms that use Designware core
> should also be capable to operate in endpoint mode. But linux kernel right now
> supports only RC mode.
> 
> PCIe endpoint support discussion came up briefly before [1] but it was felt the
> practical use case will find firmware more suitable and endpoint support in
> kernel can be used only for validation or demo.
> 
> *) Modify platform driver to support EP mode (in my case pci-dra7xx.c).
> 
> *) dt binding specific to EP mode should be created.
> 
> Once I complete the implementation and start posting RFC patches, a lot of
> these will become clear. But I want to check if this sounds okay to you guys
> before starting the implementation.
> 
> Let me know if you have some other ideas too.
> 
> Cheers
> Kishon
> 
> [1] -> http://www.spinics.net/lists/linux-pci/msg26026.html
> 

You are rising a topic that we are also addressing in Synopsys.

For the PCIe RC hardware validation we are currently using the standard
pcie-designware and pcie-designware-plat drivers.

For the Endpoint we have to use an internal software package. Its main purpose
is to initialize the IP registers, eDMA channels and make data transfer to prove
that the everything is working properly. This is done in 2 levels, a custom
driver built and loaded and an application that makes some ioctl to the driver
executing some interesting functions to check the Endpoint status and make some
data exchange.

We are very interest in the subject and we are available to participate in the
development.

I would suggest that also the IP eDMA initialization and manipulation be
included in the framework and maybe produce a standard tool to test the endpoint.

Thanks
Joao
