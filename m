Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:21:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC9C21908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cKi9lVi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC9C21908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=L/OcOFXSno+/hG94fRh3N1/oWXAtKuExex4SkaqGpdU=; b=cKi9lVi+IlAmSa+xrBb9lWPJ+F
	5oD4mq0IA3h9yzDHfkdr1PRaksUl1Qe0yQEoJmtlh7CHG6uAv8qnpNjAgK5dsN8zKdFjyX6ZFypdV
	ZcPBa9fG8ev5O8S2kbSxdqg9eeNSBH67+nZKy8LPhxVUGX1barlofDpFznVzdmIOEdERe7qodfmzt
	xahRkWhmNTw75N8VAvqBfbJ9B8uQjACPiJWda/7ZCftl/S5ofte/p+ny2V/z5z+4aBlo/TiJ3Gjv6
	Duk5H7ORjJgnjIsJnA5UCawWvEqO/8DuHki3ggHFV3lrnsqs6N+qOnwuOnAgAomfymf8KzZtQyBnO
	E7LQuYIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga8ZK-0007Nr-Ck; Fri, 21 Dec 2018 00:21:34 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga8ZH-0007MH-9C
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 00:21:32 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2018 16:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; d="scan'208";a="112251085"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 16:21:21 -0800
From: thor.thayer@linux.intel.com
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 dinguyen@kernel.org, arnd@arndb.de, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will.deacon@arm.com, peppe.cavallaro@st.com,
 alexandre.torgue@st.com, joabreu@synopsys.com
Subject: [PATCHv2 2/6] Documentation: dt: socfpga: Add S10 System Manager
 binding
Date: Thu, 20 Dec 2018 18:23:18 -0600
Message-Id: <1545351802-4354-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_162131_376093_0E3A82D8 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, olof@lixom.net, mcoquelin.stm32@gmail.com,
 mchehab+samsung@kernel.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree bindings for the Stratix10 System Manager.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  New compatible string and usage for Stratix10
---
 .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
index f4d04a067282..82edbaaa3f85 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
@@ -11,3 +11,15 @@ Example:
 		reg = <0xffd08000 0x1000>;
 		cpu1-start-addr = <0xffd080c4>;
 	};
+
+ARM64 - Stratix10
+Required properties:
+- compatible : "altr,sys-mgr-s10"
+- reg : Should contain 1 register range(address and length)
+        for system manager register.
+
+Example:
+	 sysmgr@ffd12000 {
+		compatible = "altr,sys-mgr-s10";
+		reg = <0xffd12000 0x228>;
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
