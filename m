From: weitway@gmail.com (Jason Chen)
Date: Mon, 25 Apr 2011 21:37:24 +0800
Subject: [PATCH 1/7] Add a mfd IPUv3 driver
In-Reply-To: <33F32152BE7EC740BC2C838D2836AC8710F6F9@039-SN1MPN1-002.039d.mgd.msft.net>
References: <33F32152BE7EC740BC2C838D2836AC8710F6F9@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <BANLkTin_Gpx5XNmygbUR_fhqxnf=-pFkWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Add a mfd IPUv3 driver

    The IPU is the Image Processing Unit found on i.MX51/53 SoCs. It
    features several units for image processing, this patch adds support
    for the units needed for Framebuffer support, namely:

    - Display Controller (dc)
    - Display Interface (di)
    - Display Multi Fifo Controller (dmfc)
    - Display Processor (dp)
    - Image DMA Controller (idmac)

    This patch is based on the Freescale driver, but follows a different
    approach. The Freescale code implements logical idmac channels and
    the handling of the subunits is hidden in common idmac code pathes
    in big switch/case statements. This patch instead just provides code
    and resource management for the different subunits. The user, in this
    case the framebuffer driver, decides how the different units play
    together.

    The IPU has other units missing in this patch:

    - CMOS Sensor Interface (csi)
    - Video Deinterlacer (vdi)
    - Sensor Multi FIFO Controler (smfc)
    - Image Converter (ic)
    - Image Rotator (irt)

    So expect more files to come in this directory.

    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
    Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
    Signed-off-by: Jason Chen <Jason.Chen@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Add-a-mfd-IPUv3-driver.patch.gz
Type: application/x-gzip
Size: 22782 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110425/7557b931/attachment-0001.gz>
