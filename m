Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F02E21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+ZZs5bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02E21916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=auKoS2UVpFqt7sGZcVkYQkjWxUDvEL+Ycv7m0csAS3A=; b=N+ZZs5bNKy24uD
	ZuQiHxoab0RsQMkQ/BonjbG89JRoVRKcMyxPPPy1bcVZ3UwEU1DWJqLnahkymGtGKrSMmiK3zTJtC
	EQJ7BWe4a3buWi2OKyIWngAsW3p8RXIdtBUbHxwCzp3jSvc7SabtZKpLNeDX0tD/nmCsOHqGsoAdo
	p7TkRpV6QLc3BsR81OfrFbC+faICVGxS17F2EuLs61W3SXiit2wIso7x7zfpF4pYfU0KzBcwV2kWD
	9lMWk5CHSh7XRVKhnFISQIxY/NKrg7qOt0isuitVtrkSwLZvkhy0QKs6zPfm50wPNwXOB1tvoa0nP
	EEDIbC2eTWuJhfVUAYdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaNvf-0007TI-7i; Fri, 21 Dec 2018 16:45:39 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaNvb-0007Rh-UP
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 16:45:37 +0000
Received: from macchiato.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MQQzk-1gxaBL1FoS-00TmfP; Fri, 21
 Dec 2018 17:45:15 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date: Fri, 21 Dec 2018 17:45:03 +0100
Message-Id: <20181221164503.5128-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Provags-ID: V03:K1:NTsIIujFJRNYukWdFSnzEwLKoB+tAHo8mjNhGy1vmiPMhNrt9yB
 0RV2/cbI8AFWbZeEw/cR3Tx5fgzAtQK/oDQNowpRvsGqJ+90JoEpmTcruX7R8Vhtpy6n6oj
 U3sGGP8Ll9FsIcAVT1NSa0ZdMGsX7M/SS5wNKcXwJYRYn5QwhRCR6bgwpjwQxJAjel9soWQ
 GiFCH9CRO8Gjejs7vAMJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PVgJ3hldQEA=:+XLn2eHOpxnvM1urPXFi16
 Rp3g3T1TN/jEjhE43tMT0huQ7SSuXzJX51aEiNOE9ssqu6FFD9Mi/oKQAFNhtuFybCb1cstVD
 6D6i2gcWmp/n9flRpl5ZEUqJwg7CHRNVUXtAsM1chOGy3IUATcvTzTIl2YOSOyCroPewvnOHZ
 uanUTICmSSeGExkJ4wYtL1VOwoRCWGIaSRxO6EhDTOMOj878nawlgZVzj7vqSgX2qvghywByX
 +w6JkJxpXstkWQGDR8SUAl+9pZPNnxR9Dupch3lSyRp7txbrTa0EGuWEsB95tWdyXf7kp0VAy
 Rxof1wl8mjaW+gR1PonHHmTHWVig19/ePUfIBDKBLVnJCOafeVMBmofMdSQOK/PLm528y5ZUP
 pHuKYnuAuVDV8VGxtkq9AVNoV3wESFxDf0mSpxMH9F7OpqihyxZZoUH0FMHlThyk424Ri4WVL
 4o0FbK+xKsn1IXmCSoh2e9ZkxH5R8baTF9ANbGlFoJ+GGZWi1SYNs8I+baXuxkI6f3gjEg4bN
 JvafrbF6EnAArUEWGiRUFFPVIvq+MTWkalmRyOiRPqAAhZZEWvXetPLr3poj2s63usjW4yMt0
 ssAuT7YjHaP3E2kT0HvaUMd+J1s3e2XtUhwHCzF9ZFBHu54n7xV/jJPT8P7Cyg/ZMV3DSQa7p
 hrfdKm/88dEzQ4Ijj8UwlDQcj11fH1hf2A/fQS3hEyA/XViiyjKj+0oJnx56iiTI1U9SUiB+/
 PPSz4MSoek8uZ7unzg++ehoRuKmfFbyqBaEcAt4Sl8kZX+OLnwDctBBt/So3nvSumgamQg9Ge
 6CU89qDxA0X7k+b7W3zxAUXp7Mq8N4i2/Xo8snXdTVjzjVqFo7vxGjnor5Amsyqt0zyD4kssh
 bIiwUnPdKwdW0jz7PIDuZohnn2H/DHOx8rEFrq6M09i+NJPirWN1W9AnwiQpSi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_084536_280095_9E30FCDA 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
v2
	Move the change from armada-8040-mcbin.dts to armada-ap806.dtsi.
	I only have a MACCHIATObin for testing but
	https://github.com/MarvellEmbeddedProcessors/linux-marvell
	has the reservation in that file.
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7d94c1fa592a..f8dafef83db0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,6 +28,17 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		psci-area@4000000 {
+			reg = <0x0 0x4000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
