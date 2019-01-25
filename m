Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:54:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322EA218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fS0jXeWH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mJqUj6Fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322EA218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Jj6yNE9R6+NY9zviVsJFThQ8i4QDKoXqgIjYRljdG/w=; b=fS0jXeWH9R0ZGRbGrLtYuTRByK
	6/5U/lDB7MqG/eu6shwW1O9KlHf+dzxps/9c6LCHpxBkYYvpoKUUD/bxZ97XNrVIMH5FDjOKqXXc3
	OtB90ezQQdTfWLKPunO8gDPMVd96P11ptQbe/YsOvAyfcwLSVV4mZw0Nntj5dadWFVeKrKg8yjfOZ
	Hu6L7OOB4+tvXAMiPRgzF3e8v2bsb0VwrCtaoX/+O5vRZFuLK+LYSNNnihvz+nSFvvxb9uGJirL7W
	sNWJvUxZRyhqE32+mCEUvd8kXUsPQi5EfgSF6w/mERbYqFIN+MVMtpgbQ/1/G4U9iCepr68xA5BLG
	3ibeb1vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvO6-0000op-6x; Fri, 25 Jan 2019 06:54:50 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvO2-0000oR-9o
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:54:48 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x0P6sNWp014857;
 Fri, 25 Jan 2019 15:54:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0P6sNWp014857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548399266;
 bh=PzesMvB7iVXqa+zKaWBiL5i327PsGVECtcZjeWDDDyQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mJqUj6Fuyw6P/cc1PDpJ/S/k1Qa+PCwARq9gPHLLgURSIOeFTIod25K/+g7m7QOWZ
 MD7cia77PUls8xAHTydMSOpRAQoAn3+YO7bIeHRNnZt57J++ZcMfsmd/I1xRe1XhWz
 uKjGI3zSEBU4/oUf2GcrhEadq7HIIiJr5Ga2SO5oiNva2ovEgjHzYzLzJOl5wRJRCI
 vGEaq+kj97zPrvY4O/y+rwCVbisSngd0ETN8nDaRyWz2JfrL24XYhPSyrgdlFzWurX
 j/6QoCoW4AWDRDR9wHW6Uc12T+H/JLdEkf+NpvJvpwmnNQplRdb/35IRtwv3maIJk/
 FiX2H7zyrGH8A==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH 2/3] media: remove unneeded header search paths
Date: Fri, 25 Jan 2019 15:54:18 +0900
Message-Id: <1548399259-17750-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_225446_566822_5A9A99E7 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
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
Cc: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
 Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I was able to build without these extra header search paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/media/dvb-frontends/cxd2880/Makefile  | 2 --
 drivers/media/pci/bt8xx/Makefile              | 1 -
 drivers/media/platform/sti/c8sectpfe/Makefile | 1 -
 drivers/media/radio/Makefile                  | 2 --
 drivers/media/spi/Makefile                    | 2 --
 drivers/media/usb/cx231xx/Makefile            | 1 -
 drivers/media/usb/usbvision/Makefile          | 2 --
 7 files changed, 11 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2880/Makefile b/drivers/media/dvb-frontends/cxd2880/Makefile
index c6baa4c..646598b 100644
--- a/drivers/media/dvb-frontends/cxd2880/Makefile
+++ b/drivers/media/dvb-frontends/cxd2880/Makefile
@@ -14,5 +14,3 @@ cxd2880-objs := cxd2880_common.o \
 		cxd2880_top.o
 
 obj-$(CONFIG_DVB_CXD2880) += cxd2880.o
-
-ccflags-y += -Idrivers/media/dvb-frontends
diff --git a/drivers/media/pci/bt8xx/Makefile b/drivers/media/pci/bt8xx/Makefile
index 7f1c3be..0b5032c 100644
--- a/drivers/media/pci/bt8xx/Makefile
+++ b/drivers/media/pci/bt8xx/Makefile
@@ -7,5 +7,4 @@ obj-$(CONFIG_VIDEO_BT848) += bttv.o
 obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o dst_ca.o
 
 ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/common
 ccflags-y += -Idrivers/media/tuners
diff --git a/drivers/media/platform/sti/c8sectpfe/Makefile b/drivers/media/platform/sti/c8sectpfe/Makefile
index 34d6947..4bf0c6b 100644
--- a/drivers/media/platform/sti/c8sectpfe/Makefile
+++ b/drivers/media/platform/sti/c8sectpfe/Makefile
@@ -4,6 +4,5 @@ c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o \
 
 obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o
 
-ccflags-y += -Idrivers/media/common
 ccflags-y += -Idrivers/media/dvb-frontends/
 ccflags-y += -Idrivers/media/tuners/
diff --git a/drivers/media/radio/Makefile b/drivers/media/radio/Makefile
index 37e6e82..53c7ae1 100644
--- a/drivers/media/radio/Makefile
+++ b/drivers/media/radio/Makefile
@@ -36,5 +36,3 @@ obj-$(CONFIG_RADIO_TEA575X) += tea575x.o
 obj-$(CONFIG_USB_RAREMONO) += radio-raremono.o
 
 shark2-objs := radio-shark2.o radio-tea5777.o
-
-ccflags-y += -Isound
diff --git a/drivers/media/spi/Makefile b/drivers/media/spi/Makefile
index 9e53677..c254e2a 100644
--- a/drivers/media/spi/Makefile
+++ b/drivers/media/spi/Makefile
@@ -1,6 +1,4 @@
 obj-$(CONFIG_VIDEO_GS1662) += gs1662.o
 obj-$(CONFIG_CXD2880_SPI_DRV) += cxd2880-spi.o
 
-ccflags-y += -Idrivers/media/dvb-core
-ccflags-y += -Idrivers/media/dvb-frontends
 ccflags-y += -Idrivers/media/dvb-frontends/cxd2880
diff --git a/drivers/media/usb/cx231xx/Makefile b/drivers/media/usb/cx231xx/Makefile
index c023d97..af824fd 100644
--- a/drivers/media/usb/cx231xx/Makefile
+++ b/drivers/media/usb/cx231xx/Makefile
@@ -11,4 +11,3 @@ obj-$(CONFIG_VIDEO_CX231XX_DVB) += cx231xx-dvb.o
 
 ccflags-y += -Idrivers/media/tuners
 ccflags-y += -Idrivers/media/dvb-frontends
-ccflags-y += -Idrivers/media/usb/dvb-usb
diff --git a/drivers/media/usb/usbvision/Makefile b/drivers/media/usb/usbvision/Makefile
index 494d030..e8e5eda 100644
--- a/drivers/media/usb/usbvision/Makefile
+++ b/drivers/media/usb/usbvision/Makefile
@@ -1,5 +1,3 @@
 usbvision-objs  := usbvision-core.o usbvision-video.o usbvision-i2c.o usbvision-cards.o
 
 obj-$(CONFIG_VIDEO_USBVISION) += usbvision.o
-
-ccflags-y += -Idrivers/media/tuners
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
