From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 20 Mar 2017 10:20:56 -0700
Subject: [PATCH v6 0/4] i.MX7 PCI support
In-Reply-To: <20170320070930.GB11325@b29396-OptiPlex-7040>
References: <20170314151827.31248-1-andrew.smirnov@gmail.com>
 <20170320070930.GB11325@b29396-OptiPlex-7040>
Message-ID: <CAHQ1cqGRc8HU52uuoycDOEesLBOCLChJEjZj2PtB+4Nket_jiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:09 AM, Dong Aisheng <dongas86@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 08:18:23AM -0700, Andrey Smirnov wrote:
>> Hello, everyone:
>>
>> This is a sixth iteration of the code that adds PCI-subsystem bits
>> necessary for enabling PCI support on i.MX7.
>>
>
> ....
>
>> Andrey Smirnov (4):
>>   PCI: imx6: Add code to support i.MX7D
>>   PCI: imx6: Do not wait for speed change on i.MX7
>>   PCI: imx6: Do not switch speed if Gen2 is disabled
>>   PCI: imx6: Allow probe deferal by reset GPIO
>>
>>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
>>  drivers/pci/host/pci-imx6.c                        | 199 +++++++++++++++------
>
> Can't apply and test it.

Sorry about that. I'll rebase the set and submit it as v7.

>
> The directory has been changed to drivers/pci/host/dwc/pci-imx6.c
> since the commit below:
> commit 950bf6388bc22c2749b8b66c501df1462639d6bd
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Fri Jan 6 18:22:48 2017 +0530
>
>     PCI: Move DesignWare IP support to new drivers/pci/dwc/ directory
>
>     Group all the PCI drivers that use DesignWare core in dwc directory.
>     dwc IP is capable of operating in both host mode and device mode and
>     keeping it inside the *host* directory is misleading.
>
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Jingoo Han <jingoohan1@gmail.com>
>     Acked-By: Joao Pinto <jpinto@synopsys.com>
>
> Regards
> Dong Aisheng
>
>>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>>  3 files changed, 161 insertions(+), 55 deletions(-)
>>
>
>
>> --
>> 2.9.3
>>
