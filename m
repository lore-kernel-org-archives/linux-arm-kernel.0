Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66129C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:41:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iO16DXvF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TLzx7xXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FHD6uG/Vcqc3wddzLfiVJ6/PUmH6eoD2h9ppTAVs2ic=; b=iO16DXvFT5iEqB
	cVuy5xpjmO/ykh7IXHQDFmn6DZpgE0a1nKlKVKgLDkL+uYcyCSUEtdQgoCXzSwTEin/8Cs2D0IZz2
	4Do+nmWmV+UMBP1gQZhF1OdnqHF17oJwoxzeCU+n6Ta3U0ugekzWmb4qF0pqaMY+ivh4l3H+y2Xqg
	XxPujNzbcX3ic72VGT6O/5XlitJL1y811o9EJcjhcyAFnNquFHWLkaUjPldv9wsCO+CwbXUz+cYtd
	Mf4KZ8PUrioXy4qRJmrJijbPgyRsG9+Z9LkldysJylNXgellxDPqlTSzewMSCnBSAQ6DLbykyvdlQ
	4w2edFXpCVrshVRKOV9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4BL-0005ML-Ir; Thu, 17 Jan 2019 09:41:51 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4BI-0005Lz-6c
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:41:49 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0H9fh5f062984;
 Thu, 17 Jan 2019 03:41:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547718103;
 bh=9ygFf4OXVBsj8xE1aTi2XkN4gkyfhsqwPkjNFjdaLCg=;
 h=From:To:CC:Subject:Date;
 b=TLzx7xXHiGUNvw+gbFAdP8zL3VTS70rL7mI9FbOK6B26Do0cUpRCMiYxuaUDSgYpg
 rNi+r6iJ8+Tn2xXNBi2d9hK/vLJxLCTpjyOQkpUhc5zKySgc4kesUOXIbPPY4BAejj
 x6/r1zogiGfgIVgwlafa92RgXwjCXJqthKU1jI4A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0H9fgcP042219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 03:41:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 03:41:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 03:41:42 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0H9fdIj016863;
 Thu, 17 Jan 2019 03:41:40 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/2] Support for eMMC in AM65x-evm
Date: Thu, 17 Jan 2019 15:14:22 +0530
Message-ID: <20190117094424.7683-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_014148_324716_44BECF91 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: mark.rutland@arm.com, nm@ti.com, robh+dt@kernel.org, t-kristo@ti.com,
 faiz_abbas@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patches add eMMC support on TI's AM65x-evm.

v3:
 1. Fixed patch titles to only include eMMC
 2. Added dma-coherent to the sdhci0 node.

v2:
 1. The SD card node is under debug for some usecases.
    Only upstreaming eMMC support for now.
 2. Rebased to latest mainline.
 3. Removed status = "disabled" from dtsi patch
 4. Fixed node name to not include '_'s

Faiz Abbas (2):
  arm64: dts: ti: k3-am654: Add Support for eMMC host controller
  arm64: dts: ti: k3-am654-base-board: Add eMMC Support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 14 +++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
