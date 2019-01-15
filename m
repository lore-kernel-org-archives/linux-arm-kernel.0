Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66361C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:38:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361C320866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="daLDEp91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xEArbmfH5ZparWgfCcST5G6kN91P+OaEGd2xhKPHg24=; b=daLDEp91P904R0
	suyWONmJyVa+IarInBISUv6eeSQx3LZENkhA+r3q4dIAyE/xwvRdytxAvvtvzWsZ+ze0JZey5seMy
	kr4m6Q1m6h3CYTxRe9HS2YC2cVU9co/WA85294dSbY6SaZoEytujJ1dz8Lmj/782p/YTIkbGyNoFE
	HAmfX7qzXr8zA39nQ7Z/nlBDNUqucwV9k1OsaJMvDaOd7r9inRCgKMWSSPziklWfO3yhS51yekhqv
	91Yw5qOeBRNr4nE/dDGeO27fWXO2C8PgAFCz+2aikuzoJhMTe2ZmG/Lrm9V6FeivgFcdUvkbz0mAA
	+ZB0k3KMRcnymeX53gcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQnH-00045L-FE; Tue, 15 Jan 2019 15:38:23 +0000
Received: from mail-sh.amlogic.com ([58.32.228.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQnD-00044F-T8; Tue, 15 Jan 2019 15:38:21 +0000
Received: from localhost.localdomain (10.18.11.217) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Tue, 15 Jan 2019
 23:38:54 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 <linux-mtd@lists.infradead.org>
Subject: [PATCH v9 0/2]  mtd: rawnand: meson: add Amlogic NAND driver support
Date: Tue, 15 Jan 2019 23:38:02 +0800
Message-ID: <1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.18.11.217]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_073819_947185_8C63D2B6 
X-CRM114-Status: GOOD (  12.01  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, devicetree@vger.kernel.org,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.

Changes since V8 at [9]
 - fix build failre at object_is_on_stack
 - update Kconfig as Martin's suggested

Changes since V7 at [8]
 - fix bitflips checking for blank pages
 - trace the latest commit with nand/next branch
 - checking the return of meson_nand_op_get_dma_safe_*input/output*_buf
 - add .detach_chip for free meson_nand.data_buf/info_buf

Changes since V6 at [7]
 - use timings->tBERS_max as the maximum time out, delete NFC_CMD_RB_TIMEOUT
 - fix nand_rw_cmd and support small block flash and which row address less than 3
 - fix coding style
 - replace readl/writel_* with readl/writel_relaxed*
 - delete ECC_SET_PROTECTED_OOB_BYTE and ECC_GET_PROTECTED_OOB_BYTE
 - implement dma access for read_buf and write_buf, more efficient.
 - delete waiting dma finish in write process and let NAND_CMD_PAGEPROG and
RB command go on queuing
 - add waiting the completed flag of last ecc page be set, for more strict

Changes since v5 at [6]:
 - use instr->delay_ns in exec_op() to caculate the delay cycle
 - delete struct meson_nfc_info_format and use macros instead
 - delete "is_scramble" in struct meson_nfc_nand_chip
 - add WARN_ON_ONCE() for chip > MAX_CE_NUM
 - drop param *mtd* or struct *nfc* if param *nand exist
 - substitute set_data_oob and get_data_oob for prase_data_oob and format_data_oob
 - split timings caculating and setting timings
 - move info_buf and data_buf to struct meson_nfc_nand_chip

Changes since v4 at [5]:
 - remove the initial default divider(CLK_DIV_MASK) in meson_nfc_clk_init()
 - dt-bindings: remove staus, add "rx" and "tx" clock, and node rename

Changes since v3 at [4]:
 - remove partition table and some used props from dt-bindings 

Changes since v2 at [3]:
 - remove some hardcode time value, like twb
 - use dev wait R/B instead of nand_soft_waitrdy
 - implement nfc ecc init by ecc helper
 - rework nfc buffer init to register the maximun buffer when several chips
 - free nfc buffer when error and cleanup
 - add variable to teack all the already assigned CS lines
 - fix mtd->name use the first cs line only
 - remove dt "nand-enable-scrambler" and use NAND_NEED_SCRAMBLING instead.
 - move setuping ECC fileds after the identification phase
 - use nand_scan() and attach_chip()
 - check one event to return IRQ_NONE
 - delete cast when of_device_get_match_data
 - use nand_controller_init() helper
 - remove nfc driver complains when calling devm_ioremap_resource
 - clear irqs before setting up irq handler

Changes since v1 at [1]:
 - adopt property amlogic,nand-enable-scrambler - thanks Martin
 - drop nand pins in DT
 - convert clk access to emmc clkc model 
 - fix regiser field definition alignment
 - drop nand-user-mode 
 - parse cs id from DT
 - rework n2m, m2n function
 - explain why insert two "IDLE" command
 - implement exec_op()
 - drop meson_nfc_get_nand_chip_dts()
 - release resource once error occur in meson_nfc_nand_chips_init(), 
 - call nand_cleanup(nand) once mtd_device_register fail

Items not addressed ( or confirmed ) in this version:
 - convert to ECC conf helper() 
 - convert to dma coherent API
 - how to construct mtd->name

[1] https://lkml.kernel.org/r/20180613161314.14894-1-yixun.lan@amlogic.com
[2] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com
[3] https://lkml.kernel.org/r/20180719094612.5833-1-yixun.lan@amlogic.com
[4] https://lkml.kernel.org/r/1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com/
[5] https://lore.kernel.org/r/1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com/
[6] https://lore.kernel.org/r/1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com
[7] https://lore.kernel.org/r/1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com
[8] http://lkml.kernel.org/r/1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com
[9] http://lkml.kernel.org/r/1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com

Liang Yang (2):
  dt-bindings: nand: meson: add Amlogic NAND controller driver
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../devicetree/bindings/mtd/amlogic,meson-nand.txt |   60 +
 drivers/mtd/nand/raw/Kconfig                       |    8 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/meson_nand.c                  | 1468 ++++++++++++++++++++
 4 files changed, 1537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
