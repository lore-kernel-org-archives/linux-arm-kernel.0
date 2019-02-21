Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2DFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E3720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BaQRPsmh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s/MwN8fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E3720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d5v2aEv02+xIiZCqW0rFxH5u10rYqNd/Liqbyf7Cd9Y=; b=BaQRPsmhDF/vKG
	6SJsij8nQntPcHPWX2TAEw47kRGo1VvcFR1JXfHAPDZzR9V/IH1QV7t935GkJcZK9FEXve0rm+XGE
	Mj2BB1ToLYZqkhefSkqSHyU1gjCxAKMUdyo9d31uEfZk8Ec8k2oOXLKk8bT0e4/6qDFfd5zHwR6km
	4kCNHPQSuDdSJh7FH+rGH7f1RTxIuhWTN/oFyVL7IVkMmKeh3PUsZiq8INPwIf1R2X9AUz25s72zH
	wX/u95iZtlVEBVmNc4PcAhcNN6N6dXmMv9pgdWxZiM+NlQGzU7tOYEq4olrmYnfhUY4FZOYM+FAt4
	XlUFIMOFGQaIVK45eXFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwmf-0000dT-Cc; Thu, 21 Feb 2019 22:25:37 +0000
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwmY-0000cc-RU
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:25:35 +0000
Received: by mail-qt1-x84a.google.com with SMTP id e1so196929qth.23
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xLBRuMMrq0cNA0zgwp4oOxjDeaWQ2llxgXZA+AoiLoA=;
 b=s/MwN8fJqdU4JJnSkRG929/qC+zalwdqJlGZJhQjpiFCInLx2blcK3XIhjOXSvDeEw
 x5iTvmAvjADGfobNXn93JNovuei7H55uxKbZPnVirmCM45axH8iwSuTwptZqVype86fh
 t8glXYmLfjEJyDBWkB4ytbC6BA6SqPhnrco2RTyIWEUSn8kakvqofTeKcvNgV4YdSmOB
 wiNdrhHWMpdfKwccKKpVXhahUOM1pKFHghPrg9LDuTY+7F1VrjaTf7gJqNv2JOF3/eXx
 tIkKfiNQWacOgqoLCImZ+soqresIyARpfz2gKEqle3v/AqDr0dUzt8gN/nk1TIZzDFFz
 fFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xLBRuMMrq0cNA0zgwp4oOxjDeaWQ2llxgXZA+AoiLoA=;
 b=NnPmPuu1ChhHA1ds5Y1KVAdYezkLxLNYLym5rmoz5FxtRN/Skk/5IxdvcLowBGutJH
 yfAGOwvoh++j9k1z+a6ByOFNQeNQ4KtXH1syz/LwwFFSFpZeinitK51YSy1nOKPBGYss
 828CaDqUD3128BmjsqzdREROevGvGc9FKFUX3fm5EMdcJVllJOl1w2PXUEAHK1b3cKxZ
 z12rpiLjtbHP5SlNXo8zUf1RJzr32SepLSL3GrjHw8L8qp+HUq23N8NBQig/Ed7ZAy2W
 lq7gSwsIpdNkjbNBmDrbPIoVr8b8pq1Dt0ZWRmydtK3DjRajWdZ3t/PKrtbwoAK5s8Xa
 z7Lw==
X-Gm-Message-State: AHQUAuaiPv+BgDqVmA8hOvKP1fFNotPQXtoC18uUqnlP8IAEnkW+kpT6
 oaAaw7BiiE91k8F6i72iJPivENPfisH/
X-Google-Smtp-Source: AHgI3IZkF9L+sVhap9e/1SWARIAl0vz+RHh4/EQZ9OUOi/MHRfLZT/lT9Ds2u2e04cBUHnv6IJjzmH85dKkP
X-Received: by 2002:aed:3a25:: with SMTP id n34mr548310qte.17.1550787928702;
 Thu, 21 Feb 2019 14:25:28 -0800 (PST)
Date: Thu, 21 Feb 2019 14:25:23 -0800
Message-Id: <20190221222523.136829-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From: Patrick Venture <venture@google.com>
To: venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com, 
 joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_142530_915242_2CC8B4A5 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.

Signed-off-by: Patrick Venture <venture@google.com>
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..9c4d036ad5f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,33 @@
+======================================================================
+Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
+======================================================================
+
+The bridge is available on platforms with the VGA enabled on the Aspeed device.
+In this case, the host has access to a 64KiB window into all of the BMC's
+memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
+has read access to all the regions of memory, however the host only has read
+and write access depending on a register controlled by the BMC.
+
+Required properties:
+===================
+
+ - compatible: must be one of:
+	- "aspeed,ast2400-p2a-ctrl"
+	- "aspeed,ast2500-p2a-ctrl"
+
+ - reg: physical address of SCU2C followed by SCU180
+
+Optional properties:
+===================
+
+- memory-region: A phandle to a reserved_memory region to be used for the PCI
+		to AHB mapping
+
+Example:
+
+p2a: p2a-control@1e6e2000 {
+	compatible = "aspeed,ast2400-p2a-ctrl";
+	reg = <0x1e6e202C 4
+	       0x1e6e2180 4>;
+	memory-region = <&reserved_memory>;
+};
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
