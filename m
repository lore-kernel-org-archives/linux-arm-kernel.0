From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 26 May 2014 09:47:55 +0200
Subject: [PATCH 00/11] sdio wifi oob irq support for sunxi
Message-ID: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a patch series adding support for oob irqs for the ap6210 sdio wifi
modules found on various Allwinner A20 boards.

A lot of it is ground work which should be useful for adding oob irq support
to other sdio wifi models too.

The first 5 patches are sunxi pinctrl patches and should go upstream through
the pinctrl tree.

Patch 6 adds generic support for having per sdio function child nodes in
devicetree and should go upstream through the mmc tree.

Patch 7 and 8 add oob irq support to the brcmfmac driver. Patch 9 pokes some
magic bits needed to enable the oob irq, this was taken from an android code
dump and good do with a good review from someone from Broadcom, Arend ?

Patch 10 and 11 add the necessary dts bits to actually enable the sdio irq
and should go upstream through Maxime's dt tree.

Please review / merge.

Thanks & Regards,

Hans
