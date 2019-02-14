Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B109E2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIDc0dN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B109E2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2wBF1JAWAFcjEqv2gXvPfoGJcCAUcaRW20z34AGwdPk=; b=NIDc0dN5SUtktL
	oLU/zQ1LE97zbA5ifHH6nPrBLT7wgoy1qot1NJGjR+WiI+y/Pm2PpO/ZtoVwcE8d+h9TK05LNl1Bc
	n5mcq97EdcsPnT/DC/HiIndAZzIlLuAtbjNfnbCQFCXYuro+RXehiULwWptPvaE5Rp4EgcZ7BNTBb
	USRaHzgXErzwZdsVfhQuG3eMWiTnihqWzpBNWMjUd83PWSXZ2VBm7oKunkoK6M70zdhyUr5Vjmi0S
	pOcI44a44A/o6Tt5rpXh5AihuMR7x/XGruXxAj3Mae9MEPWIIdh6bbm+8Q0rk0/RYyfy+w22W7Fjq
	K+SCkT+vv/rlQlqZIn2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guERy-0002BT-U7; Thu, 14 Feb 2019 10:41:02 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guERt-00028B-Ka
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:41:00 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EAa01r026777; Thu, 14 Feb 2019 11:40:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsujrje-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 11:40:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21ABA3D;
 Thu, 14 Feb 2019 10:40:51 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03A314EB2;
 Thu, 14 Feb 2019 10:40:51 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 14 Feb 2019 11:40:50 +0100
From: <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 1/7] clk: stm32mp1: parent clocks update
Date: Thu, 14 Feb 2019 11:40:41 +0100
Message-ID: <20190214104047.1173-2-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214104047.1173-1-gabriel.fernandez@st.com>
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_024058_061556_B05BCA6D 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Fixes parent clock for axi, fdcan, sai and adc12 clocks.

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 6a31f7f434ce..be2ed35977ca 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -121,7 +121,7 @@ static const char * const cpu_src[] = {
 };
 
 static const char * const axi_src[] = {
-	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+	"ck_hsi", "ck_hse", "pll2_p"
 };
 
 static const char * const per_src[] = {
@@ -225,19 +225,19 @@ static const char * const usart6_src[] = {
 };
 
 static const char * const fdcan_src[] = {
-	"ck_hse", "pll3_q", "pll4_q"
+	"ck_hse", "pll3_q", "pll4_q", "pll4_r"
 };
 
 static const char * const sai_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
 };
 
 static const char * const sai2_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb", "pll3_r"
 };
 
 static const char * const adc12_src[] = {
-	"pll4_q", "ck_per"
+	"pll4_r", "ck_per", "pll3_q"
 };
 
 static const char * const dsi_src[] = {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
