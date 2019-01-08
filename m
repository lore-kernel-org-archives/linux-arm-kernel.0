Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B730C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385720827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uthy8Yb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qlw+80rBigqVJfRBYezjwsSm9Of7dH49pA3A8tosjK4=; b=uthy8Yb7GGie3D
	VOFY4qtUz69aryC6DQNOtiDUhLLwA9lrDr+KrSSsY/7TRmqsFzcP/cYNPAwKOgNBmsPrGpwc7dh6g
	4X6VVxHGR7bPmcgyELy1iwXf4gyVrmkYoXO8lBKWVQQ3FOBqomaU1Uv/90pIaAraNwvgTc1x0Q67v
	JIX8Z2lSTEnPa9e0jCE9V6p9UzEIaVAZplFXmfIBgqzuk1z4LMuYNrSFmd6hxuMLK7vumlSzfBTNg
	s63q0WrNCaOR/azEKNWNxW3UrTiC8bjqgLAeIbLF3BSYdCBJJ8lZcpk/Kyh9SBNsq1CuXNS1lbg/9
	oyAIAgazLfmrG1Dy2/iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvem-0007Z6-1v; Tue, 08 Jan 2019 17:59:16 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggveG-0006xx-Ih
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:58:46 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id E819310005D;
 Tue,  8 Jan 2019 18:58:42 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KM3uynEug4gh; Tue,  8 Jan 2019 18:58:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id A8496100053;
 Tue,  8 Jan 2019 18:58:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yraUJQQp2QYp; Tue,  8 Jan 2019 18:58:23 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id E58E6100051;
 Tue,  8 Jan 2019 18:58:22 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
 platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 02/15] dt-bindings: olpc,
 xo1.75-ec: Add OLPC XO-1.75 EC bindings
Date: Tue,  8 Jan 2019 18:58:05 +0100
Message-Id: <20190108175818.705110-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095844_766371_CE9399EE 
X-CRM114-Status: UNSURE (   9.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
signals for handshaking. It needs to know when is the slave (Linux)
side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
controller node) and when does it wish to respond with a command (the
cmd-gpio property).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- s/cmd-gpio/cmd-gpios/
- s/ready-gpio/ready-gpios/ in the documentation paragraph
- Remove status = "okay" from the example

 .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
new file mode 100644
index 000000000000..8c4d649cdd8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
@@ -0,0 +1,23 @@
+OLPC XO-1.75 Embedded Controller
+
+Required properties:
+- compatible: Should be "olpc,xo1.75-ec".
+- cmd-gpios: gpio specifier of the CMD pin
+
+The embedded controller requires the SPI controller driver to signal readiness
+to receive a transfer (that is, when TX FIFO contains the response data) by
+strobing the ACK pin with the ready signal. See the "ready-gpios" property of the
+SSP binding as documented in:
+<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
+
+Example:
+	&ssp3 {
+		spi-slave;
+		ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+		slave {
+			compatible = "olpc,xo1.75-ec";
+			spi-cpha;
+			cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
