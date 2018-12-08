Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F65C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4138C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ieLU6an2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k/St0+Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4138C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8TbYZUDnf682HBeRebEpDUuPP90ggUPuOovq/9kzis=; b=ieLU6an2XZbX/m
	gvmLbx1E4rodvAJPLTenMoPJnzPij+ntavQ9jBdHdyCFc5YyXrisDuj1QUWLbA5P8a0MGT+v361XQ
	zdRPs34ubhSklAJ+aYsOzNG28qEEU0Ec7J62Q4+LtldN0pbqeJctFgoUm4crRUCHpgN7AwZt3RIFV
	kEH98EVEExS6a85LGhdGMHe26+WbBpr/freTRPYfNYJvRTNJ8denBQ107JSqUecq4gVyOJZf4mdBh
	QS4OlCjLKCJ5iaRBxbAgoUXPo/LEGPfm2rtI5wnq5bqZa1uk5GUIXQSbbPfS71nMNP5d6Ty81D+ES
	VIz/Pfqiw3k3qDOuUXVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfp0-0002WK-LF; Sat, 08 Dec 2018 16:51:18 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfoT-0001y9-Vg; Sat, 08 Dec 2018 16:50:47 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so6529396wrx.9;
 Sat, 08 Dec 2018 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
 b=k/St0+Me+QBDUt/4Wx3MS+bSZOm9FDlsG3GrK7YH1FAT2NaluS95kcQW+DPsya9xUD
 ciICvMHEF10rXUhyCaMHN5/0GzbXN3FlBr9Xcy46WkT4s1hXraRGyChRNDdWI53HSLuX
 bh8i4yU98Cun0NuljFQwUko/XffeMbfbwwTgF3gLbAx2oz+i14av+ie5gK/FhQEB3BPh
 OEmryIOEw8jMDqoGO6rIjeOoRQ7ejYTnfR5PR+mv4Dnb1dyRCv1nZLebQEQpzEmLwXh6
 lwDLizl6Si9+vHLXUnP370Kdgr0DHANMYebj6nrQz28spGGSiDomfKzBoQRWvFknj5W9
 C69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
 b=AWwAX1jSf5PnvoxZhzRReB4o6al3gNnt0TFR1fCLdSjrLzGks6DMoACRfax5Xt5h3m
 OR0oR2EEqggyyjuakVIBoa1vWb39GQ9kDE5NOUoskvLJaE+JePyhtnB4kRsYxsBi89yU
 yHxEjp0uawaZnKKmQ2CNizXOA2durVSO5+aSQobXcotRetEEfDxOQ2AIuqY075IkItQP
 8hgUIGdYBW/w3QsFQJ2XEbc0V+HqkYMoUt/+I4h1LWrRjm++mYWgp4ruF1fLkazjCPK2
 kndyAaJ5lO0+w4VsYGk4NXm88xomGqMh1ttkyqEQPm9zjTnsAXA1cJ8csSfbt0dTWJcs
 UWZQ==
X-Gm-Message-State: AA+aEWbihmdN+OiL1DzDNC/VdBcTQ6CRDpXO5eWSqwYa2qHAyrtlCN96
 V6bSld5fFlZ0XQRlCFz+0wui970e
X-Google-Smtp-Source: AFSGD/UQG1pugXzlX/+BbJ5xM/f32FRjUZeon0BEyldClx69uoiIniCO5KVgB5CUyU+cslCGfuNReg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr5041819wrq.265.1544287833921; 
 Sat, 08 Dec 2018 08:50:33 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:50:33 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 2/3] ARM: dts: meson8: add the APB bus
Date: Sat,  8 Dec 2018 17:50:24 +0100
Message-Id: <20181208165025.27689-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_085046_020437_9C4FA6E2 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Various peripherals (Mali GPU, NAND controller, VPU, etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index e5cd325d7ea8..3fd8260eba92 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -201,6 +201,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
