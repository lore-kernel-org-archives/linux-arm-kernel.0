Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC93E2237D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5r0drN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC93E2237D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jB0wZmz5KWcm3haz7VXtFICaO97RwGheq6wppK3fbc4=; b=l5r0drN/QhisLJ
	AJPt2GNYgcqrHj3jgIv52E+p/TfiT3BKinQFLZQpgn9TnSplJc3WknLo/SP2lieMUTX0PD1/j2vxX
	7YUpKw7Xc5SUA20ER0NdZM7MSaN3OfV5ZCoS0eYF7rcYbpjzlnUB/Jadi0Os/R2CbjlMGCv4xCFzz
	ZnnCC2fv89gONeS/NE0F+Bw5H6pKVzp+I+U/V1d1dkAK15GRSKkun/rPKa3IYy9cdfqRv1nJjZWhT
	hPQJDj+Hf29+m3TBp6vH9owDl82W93HKkj41ircOVDctfOejCh4Ljqu/6v8hqpPvJ58xhhYGhgYhS
	rJyqeU10dckhAjwGeq8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfqjq-0004Cj-2B; Sat, 05 Jan 2019 18:32:02 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfqjm-0004CD-OJ; Sat, 05 Jan 2019 18:32:00 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id EBDDB100F5C;
 Sun,  6 Jan 2019 03:32:35 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 0/4] Rockchip: the vendor video codec for reference
Date: Sun,  6 Jan 2019 02:31:46 +0800
Message-Id: <20190105183150.20266-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_103158_996023_8836D6CD 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: hverkuil@xs4all.nl, nicolas.dufresne@collabora.com, heiko@sntech.de,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 paul.kocialkowski@bootlin.com, myy@miouyouyou.fr, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Those patches are not for merging, I won't dream on it. As I said in
previous email, this driver is used for checking the status of the other
drivers. I have checked this driver would memory dump, its output looks
well. The reason I didn't use the video output is VOP driver doesn't
work well.

Also I want to offer a reference for those people who want to develop
the V4L2 request API driver for Rockchip and you can use this driver to
comparing the result as well. I should said either the one for sunxi nor
chromium have not reached the vendor production level.

I want to point out the obvious problem of the current V4L2 driver, I
think that is the one I developed years ago and refresh it in the last
year, then it is merged now.

That driver won't aware the parallel problem between the devices. The
video codec in Rockchip is very complex, the decoder and encoder are
NOT paired in some platforms. Also a decoder or encoder can share some
resource with the other decoder or encoder, requesting a mux in the GRF
device. We call those devices sharing resource a combo, they may or may
not having a individual IOMMU for each of its child devices. Also any of
those devies allowing support less codecs than its full state.

The RK3328 is a good example of that,
---------------------------------------------
| Video decoder for H264, VP8, JPEG, MPEG-4 Part 2
| Video decoder for AVS+
|--------------------------------------------
| Video decoder for H265, H265, VP9
|--------------------------------------------
| Video encoder for H265,
---------------------------------------------
| Video encoder for H264, JPEG
---------------------------------------------
that is why I rewrote the device tree files in these patches, the current
device tree is not suitable for the other platforms.

Besides, the V4L2 driver don't support the error correction and tolerance or
status recovery. That is more about the parser in the userspace but a
common parser won't be able to do that, different video codec vendor
would request a different method, also V4L2 request API is not suitable
to feedback status.

Anyway, the current developing for decoder is at lease acceptable for
those simple situations. But I think encoder would become a big issue,
lucky, it seems that nobody care about encoder. If you have ever looked
the video encoder for chromium, you would feel disgusted, it is not
Google's fault, just not suitable for V4L2.

I don't want to talk much about encoder here, basially the encoder is
much simpler than decoder requesting less dynamic settings, but those
dynamic settings request a more real time feedback or related.

I don't see much advantage the V4L2 brings, only the compatibility left.
The previous vendor driver would have DMA buffer problem but it is
solved in this one. Ndufresne told me about buffer fencing, but I don't
think it is useful only complication. That is why I didn't develop the
V4L2 for a long time.

I would attend the FOSDEM 2019, if you have any problem, I think you can
catch me easily there.

Randy Li (4):
  staging: video: rockchip: video codec for vendor API
  staging: video: rockchip: fixup for upstream
  staging: video: rockchip: add video codec
  arm64: dts: rockchip: add video codec for rk3399

 .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  29 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  68 +-
 drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/rockchip-mpp/Kconfig          |  52 +
 drivers/staging/rockchip-mpp/Makefile         |  16 +
 drivers/staging/rockchip-mpp/mpp_debug.h      |  87 ++
 drivers/staging/rockchip-mpp/mpp_dev_common.c | 971 ++++++++++++++++++
 drivers/staging/rockchip-mpp/mpp_dev_common.h | 219 ++++
 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c | 855 +++++++++++++++
 drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c  | 614 +++++++++++
 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  | 576 +++++++++++
 drivers/staging/rockchip-mpp/mpp_dev_vepu1.c  | 480 +++++++++
 drivers/staging/rockchip-mpp/mpp_dev_vepu2.c  | 477 +++++++++
 drivers/staging/rockchip-mpp/mpp_iommu_dma.c  | 292 ++++++
 drivers/staging/rockchip-mpp/mpp_iommu_dma.h  |  42 +
 drivers/staging/rockchip-mpp/mpp_service.c    | 197 ++++
 drivers/staging/rockchip-mpp/mpp_service.h    |  38 +
 include/uapi/video/rk_vpu_service.h           | 101 ++
 19 files changed, 5110 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/rockchip-mpp/Kconfig
 create mode 100644 drivers/staging/rockchip-mpp/Makefile
 create mode 100644 drivers/staging/rockchip-mpp/mpp_debug.h
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.h
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vepu1.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vepu2.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_iommu_dma.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_iommu_dma.h
 create mode 100644 drivers/staging/rockchip-mpp/mpp_service.c
 create mode 100644 drivers/staging/rockchip-mpp/mpp_service.h
 create mode 100644 include/uapi/video/rk_vpu_service.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
