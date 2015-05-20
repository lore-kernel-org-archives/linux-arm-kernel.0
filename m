From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 20 May 2015 07:27:30 +0200
Subject: [PATCH 2/2] PCI: iproc: add bcma pcie driver
In-Reply-To: <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
 <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rxfKT5+LEDHq+QgPuSgX5t-HpOfX93pfnHRXX1_cGy3+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2015 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver adds support for the PCIe 2.0 controller found on the bcma
> bus. This controller can be found on (mostly) all Broadcom BCM470X /
> BCM5301X ARM SoCs.
>
> The driver found in the Broadcom SDK does some more stuff, like setting
> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
> PHY changes like "improving" the PCIe jitter and doing some special
> initializations for the 3rd PCIe port.
>
> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
> connected to them.
>
> PCI_DOMAINS is needed by this driver, because normally there is more
> than one PCIe controller and without PCI_DOMAINS only the first
> controller gets registered.
> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafa? Mi?ecki <zajec5@gmail.com>
