From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 8 Feb 2017 17:27:31 +0530
Subject: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
In-Reply-To: <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
Message-ID: <CAFp+6iEtFetHY6FEAYD2Ymjr+BKyVKjaum_F8v4e8wapnFcK8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Feb 6, 2017 at 2:43 PM, Peter Chen <peter.chen@nxp.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> For xhci-hcd platform device, all the DMA parameters are not
> configured properly, notably dma ops for dwc3 devices. So, set
> the dma for xhci from sysdev. sysdev is pointing to device that
> is known to the system firmware or hardware.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Tested-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---

This patch doesn't work for me anymore on db820c target [1].
While the same kernel with reverts of patches [2] [3] and an older
patch [4] by Grygorii Strashko works [5].

[1] https://github.com/vivekgautam1/linux/tree/linux-v4.10-rc7-usb-db820c-nonworking
[2] 8c9f2de459c7 usb: dwc3: Do not set dma coherent mask
[3] d64ff406e51e usb: dwc3: use bus->sysdev for DMA configuration
[4] https://lkml.org/lkml/2016/4/25/813
[5] https://github.com/vivekgautam1/linux/tree/linux-v4.10-rc7-usb-db820c


regards
Vivek

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
