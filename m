Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34974C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FCD2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AfuLK7n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FCD2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b0U9G4KGoCbdY7SjtfP5qf4e+8NIDipJeO1uY5b2+go=; b=AfuLK7n1shIdHh
	ml7UnP6aovzUPHxa6JHQ/Z2yNytkPcj+tpVVbT844typvoDeXo9RKyAkm7W4uKCbZhl84Q6pX99ST
	Xduek4vJJDUxs8SEchM7/7RcqIc+qBNQs906cTyjpA2P3bnHwdG7IpYUNWMppYVY+48sug3Aoybwp
	CB6yaUI4xnDiJLdOu5GsOUpENse1PgyXFWA2wyUSrhujM+OzDPJW23ZmxIwxiYDptdxcmEOPMMjTe
	i10T2J1lER1FIxdBNFmIALDWesPIYf84TwRt6CTicRH7C7jv3+D31Pl2nnJZQ2h7KzOcnl5VCGoU4
	3e8eZNV/NIflcnkYJQKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPpn-0005Da-Ew; Fri, 04 Jan 2019 13:48:23 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPpQ-0004pK-Mp
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:48:07 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x04DfFqi026812; Fri, 4 Jan 2019 14:47:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pnxxc0v9n-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 04 Jan 2019 14:47:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A49438;
 Fri,  4 Jan 2019 13:47:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 54037530D;
 Fri,  4 Jan 2019 13:47:58 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019
 14:47:57 +0100
Received: from localhost (10.129.4.161) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019 14:47:57
 +0100
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] mailbox: stm32-ipcc: remove useless device_init_wakeup
 call
Date: Fri, 4 Jan 2019 14:47:48 +0100
Message-ID: <1546609668-6488-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546609668-6488-1-git-send-email-fabien.dessenne@st.com>
References: <1546609668-6488-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.129.4.161]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-04_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_054801_829923_1D3AF8DD 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Benjamin Gaignard <benjamin.gaignard@st.com>,
 Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If the "wakeup-source" property does not exist there is no need to call
device_init_wakeup("false") at probe.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/stm32-ipcc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 7ca8a14..210fe50 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -276,8 +276,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to set wake up irq\n");
 			goto err_init_wkp;
 		}
-	} else {
-		device_init_wakeup(dev, false);
 	}
 
 	/* mailbox controller */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
