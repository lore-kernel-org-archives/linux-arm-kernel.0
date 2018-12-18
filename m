Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9A7218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s5XNmcZb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nzxK8FpG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hZgW6HDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A7218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=boZ/oy45U6mAIMPzCw8N8MGP8CqQpx+HknO9cvKTXlE=; b=s5XNmcZbuJ2PknNTpmZeXCL60Q
	EBZgOLpENQo0rfWNPoKWChiaAtQMHxghB8Gn4cB3cD3elxYoWOYGm7VUhB9nXLr5Ueqlynga1ZQyV
	ZnVgPsI4HwDbtrZi2TaZy7dB4pQ14mQhqRAORfkIVSijBv44iPIXkt0BuE1Lz+eNX/EAX9lRa6Rlh
	ioVUgKG67+vWM6TURD+KhqjqNH5jRY4UbdJEko1DpM3AYX55Np3rcA7aJXwMZA2ThBBZHngxDuBJy
	dnF7EL5jkQmLRUrufRe8oightvdCtxVXCKbd+2DDUCZDfheCc3+n/J95Y1aPgvz3FxdPwTd4LOJmK
	FTaRfhvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKB1-00088A-Q8; Tue, 18 Dec 2018 18:33:07 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAr-0007zP-9s
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:32:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3CC5960988; Tue, 18 Dec 2018 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157972;
 bh=gt3J4qcxB1NPTcmug6XE2wr/P3ia2VK4eblTfEVxR8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nzxK8FpGCJKl+fec3mAZv+XuAYVC048OKhsrOz5FWVKTWhuq5RBOpHhaYIKeKs0AV
 KkqZOq63LG8x6rCkzaEIg2UK4eAbF5hfgKN+gwvpIMuZoP6r35EkR2hn+UoAba8DIj
 yciolc9j6kADT/UVmLcahWW9Rk2i34FrBHDMRBAM=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B925460988;
 Tue, 18 Dec 2018 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157969;
 bh=gt3J4qcxB1NPTcmug6XE2wr/P3ia2VK4eblTfEVxR8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hZgW6HDUzD08IG8R4h1iWzPaZkRM0wWqHx3TirirEJ+RQhW6Bb4lQKA1n9rV6As9I
 TKkTB8M7PpRkcA3cfFYHST0xZQbpVMS6l0Pl7fphyfDL+pAvlpwS+amBPnLfi0n/MO
 auJM2/zB9cqEDpdpwJyj2cwbJkmr7euOxnUSXDI4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B925460988
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 3/6] ARM: dts: qcom: Removed unused interrupt-names from
 GPU node
Date: Tue, 18 Dec 2018 11:32:38 -0700
Message-Id: <20181218183241.12830-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103257_389760_9BF52633 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

'interrupt-names' shouldn't be used in cases when there is only
one interrupt and it is not otherwise used in the driver.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 48c3cf427610..0a9862729c80 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1186,7 +1186,6 @@
 			reg = <0x04300000 0x20000>;
 			reg-names = "kgsl_3d0_reg_memory";
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "kgsl_3d0_irq";
 			clock-names =
 			    "core_clk",
 			    "iface_clk",
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
