Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26586C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F2E2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyLVJG2E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lhk4SJHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F2E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6uHsZ0LWP/NuQic3w+wGom4W/TyGuZeRK/dAZmw2i0Y=; b=EyLVJG2EkoSwk6l8J8oqLuIOpt
	GbQyvtJZzf52iFOpth70xreIpuwEs88MVTzw9jHmCt8NzlStKYNLhQTqPI8MAVq2LWWnLDQYWXhsY
	35uSjakE0+dJxg/q5qPJs6hAqwNjcYk3l1oU+tF2RtpBUSNesTYjsjsIHUUjMuoPVJTypeK+nlsah
	idjz6U7RRAA+qid8zF6YENQy4+78oMYmxyNT98UQJ1AY7h2ZON3A9dtkQHMuYXeSLvEOIhGjXmOXP
	2+XI/nKQchbC6mSwzL/Roy4W9Ji4YhHi2gJhl1odn6ci9dqO4p45Fa4N0j3nHXSb68Sa+bt30iggy
	7lwf03mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnVO-0000Er-6F; Mon, 04 Feb 2019 23:18:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnTf-0006yO-1O
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:17:04 +0000
Received: by mail-pl1-x641.google.com with SMTP id k15so641484pls.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
 b=Lhk4SJHGMVCTJNkmhvcQ2wIuWaIz+qdkitt8K/xRLjtgx4zHnzR9eyohdgDEdkCbm2
 6jQXqkwwddBP1i8Bkuql6peKqWro1cJQ/ZRQRfpuWFv6geXXdWu7QbVfa+Dst//R9tfW
 +aUfqdqZWa9uBA/SjuJ65oWg1ixqWmURv9vrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gd56skZROQuoUVaN4sNpxlterBec6i5NZQ5F4gBEN3E=;
 b=KkPEErljOoaeGSTWWB0n8uq/iSH0ZooOmjHYMyZbxXRxUx9CRjSmWA0UvV4MqH235V
 00c5ZBaGmMMPDj0JUJpWtou9Z+IHVvZ9QNxzrrC6eFiec4q1EP+iSvp0Xs/ti6ZgGtQq
 cAe7VgS+LD6PSGP8JpAQjxyDG10zEOqkAM1XfYQmXISSmZZxZfrKe2v1aLfVICS6rE6U
 dOicglVIfbBdxku25L7+fFMX0erMNXn9wvpysojrLkzR/Z1892D5RIfMQRvwAoABYSsT
 c+cpGErrbBCGIULtLi025SMObo6xHr9225kCGG/z5rRgDO5ukBrqcUtwpPabSouaobm8
 cO3g==
X-Gm-Message-State: AHQUAuY/Vyn4llTJI3PODXlRAjXYBDXQoSbnbba1ocdveBmOs/uqgH34
 y19wTfBwh16ZZuIYFwglMgVbOg==
X-Google-Smtp-Source: AHgI3IaBcN+lpY9VGFpQ0JPcjcMhkEp0YQzWYYHqGg5NTQQ18M23bDd9+SMaINsjiLZUVqAXDB4QBg==
X-Received: by 2002:a17:902:6b49:: with SMTP id
 g9mr1914061plt.98.1549322194366; 
 Mon, 04 Feb 2019 15:16:34 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:16:33 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 8/8] arm64: dts: Stingray: Add NIC i2c device node
Date: Mon,  4 Feb 2019 15:15:54 -0800
Message-Id: <20190204231554.87666-9-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_151635_909113_697396B6 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC i2c device node.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa855bd05..67e53768a84a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,22 @@
 			status = "disabled";
 		};
 	};
+
+	nic-hsls {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0  0x0 0x7fffffff>;
+
+		nic_i2c0: i2c@60826100 {
+			compatible = "brcm,iproc-nic-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x60826100 0x100>,
+			      <0x60e00408 0x1000>;
+			brcm,ape-hsls-addr-mask = <0x03400000>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
