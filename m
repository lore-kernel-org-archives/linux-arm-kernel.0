Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E6221736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lkt9UDGm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4WIVSFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E6221736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rzRA4A07yHtaVEvtalGcuqAOKqb9mfBLaPifVopMkQ4=; b=Lkt9UDGmHct/Qa
	9ehCIqItHtlD/VxkBkMtx1KZMHCKnEaG2eDzK+uQmGHxM+SN/4fxYGA8E651CJGPV8t63hOiV+mpY
	FjMs3LBqrSx6ezsVMuH1Y3OGOnAAl5mNkPZ61SvUYWO7amEuNkgY3AEWzg7ll31u86KbD4TKOgTaD
	/W3bOkxJdw+k+QEyxGggGL+SsgCnaQh5u/rxm+Hl4Y/d8smAHcoB1e5uJypTH2lExu4GUrWE710Bw
	5QyvSQ8C+Odc2av4AKVaR0Nq7PPaWxfhKm4AV91fUPXGYCBW1Q9YNgXN7Obk9WRSTXPCtTfslMGFy
	LaKzO2KH5VAJkmz4FytQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk1n-0007UJ-Gk; Mon, 18 Feb 2019 14:36:15 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk1j-0007TS-Ti
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:36:13 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IEa4Qi033508;
 Mon, 18 Feb 2019 08:36:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550500564;
 bh=6vYqoDu2rMkL5jTn2vFvyKesd0NRV9A/2dnW3TyKlaU=;
 h=From:To:CC:Subject:Date;
 b=s4WIVSFWhzTEP00QwIOQ1JsXZKmxjqmHwNovSqMycWf40w5X+RCdyn+DEqNchE6b4
 3vII7c3eEi/w15xLEK3F9z1aR5IdvGzYafuk8HUETAxc1OAyyxSy6njHx7tTpjH9B/
 eaToCTobPF9RFluXRfXPjp3L3C15EXUqCcwk2U5U=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IEa4Mo109748
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 08:36:04 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 08:36:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 08:36:04 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IEa1dq009865;
 Mon, 18 Feb 2019 08:36:01 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>
Subject: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Date: Mon, 18 Feb 2019 16:36:27 +0200
Message-ID: <20190218143629.28392-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063611_997702_B1486CA7 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com,
 vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com,
 niklas.cassel@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke the
ethernet networking on evmsk (and most likely on the evm as well):
https://patchwork.ozlabs.org/patch/1028527/

v1 patch to fix the situation:
https://patchwork.ozlabs.org/patch/1040617/

It turned out that the at803x driver is actually broken and need to be fixed
along with the DT data.

The following series is proposed to fix the driver:
https://patchwork.ozlabs.org/project/netdev/list/?series=92611

but the PHT mode needs to be switched to rgmii-id from rgmii-txid:
The rx delay is enabled by default and the driver never disabled it so when
asking rgmii-txid it actually got rgmii-id.

The patch can be backported to stable, I have tested that it is not causing
regression with the old, broken driver.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
  ARM: dts: am335x-evm: Fix PHY mode for ethernet

 arch/arm/boot/dts/am335x-evm.dts   | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
