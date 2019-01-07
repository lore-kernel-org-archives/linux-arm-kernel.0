Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2682C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A642147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CxoSzqPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A642147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JlY71dLuNqpLcyMhJfdl38ND2qIJmsuJkOYFglPJ15Y=; b=CxoSzqPfpwuloQ
	2F2M3g12Fjt6lrpoj5d/Nc3IoDr3r1xUAWnmCwR6RwGX4DIMRifnaECEJqwldDzUw3ZkPIUz1UDFI
	smLX47aRujv+wjUjwy1Qd13ltMFXlntNICug/T1gnXFzN5WkoGuLzbW/nuYeO1eKDUmmB0kCOpH4N
	oIAylPo3hM4bITWBUp1lIQlCJXPdCek80QaiRvIVb40StaOp5Sz89pVIR9XtmQu2xMl/otDK3NaR5
	QUoherKaNIvMlxPmUNbNF7V03RvC1BKB9NTjRBZsvCf9AS1P9tSmpRbNLAgSvx+NThcgZF5KoZoi7
	2E+mNXUwgLnqy/ojkZhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggSio-0003EB-HW; Mon, 07 Jan 2019 11:05:30 +0000
Received: from [38.106.11.25] (helo=barracuda02.hxt-semitech.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggSik-0003D4-5W
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 11:05:28 +0000
X-ASG-Debug-ID: 1546859115-107606139f13a0f0001-tbGyMd
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by
 barracuda02.hxt-semitech.com with ESMTP id CClb3yycb8dJZdIy (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Mon, 07 Jan 2019 19:05:15 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from openbmc001.localdomain (10.5.21.169) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:05:09 +0800
From: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v2 3/4] dts: dps650ab: add dps650ab device tree
Date: Mon, 7 Jan 2019 19:05:02 +0800
X-ASG-Orig-Subj: [PATCH v2 3/4] dts: dps650ab: add dps650ab device tree
Message-ID: <081a2f0f05bc92e67771f8103032c42d5fb5ffbb.1546851856.git.xiaoting.liu@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
X-Originating-IP: [10.5.21.169]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546859115
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1413
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65266
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_030526_421800_4AA48923 
X-CRM114-Status: UNSURE (   7.25  )
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
Cc: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>, devicetree@vger.kernel.org,
 shunyong.yang@hxt-semitech.com, linux-aspeed@lists.ozlabs.org,
 dongsheng.wang@hxt-semitech.com, andrew@aj.id.au, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, joel@jms.id.au,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add dps650ab device tree to support power supply dps650ab driver

Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
---
 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
index bdfd8c9f3a7c..e7e59da6c9ae 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -173,6 +173,16 @@
                        };
                };
        };
+
+       dps650ab@58 {
+               compatible = "dps650ab";
+               reg = <0x58>;
+       };
+
+       dps650ab@59 {
+               compatible = "dps650ab";
+               reg = <0x59>;
+       };
 };

 &i2c9 {
--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
