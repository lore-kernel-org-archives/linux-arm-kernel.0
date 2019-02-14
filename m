Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10DC2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoYxFgYk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IRBoYPkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10DC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=N2DX66Zcfg1I3BqASzetkzpMOQXSRayq8tG6S0C6abo=; b=XoYxFgYkQT2+j+8uauYLwOETzM
	ILl40csjInWGKqav7qvKh1b38yUUV9H5kNyowR5ECq+Xnh3hqo/alvtvmr5Z0E33sBFuS0Rva66E9
	3PBJC2ak1Wn7pPj/9u6CLvChG8AryMGPzCkKBammfp4azn+ecmRVXvIgAnM+sM4GEoS/fWrSb3xVJ
	5VAQXm0wGzLMvsuxlYrnVANLM+nzkpYap6EHc84SqKSVVnf+iBs3mCY9Tk653P5LwmfQlWm73KXYX
	n/2BCQ54lUVUiPjB7nouiONI4fGGkwJZasZX4TA38nEvsB2n3jr85ecSEw9qC+kOSZkqqLdQ9d3rF
	z/EP2I9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLHu-0000wc-Rc; Thu, 14 Feb 2019 17:59:06 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGt-0008Bu-4c
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:58:16 +0000
Received: by mail-it1-x144.google.com with SMTP id z7so17267088iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fGCGdqm3RAepP74+LvCBxZoDYBWuJpR+3MyMVFFDokE=;
 b=IRBoYPkzSdiQztYw6MxHVNC+x9VpkbxkNWUNyAFXuG8qenf4Juxpr1qN9jqg8Tkipv
 tFD9NubGpVq1Kgk+i/1fqwEj2YS9MDV5Coi0h0HZgxmrnMIwhzH07qx7+Yuk0L+VtaCA
 ist8UFHCcmjiS9Yk1DPG7nIjmr3Yr6sJaY5ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fGCGdqm3RAepP74+LvCBxZoDYBWuJpR+3MyMVFFDokE=;
 b=iAafC0N3V+CB4Igk0fmoJ3l9CPBE51Vxp5Gn6zWz/eKZvATci7hSF7HutO6uYcavAH
 bUGOeC2dPT+I+E1ABhpTCnirRrNgJfidIKs2sh4L82j0m6UHXxg2YKNukl757103spIL
 hPlLdEWKWQ3SqkkiW4JAjDnVDo2nKqCktC3Q+CcknY80zVRp717XHAygJsAgU36pyhuy
 mtnvTNsyJ9MCDgQXtVd4GKxYWHEg9omz/TlAFhuageABlRwptKj2fMjdLgRcEMMDkKAr
 3ytBfzu3/kkLBGSpZpCE12ABhVywu5k1nzfcobp+gzYPzuuZqxeidQhQxLzRpE58XDFC
 QdIw==
X-Gm-Message-State: AHQUAubhiOm69vYKlg511u3xm/PyZF8n6DjX2fF/uIAl64r4kxRIqKZM
 +NpqLk3hbm5C7Kw2+uWzMmp2XQ==
X-Google-Smtp-Source: AHgI3IZdkA++LNv7Ts5SFqk3VxLEQJTkpqqhr7pwHg3I8pWazyHPFkUL6jF4SzUfI6ttFbpGZHEdBA==
X-Received: by 2002:a6b:b644:: with SMTP id g65mr2927148iof.198.1550167082407; 
 Thu, 14 Feb 2019 09:58:02 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:58:01 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,
 iproc-nic-i2c" compatible string
Date: Thu, 14 Feb 2019 09:57:23 -0800
Message-Id: <20190214175725.60462-7-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095803_623708_2950B1B0 
X-CRM114-Status: GOOD (  12.01  )
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

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 7a32bf81bfa9..d12cc33cca6c 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -26,6 +26,10 @@ Optional properties:
     case, this property should be left unspecified, and driver will fall back
     to polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor. Value must be unsigned, 32-bit
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
