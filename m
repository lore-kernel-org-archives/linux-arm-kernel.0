Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929AAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633982229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dEfOYBXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633982229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i32TzHNCwUWgZ+TY75O+RbUySDZMyA6RVo4nGZn/eUA=; b=dEfOYBXjMXw3aZ
	YoVuwdGaAiNyZLzK5v7elSpQKdcLRRgzMnHu8AyaVNYOVZCtRBm7hrRdEKAcIBwWOV3jCx4r5l8ry
	ey92jCvzI0PrDsbmblhiSACDr7MGCT2DCkomjJQk2ZRqka6KeWXwJTaDHLwop5sX17A1iEfERVL0N
	UiB/WU7ROAWizpKNbyODyraJoD+q33heRc+Rd8FANV4Hx6r1b2/9htWGbr5zr4vNUrEW8Fs+E/mBJ
	ArThvzK8ZRblW/nJ3VGYWgpN2zIqYV1fWHikaC2XdcUny6DcWZNIIwnw7zXfSB0Yj8fIgcThFp5rW
	S5GC738dehGsievU46vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guESu-0003Aw-L1; Thu, 14 Feb 2019 10:42:00 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guERu-00028d-Hn
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:41:03 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EAa01t026777; Thu, 14 Feb 2019 11:40:52 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsujrjf-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 11:40:52 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0CFB38;
 Thu, 14 Feb 2019 10:40:51 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFF174EB0;
 Thu, 14 Feb 2019 10:40:51 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 14 Feb 2019 11:40:51 +0100
From: <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 2/7] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel
 clocks
Date: Thu, 14 Feb 2019 11:40:42 +0100
Message-ID: <20190214104047.1173-3-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214104047.1173-1-gabriel.fernandez@st.com>
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_024058_882759_5AF1C483 
X-CRM114-Status: GOOD (  10.47  )
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

STM32MP1 clock IP offers lots of Kernel clocks that are shared
by multiple IP's at the same time.
Then boot loader applies a clock tree that allows to use all IP's
at same time and with the maximum of performance.
Not change parents on a change rate on kernel clocks ensures
the integrity of the system.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index be2ed35977ca..e72079de83f4 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1286,10 +1286,11 @@ _clk_stm32_register_composite(struct device *dev,
 	MGATE_MP1(_id, _name, _parent, _flags, _mgate)
 
 #define KCLK(_id, _name, _parents, _flags, _mgate, _mmux)\
-	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE | _flags,\
-		  _MGATE_MP1(_mgate),\
-		  _MMUX(_mmux),\
-		  _NO_DIV)
+	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE |\
+		       CLK_SET_RATE_NO_REPARENT | _flags,\
+		       _MGATE_MP1(_mgate),\
+		       _MMUX(_mmux),\
+		       _NO_DIV)
 
 enum {
 	G_SAI1,
@@ -1952,7 +1953,8 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 	MGATE_MP1(GPU_K, "gpu_k", "pll2_q", 0, G_GPU),
 	MGATE_MP1(DAC12_K, "dac12_k", "ck_lsi", 0, G_DAC12),
 
-	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE,
+	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
 		  _NO_GATE,
 		  _MMUX(M_ETHCK),
 		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
