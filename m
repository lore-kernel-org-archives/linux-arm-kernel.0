Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3CC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ED1218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okogr4Tq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lQuQ1NVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ED1218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GNku3DlP2bKz8SmU0EUimC4YO018wpEa14tYZ3CoYgA=; b=okogr4Tq2gJnFNlpcZdGrInZcF
	pGDEoE1v+4mTgTtqdY2hK3ZhGjaQitsvdzxHJioEu56QMGb5CU4eUYh4a0sR3ZOgSurH3WMo2BNls
	gYHpGqUFzIQe4O6KK5vmTjtcK5QPpxbF8xC9FyjN0bZgE5kldL4n7OjrezplrH3Ar/rZha5+OJ0zL
	YJBhJ+10FI6g4aZvILDfcnTvWDVchnkLM2My15jJBk6PfMQV2mRNA/CyKlZ8qbUsHcw0KDS0p1aSN
	7dWNwpvQ79DtICLEdcig3hv0zwtxT2Zna1CQA10/6lRXEu8Y5MA082pHJsty67DC7Pu/D9lsPDf3S
	13ynCwaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpW0z-0002rt-EY; Fri, 01 Feb 2019 10:25:41 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpW0w-0002r3-3Y
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 10:25:39 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x11APYKw043456;
 Fri, 1 Feb 2019 04:25:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549016734;
 bh=GU/8MTnpz3vwwXK8Ahdp9UBC/Gv1ZNVt2b4fkkbNsKU=;
 h=To:CC:From:Subject:Date;
 b=lQuQ1NVzR1jXVgJDXbsOJq4VmD0Nh3cEUnJhsU4XudXHT0shb/jDoAbnDe/JIQwC6
 UIZMhHrVaD/P79lEB7GTsR0jKtQGzcHy/kw/Y2ULheDD9FE3kjCa1ku0s6jfJAGbfF
 NnK0+Wg/5vPgQDjcHyHjucKi3AE4mazNveYHjusk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x11APXOL007709
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Feb 2019 04:25:33 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 04:25:33 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 04:25:33 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x11APUmA012018;
 Fri, 1 Feb 2019 04:25:31 -0600
To: <arm@kernel.org>
From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] arm64: dts: TI AM65x changes for v5.1
Message-ID: <7a019c48-b470-1897-44de-a63642e7717c@ti.com>
Date: Fri, 1 Feb 2019 12:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_022538_204828_73C680A2 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: Nishanth Menon <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>,
 Faiz Abbas <faiz_abbas@ti.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull these DT changes for TI AM65x SoC for v5.1 merge window.

Thanks,
Tero

---

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux 
tags/am654-for-v5.1

for you to fetch changes up to fd58466a3876ddaed2773556fef616159e5c3844:

   arm64: dts: ti: k3-am654-base-board: Add eMMC Support (2019-02-01 
10:18:33 +0200)

----------------------------------------------------------------
AM65x DT changes for v5.1. Includes:

- EMMC support for am654-evm board

----------------------------------------------------------------
Faiz Abbas (2):
       arm64: dts: ti: k3-am654: Add Support for eMMC host controller
       arm64: dts: ti: k3-am654-base-board: Add eMMC Support

  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 14 ++++++++++++++
  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 25 
+++++++++++++++++++++++++
  2 files changed, 39 insertions(+)
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
