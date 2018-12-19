Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A65FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:47:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD3217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lrTBz7n1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJSfy5Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPADl5wLJUNEv7sTP/uHqGwAgOBouX+rud59xw7ZgQQ=; b=lrTBz7n1C9+5El
	esK1FF/6jwGSISbFEfBtzQMLeKvfoVKjw4ofASVvlqqzAGWCII8wjs9qwBZLgjdIZeo1vwWgC2TrV
	4gn/wOfZr/2Kk4/9GaNrU8zQXLkC720DFSi00ekHNVUE88fVxuYvMDL6M50RDQzoCAwQxQ9TwQZ47
	uiKQ/qS8e/EQHqB+1CqOXBijJa3fAOQzObFs6p3MFju2oy4N7sVJ7xKM+KOqGP3ksvh43vr9psrBG
	QL3/hbCug2KdZ1QqYufKmlZo/wcGeV4qALv/xuC0chZyMZ8DInMljwDkWYskNO46rDfmw6BGMsk8A
	6CGlbMQuLzuhwSu+WJgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaJy-0002BI-BZ; Wed, 19 Dec 2018 11:47:26 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaIZ-00011O-CD
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:46:06 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBjmSi107005;
 Wed, 19 Dec 2018 05:45:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219948;
 bh=4oqBsZmhWzvFSX5OVJcHfhRJvo2kCUuOjpFoLt99PHU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IJSfy5Tq+cyzX8dgstqvEDNzwuFOu6FjdoHnsCQuttH0Q0DgCy1GANP5PQ7nZSmPu
 AwKWD5zZBhR9BmSOSAtlYGjxvUc2MgYRH5BzlZ34juWZnEMaOi9hDzrBHc4xv9lA67
 cNUQmitjWEr+Hrzeb4GPtHZvnerUHBtluiotYkfA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBjmVu130587
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:45:48 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:45:48 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:45:48 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBjfof011774;
 Wed, 19 Dec 2018 05:45:47 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <nsekhar@ti.com>
Subject: [PATCH v2 4/5] ARM: dts: da850-lcdk: Correct the sound card name
Date: Wed, 19 Dec 2018 13:47:26 +0200
Message-ID: <20181219114727.6865-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219114727.6865-1-peter.ujfalusi@ti.com>
References: <20181219114727.6865-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034559_646110_2AD48177 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To avoid  the following error:
asoc-simple-card sound: ASoC: Failed to create card debugfs directory

Which is because the card name contains '/' character, which can not be
used in file or directory names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index c196e37606c4..3a2fa6e035a3 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -71,7 +71,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
+		simple-audio-card,name = "DA850-OMAPL138 LCDK";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
