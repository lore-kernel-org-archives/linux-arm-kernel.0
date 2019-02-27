Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4960C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:58:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7424B20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXaeTzhy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NiNs3dpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7424B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NHJcqtGuRGommf1JOk1l2zdbgT2VRTFAjt8HRN9FV5I=; b=iXaeTzhyivO/s5
	NCCbZilY/+cX2RinrtYgzMVvuiAgmuXd246cEu32QfCSu7i7dDQDEVnL7wIaFRT6NxuvqjW71KQxq
	T5F2F5GNLhHqaeOn/ypY9Qsv8AAodMtRFrV/zbdL6yE4P3hd+GEmJlv6cBDZsLN/IUSKHZmn+rj/Q
	i875YtaM+brGvMcunSSscM+rGWLShLFiu2tvRPfvoUKg7zXNmKKRyH03hrcrmVjf+yfqZOEhSQxxS
	ePQG3QY+p+xi7SxMfVgT+gq0l2mYhincEhEjLENR3NcK89XbyP+AmIMA8RXX/eNpf+3RrOBr/g35R
	MaNS3MXHLrg3ZXyp/0hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2Xn-0004Cs-SZ; Wed, 27 Feb 2019 16:58:55 +0000
Received: from mail-io1-xd4a.google.com ([2607:f8b0:4864:20::d4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2Xk-0004CK-Of
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:58:54 +0000
Received: by mail-io1-xd4a.google.com with SMTP id q3so13461944ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=2eptaMvxu/Yjv7wstKV5wbLlhTQnULNRTprcgCrZVTA=;
 b=NiNs3dpHdXbXZqRqwnb2pK2sf6NTErOjaatUdMe2afhO2BhvqYLfSHUOEM3UbSB7DJ
 WMu46+QAFEfrcudgE/JhjO+SKitGMURIsWGt5c6XJpxe1EC9pMsL/ev8A9msmvBk1c1+
 oJ6vaNcYJ5ax8T+vEGuv+QrmNO54rDyi4s95YN4WGuK3WYYBn4GoTcOvFUB/+V4Tu6w5
 CYWTzZ0pRm5By2CNgdhl9Gsct3AGfOl/acPxetOJTnnndiSmOxR7PFnH2k5l7n0qYbvS
 dgaXHF++sw23mc/HfbrJBhiYtOhce4VSPkmbAqFZ+lqmz6qH9YF1BmDyy+7kN5fOaY8h
 YeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=2eptaMvxu/Yjv7wstKV5wbLlhTQnULNRTprcgCrZVTA=;
 b=CF98u+FtarUT1f2SKhpil2NtWEK/SW5N+0g7Qz1lVvRCcCFni3rKaHdNIIJIZG4N4y
 v7HCti7AOLHJvC3Htf4WO+1kpOc4w3z6G6Bh00gDWltXZAZ1a5/0VNelRqtgMTnrE7Bl
 9a70ZGkbZUXSXdQamiC439KOKyezgso+XUEVnvGvk50DCv7dtVadeCcCrL6uVxuei3If
 l/sZsAx9wC1SBHF4Dxjv/hSa/cjCsvLEMFgSKMj0BF3WBeTutRvHrj0WXelh2ACQ+iQQ
 K3IwVU+75+EHoEOthl5OxWfujGAfNUHxf1/6iVML7/pENm5imHGFhiSi1kYVt0h+H2TA
 L8LQ==
X-Gm-Message-State: AHQUAuYgBYz6ZgEdFlG5o85FJ+2emNAreD05oU8CxJmZltQVEQOSzX45
 SErJpUpRvqGUvhSzxO+I5Li2qvDlFijp
X-Google-Smtp-Source: AHgI3IanU/eCFiw7CWFWFrcfmEO6ShyPi8W35xztC/xt6XZCMHYRktRiMC6jXoX5SV873BIJlyKQ9RdJUIiG
X-Received: by 2002:a24:5e94:: with SMTP id h142mr103861itb.35.1551286730735; 
 Wed, 27 Feb 2019 08:58:50 -0800 (PST)
Date: Wed, 27 Feb 2019 08:58:41 -0800
Message-Id: <20190227165841.143802-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From: Patrick Venture <venture@google.com>
To: venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com, 
 joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_085852_824025_52391E09 
X-CRM114-Status: GOOD (  13.20  )
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
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- Added comment about syscon required parameter.
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..1092d62d1c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,32 @@
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
+ - syscon: handle to syscon device node controlling PCI.
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
+	memory-region = <&reserved_memory>;
+	syscon = <&syscon>;
+};
-- 
2.21.0.rc2.261.ga7da99ff1b-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
