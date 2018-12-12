Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C593C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3514220839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHALOK5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3514220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oZ9VwwIEA99J8tknM/QRZW2Wa2CnR+aPmhqIRjFts10=; b=JHALOK5UmQyzec
	DkN5u92jb1ryztFX5I0DLNNwIY/5UMLYL4Aixdv38aYpwCUmW5hxjecGcNK+AaKGaZDWhra6Q2K5+
	onWePcykgKm/rk3MzS8DZk8JeoPKKsd3Qkp5YabdbY31vvgJjhaNkGXy57Rs6M8G2FWWQxybQ8Xij
	1P6u1/9GMNau5QF1HiqXFRnsuPms0iTIvKCtdzDOkM2da228YM0PFCoR9ptdgeH/1euQsdkpAiy+8
	GqMhsfPi+F2CyU1PoS84UhIAQ05KJqj4GQRCcnH616bFnBnYPtXE/GWKBgGa3QRsN97pdc8XWFMI0
	bQF6bexAEck6RMXQaAiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0Ci-00088y-JA; Wed, 12 Dec 2018 08:49:16 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0CD-0007gd-Vj
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 08:48:48 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBC8jdo1000815; Wed, 12 Dec 2018 09:48:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p84a3dc6t-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 12 Dec 2018 09:48:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7452938;
 Wed, 12 Dec 2018 08:48:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D3E52761;
 Wed, 12 Dec 2018 08:48:27 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 12 Dec 2018 09:48:26 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
Subject: [PATCH v2 0/3] mfd: syscon: Add optional clock support needed on stm32
Date: Wed, 12 Dec 2018 09:48:12 +0100
Message-ID: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-12_02:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_004846_306596_1E99DCC0 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, gabriel.fernandez@st.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

STM32 syscfg registers are accessed using syscon. It needs syscfg clock
to be enabled while accessing registers.
This adds support for optional clock on syscon, and the relevant clock
in stm32mp157 device tree.

Changes in v2:
- move clocks to specific bindings using syscon as per Rob's comment

Fabrice Gasnier (3):
  dt-bindings: stm32: syscon: add clock support
  mfd: syscon: Add optional clock support
  ARM: dts: stm32: Add clock on stm32mp157c syscfg

 .../devicetree/bindings/arm/stm32/stm32-syscon.txt    |  2 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                    |  1 +
 drivers/mfd/syscon.c                                  | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
