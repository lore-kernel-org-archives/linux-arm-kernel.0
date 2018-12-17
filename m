Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:22:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1A2205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpisNwMQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p5UpHMHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1A2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LNX2m7/mMLtwSKWMPYG6T6kqr9umQVdo7MOYjgtk+/Q=; b=TpisNwMQV5lNSc
	ukeubGj2aTcgG3DLsWyT4CtqiVfptjnffLgvgXCpzpfTEeWlGcEODE/pftJunYU9cjAd3tNhTFP8i
	XRJUzv+MvQ6SWmb4AtynOw1773jl6i62XCI5Zadm57dtH/7xh1yEKeFEo0We/rKXOKXdn5pbXo/55
	JkK7epswy3k2761q+tCz2nnaKCFHsWBSX/jrPC6JmoXpA+FSppvlAh1Byxl5vIGhdyQhYoHFP2YrN
	1C66bX7QKcv52E79P6YljmU9f5TaYi5bNi+GVPry5uuvJ2FcDvZWt6POWiVnYm9T+V5nZjPAq0pZ2
	49Ri1j5u7Jq1LGfpfxqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYruc-0004CD-Ri; Mon, 17 Dec 2018 12:22:18 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrt1-0002VZ-Nt
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 12:20:46 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCKIpI113159;
 Mon, 17 Dec 2018 06:20:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545049218;
 bh=ScwamW5U4Y+lAKAKE/FPQm7eJ7rIep8x2jRV0p7O2JU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=p5UpHMHxugtqBXypfVWlgEPncS1kpH8c+UE1WNSIvQ5S1cj0dgqnvVDb5yzHLLfO4
 Ry+SphkhTbA65bsdDKl97Ef5pxBBcT20EeciwN+OYrOJQooOVB9n9ymjK1Vda7fNi8
 gizXXvcXBWrMfyEF5fI5XEavIerirudid0QjtmjE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCKIeZ017534
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Dec 2018 06:20:18 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:20:18 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:20:18 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXT023433;
 Mon, 17 Dec 2018 06:20:16 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
Subject: [PATCH 7/9] ARM: omap1_defconfig: Do not select ASoC by default
Date: Mon, 17 Dec 2018 14:21:40 +0200
Message-ID: <20181217122142.6652-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_042041_774829_209E56B7 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

No audio support is enabled by default via ASoC, disable the code as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/omap1_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 72f4bc83f467..cfc00b0961ec 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -175,8 +175,6 @@ CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_VERBOSE_PROCFS is not set
 CONFIG_SND_DUMMY=y
 CONFIG_SND_USB_AUDIO=y
-CONFIG_SND_SOC=y
-CONFIG_SND_OMAP_SOC=y
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_PHY=y
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
