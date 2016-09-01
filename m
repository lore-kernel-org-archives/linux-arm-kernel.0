From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 1 Sep 2016 08:58:42 +0800
Subject: [PATCH v2] arm64:pci: fix the IOV device access config space
 valid condition
In-Reply-To: <1472455618-17892-1-git-send-email-po.liu@nxp.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <1472455618-17892-1-git-send-email-po.liu@nxp.com>
Message-ID: <CAFiDJ5__WC=GeeA2Hg8LSG5xbQGc7frP6KfHfF_QhBm0=-w9Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 3:26 PM, Po Liu <po.liu@nxp.com> wrote:
> When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
> VF devices. A crash log occurred. This found to be access the IOV devices
> config space failure issue.
>
> The read/write config space from host would judge the pcie device plugin
> or not by(Designware platform as example):
>
> if (bus->primary == pp->root_bus_nr && dev > 0)
>     return 0;
>
> Although all PCIe devices for dev(coming from the device and function
> number) is zero. But the dev is not zero for VF devices. So remove the
> condition.
>
> These PCI hosts were changed: designware, altera, xilinx.
>
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---

For pcie-altera.c:
Acked-by: Ley Foon Tan <lftan@altera.com>

Thanks.

Regards
Ley Foon
