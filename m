Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 05:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BF12080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 05:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oMda8+vD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t4TC3Jvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BF12080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jl7c4E4vFCbW7bW+9odfhhkUWDlWivmmtfnlEkO817I=; b=oMda8+vDD9UMD/
	+10bBt0SkUUzLKbjWIXFt1vG6x5RqAEGG3HSHsv1YJVqPu/EpA0rnAAa4z6KO0hf+LyfP9eye7TUj
	kLUdGq3VLMEHyJjyfB16H1OIHtGaVgqk75rMI/2KosfOjy+n1qTPcvFZ/CXQTOsP/K3hQIfp9vz6K
	go7+KRkOkwZJBnwx+fA6LK1psSvHo18KRJvPm3pyHFmxM8bQvWf8/1fkOM0b00ebEbMISlKbUebb9
	WAt7/qGQCg9izEHPUCRh1/SXQwhrdSc3CtoIvXkv9O6o46VAJhTpC+RwOhxIY3+8hME6fF2WLxi/0
	+AfJ4nuJFAD3pt9sydbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geCLN-00036d-3I; Tue, 01 Jan 2019 05:11:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geCLL-000353-2j; Tue, 01 Jan 2019 05:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=puE2a/CzPBjvW3mWjmxCphl+JEivMkom0BKMgVhRLtY=; b=t4TC3Jvh0ayIbkx6gSSfXmDLU
 c2koMW0iVkKYnrMESE5fOgvHR4klREO66BiiJ69Dq5AJl+68i8tD2NZMYOYGBeKnZx7MarT64tHbN
 ApVSsR2fgtzYW2cGAc2W0i0dHGT8TXOWak+aALfiqJby5CgLwc2/83j+pepwPvLzsHM/VRoMUXZxT
 SkXK0yRfPYor39WHG8VPaduITXKzfGu/HBNBMjjUh9fBFQUVyP77WpIMkOCBKB0gAnGmoTzxiSqf0
 26wijk97b5q0jUTTUCvNxg9Fz++bif7l/r12EIK/WFofm/iRzCw5wIA11qQrDjuLnjSwVQq2jZsZP
 TNaGe69Ww==;
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geC3P-0006XV-CC; Tue, 01 Jan 2019 04:53:25 +0000
X-UUID: 3e2f305bb08d4058ab5e046c67bcea37-20190101
X-UUID: 3e2f305bb08d4058ab5e046c67bcea37-20190101
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1984185709; Tue, 01 Jan 2019 12:53:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:53:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:53:10 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
Subject: [PATCH 12/13] arm: dts: mediatek: Get rid of mediatek,
 larb for MM nodes
Date: Tue, 1 Jan 2019 12:51:15 +0800
Message-ID: <1546318276-18993-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4300F4DC98DC9A84B545C8CE2F374691E7516EE5F2F246E92314933F406918BD2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_045323_684339_D079BCCE 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After adding device_link between the IOMMU consumer and smi,
the mediatek,larb is unnecessary now.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 1 -
 arch/arm/boot/dts/mt7623.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 180377e..938fa31 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -563,7 +563,6 @@
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
 	};
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index d01bdee..c831398 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -774,7 +774,6 @@
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
 	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
