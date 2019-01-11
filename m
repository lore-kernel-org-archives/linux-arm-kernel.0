Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62858C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340602177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ik3Ex5Z3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KctG3CVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340602177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jc4SUu9d51QSsbGWl9TD/6Z777V8o5wH33mzbatUsCk=; b=Ik3Ex5Z3ppWpk9
	a85Hz4xaPzAP4QxAji5NJi0bi2BmKR/4/24Bp0xOyFYWJeKGvDyHTTHJNgDo6ou9+e/SJ3WUpwGcZ
	u4NtjC7ScT7DWpA01BdK4tvvRh/wNlg+JiZJNLWDRlIXgJChzutsRhSya90o3G/PpOeE6DqI9QXIv
	431Xe1+xHjIewmQWoVVXvCm0ixuTrJu47C1T7z6JkGu/NQwQjIhmytMv2uNlilMwyiGTBuyvFXdDb
	jkJXUX1xVCFm0f4f+CSOVmkJzDhmqzSwDGL+Jb+wzS8ETbmm6KEV9Pw68eOAlFrMMzwO+332RUjoo
	58HBd+yncLxN1BvT+r9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtck-00059E-13; Fri, 11 Jan 2019 10:01:10 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtch-00058d-64
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:01:08 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BA16D8055892;
 Fri, 11 Jan 2019 04:01:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547200866;
 bh=9jmRLQ4N9I8LaJBdJKtSEAoPPLY+SO0iw7dqQ2Lwyxk=;
 h=From:To:CC:Subject:Date;
 b=KctG3CVW1G1W1aJ5cI/WFxTuLZlNrngs2HPUfabeBf7jCFySIvWZiX74xyrBk2ZO9
 bc00nCzBNz5FfxUZyBD+wRL9hRNglS/Rt99ZqNn0d4GUJ1OEYqeORg8MSQNYN899j7
 M8vsYup8vN6wRe5zYKGytoAqB5FDqeYTkve/YAww=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BA167q052028
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Jan 2019 04:01:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:01:05 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:01:05 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BA12XZ015629;
 Fri, 11 Jan 2019 04:01:03 -0600
From: Roger Quadros <rogerq@ti.com>
To: <t-kristo@ti.com>
Subject: [PATCH 0/3] arm64: ti: k3-am654: USB support
Date: Fri, 11 Jan 2019 12:00:58 +0200
Message-ID: <1547200861-17795-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_020107_264369_DE35B9D1 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The AM654 SoC supports 2 DWC3 USB controller instances. The
AM654 base board supports the 2nd (USB1) instance in high-speed.

This series enables support for USB1 instance on the AM654-base-board.

To test, you need to first apply the below 2 series.

AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html

cheers,
-roger

Jyri Sarha (1):
  arm64: dts: ti: am654: Add Main System Control Module node

Roger Quadros (2):
  arm64: dts: ti: k3-am6: add USB support
  arm64: dts: ti: k3-am654-base-board: enable USB1

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 88 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 20 ++++++
 2 files changed, 108 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
