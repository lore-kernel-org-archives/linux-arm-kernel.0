Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF1EC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E79D2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DRcZqUXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E79D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=O7Gk/OVVA9nWSA4kyP6lLDEnKQ1JWksBHg8wYDQyG3w=; b=DRcZqUXuWZvA+SW1MY/8RO3tb0
	hXo2b/ZxJg3jc/UmF2EPjauAKy55Nb0i1+5xRhngY8FLcK28oKYlicp8M9Y1MQYUZVMlvHMzVoV1j
	WSPao28DHUqdM17c8WNrEBht9MIC/+Qk48FZRY3vfGqkOU+5RmPb1Y5WaRZMsJ/ntR9zy+4h+qSpY
	L+oS10d3ptjczOHyD+3Tk869/zF7JQ1O2FxRfpSl+c6sG3iyzjImvkuEj29SEelUF8hcM1C9ZcezC
	gGm06fmeBimI/2Wa46APjIiStgQWtTh4tatqY0RcrMZAuCo0PKYsHH0Ks079UnFdBxntrt549fZRL
	J3JNzaSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiT1-0004h9-8Q; Tue, 11 Dec 2018 13:52:55 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiSF-0003ul-VB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:52:14 +0000
Received: from stefan-Vostro-260.fritz.box ([109.104.44.229]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M89TB-1gaJLb0RqF-005EOD; Tue, 11 Dec 2018 14:51:48 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
Date: Tue, 11 Dec 2018 14:51:11 +0100
Message-Id: <1544536273-17909-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:BHXMwhmw5zIjkgRKK+Uqe7fKLSq0cim5fvuzjVnCY6KIkMgTvI4
 Jzhvs32maFXcMwhvz7ChNjIMiApkTvMbPjY4pR73hdQ9+4NbwNjJhX2Ih/sBWbo7obg9raX
 P0v/r+WDhZ1ub9sAyZkGYuFeGuEF8A7oB9OkDVRmQeGP8FmbEu0kC4Qz9DazLEuKdzjhyA2
 QhQKj/EBXL3EB2bLX/o/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pt17kblqpCE=:sIeMS4FK8BDe5XuPCmAohB
 34HxgVGkxwJeAAL2IuQLy8nD5DCQZwEMIrN1++SF5XJxnUccO2hcfzsrjEU+Tbhnvq+3T+B22
 QdH9atiB8mfV3vVL3UixajIKWEgvWkVTDiYx2JNlURIN2afFZcdvMetUCwPf/XvFIRsDCJDR8
 zHaOB19pg/bFCJ7RimmM4RViHOzrAfra1+XtXYJDEtxpPxTbilcAdyzTqOZTK50FOcOh+AsJf
 D+2/65kCGURD7E6bC2yutYiqR0hrw437FxA9FhpM+ONj9jEWj4X2CuYXuAnVr8w8T8ilqwPTp
 0oM+o+ojJvG8RNVge1oX0mrOSXW0/I4lrrtkzCAwalaEkIwmVywjf2tEOObJa6fc5gh8CmHxK
 9c5XGp5U6ibWZdxLmOKNtK4fbT/+FVlp/JY3klvlNwQcNT4VDTPldIPYLRHOE034/TtWbVULM
 bJlp9vuP1oqfTtklXAbqg310aEutDlr9a2JX6nZzWRrZpHRFFZ1Dvy0yxvtYcWi4sFRqFlw5L
 hLf9DnuwPcj/fN/fP2PJ6lsiO6gGQTEm/WCwi/IU2nx5ReQ46jIgIJeiDRnDpYTdW66VGstIc
 +RT4G2LgQM/zvySrZYj3XGZPpcopzP3NnnJHXA4gt2ykb8QnXPq++35Nq85uJB+mVjvaCFHPb
 kk2gNxHQxAen9ED8t4AS+jSLNGI8tUkKIFfBxMrkdGvHl0315RwTZ8eGJYXF7LW5/yFM3htCJ
 itp7Dl0CJIic6GtNUWgUgDbmyHu70DagkM+hgNqcnJcCwIoPdItmb/xcku8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055208_484151_6F6AFB63 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since the i.MX6ULL/ULZ only supports 8 OTP banks we need to introduce a new
compatible.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 792bc5f..455ebbb 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,7 +1,7 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ and i.MX6SLL SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -9,6 +9,7 @@ Required properties:
 	"fsl,imx6sl-ocotp" (i.MX6SL), or
 	"fsl,imx6sx-ocotp" (i.MX6SX),
 	"fsl,imx6ul-ocotp" (i.MX6UL),
+	"fsl,imx6ull-ocotp" (i.MX6ULL/ULZ),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	followed by "syscon".
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
