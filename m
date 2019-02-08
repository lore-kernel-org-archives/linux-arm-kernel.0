Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90846C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:37:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC022177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCro9fjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC022177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8ctHlCnGk4GG2lH3vb0rp43bRUPTwOYTSFNDdbGgdPo=; b=sCr
	o9fjk6Nc6NKbbp0CTvi9iUnMSlq7rjM8rIruCojmOW7IUErL9O2msXuKhAjoWE/WvfFiSkwjtUslK
	IQoFZNcsk9wiMVDk4wEb1VKXLGwAy363jnOpjkpr9vSOmdmtZ4teywYeYf5TxURP9o/8c6k5AFpCQ
	I9dKzrJu8MtTzNQi7iS+smm75OCqSkpeq7TFnarH2Tc0y4shh30P4W81SokqVOfwez4J3NpvvsgGZ
	to/ItWSoAjIH1j+IP9UevaKhhyUyAufn2F4N9QFhs1KgXXQycqbJ3VG6I6tPcpUHMKfjern5FpkFb
	6GEDarViMLIFDukoVz6McAtjaS7SNUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5PM-0007GD-35; Fri, 08 Feb 2019 12:37:28 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5EA-0007Ub-BA
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:26:16 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:25:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8B115180D62;
 Fri,  8 Feb 2019 21:25:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:25:53 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 355291A04E1;
 Fri,  8 Feb 2019 21:25:53 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 1DC471202F1;
 Fri,  8 Feb 2019 21:25:53 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/15] dt-bindings: timer: Add Milbeaut M10V timer
 description
Date: Fri,  8 Feb 2019 21:26:30 +0900
Message-Id: <1549628790-30960-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042554_675804_6A403081 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT bindings document for Milbeaut M10V timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
new file mode 100644
index 0000000..ac44c4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
@@ -0,0 +1,17 @@
+Milbeaut SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "socionext,milbeaut-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer.
+- clocks: phandle to the input clk.
+
+Example:
+
+timer {
+	compatible = "socionext,milbeaut-timer";
+	reg = <0x1e000050 0x20>
+	interrupts = <0 91 4>;
+	clocks = <&clk 4>;
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
