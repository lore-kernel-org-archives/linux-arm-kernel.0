Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A87C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0482520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RbtEu/It";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGHlHEfr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pev+OlM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0482520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TuYBFopuh98vqC9jt5OQSFtaAcdjpCF8b3qnfRHHDfk=; b=RbtEu/It1X1iDl
	Gp6VxTDWbip9Uv+lbYpiplo4rsD4qT0R6oHjpsSRozMqRxtxI+rp25Tswxava3eO9rgFprH54eMY3
	gsjB3oWo4MelMi2b/z0tGnZeiHg+YNAyf5TJ0vDpPpTBkClPkLbo6FRfMarCuMKccaqWxaQw3smy9
	++Q+OYCKiH0jO+uoFEPTP6h2hX/m12L1YR/4vgUf8qi1YN5ccNMzHMagI/btgFyUK8k+qHJoC4syO
	xULVrBSfdaWcEoEwHikfP3jzEc+pd0Xe/Nu9DA6v+i1xAcxr5icby2b693yOr8YaxtZkgrceYtQib
	lZn7IEpjBhpUqHjrrYwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwtD-0005wB-U0; Thu, 06 Dec 2018 16:52:39 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrQ-00040Q-24
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CXVNZ5P7cFQZeD2YAeUT3FNkCeVtK0/u4CP21waisZA=; b=rGHlHEfr+dRUgcq/Offjw8Cg05
 G/06ShA+Bdr1+VrepNKIDuVX20LJyzSiWBbHeIkCVwNe27fUWbfDXn3Uj3Trmn37hevXxH6xnvWYf
 QdBvGb70isxEQ/6lyrK53cpw98IJnEFMJqLOWJ2vmBDa3fn6vzHDc1sfkodEzYueNrhRIpL4JR4Ko
 2Ywkit6ZfcZzGoexwtFaw/80zPgtKI616Q8+nm+k5qBYNFovfvFCtgZrDfhn85X0vSzLyti4REE8R
 rEQHVFXJyhe3Ke5To2kOme435Sq8AZn5jRrXQLAlJauBgXvKtaKguxjZnsrwbXrmi/8yNmmQtO3EE
 6dCb2Clw==;
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrK-0000MY-Ac
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:46 +0000
Received: by mail-ed1-x544.google.com with SMTP id f23so1343308edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CXVNZ5P7cFQZeD2YAeUT3FNkCeVtK0/u4CP21waisZA=;
 b=Pev+OlM1xyuqL+67HZY7rhLTOT9TH5yMvsin6LeulVZmrfyHUsbSN8+l9whX0CA5mz
 8K6h/u7VO+d4XOLb7MDbKhUEUJ+sDTT7jZ96u/+jz5Q9/Y7nJD7k5/Jko4DoSNazptSS
 n9Bc29+1b7unDWMpNuVWFt5Az7M4DBZpzuE43Xz56aHo3a+A8v+oGSmdpIaUApiqFmN9
 yT6E3o7jG8v5duKY7KClKYp58wTfER/W9E/16UejnSeccFU22tVTzXQkSjsssJ7IcGps
 djCc6ud5faZNX+dYucrQ/v2OcHWAqtltDtftCCVtxz3wVqu/OgiUN0WevCV2/mi3QOir
 Os6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CXVNZ5P7cFQZeD2YAeUT3FNkCeVtK0/u4CP21waisZA=;
 b=H87pW55/FGk5Ozs1SaADjKkYEvh8K9+ONJpFJk6GTtdcnRZG8BOszg0BpKX6kXPnrD
 OV1A2njyznszfTThH7TuG7FT7a5CRbOUGpXoAZa8gYdxHPqFDkSgKlEMUEg0taVz+taK
 eOXX9xrCcDVriM82mOqwsx7WYaDQhCrddPKiW+9q5EWIFeZKu02V5ZD0vnGLe5TFIst7
 mc5r/dSx0JgeWbfsfYvv/8Djoo9dCOCwQ6vSHfWXJrsBhYEzf8jcG3Vy8Sl76mEiNPe6
 8aUzs9TYfgvE1tZTw0E6F79CpjwDpgnw2q/+VpJRPTTrm40kgHEnCcOUDtZGJSFtpNXF
 UN/A==
X-Gm-Message-State: AA+aEWZR0DiReqw4wJoUA08j7nKlAuQljxU8unViJoNOK/bYs8IhQi3z
 80kTg9xCuE0XRCrwq4gy23s=
X-Google-Smtp-Source: AFSGD/WJ06uZ/4mkQkRzKCL3xDriCgGFGdmhq7pDnV0qoT/Z8eV/dxVZokEOB3ecrMbyZzq1/V9sbQ==
X-Received: by 2002:a50:c40b:: with SMTP id v11mr22287136edf.232.1544115030166; 
 Thu, 06 Dec 2018 08:50:30 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id w56sm310652edb.72.2018.12.06.08.50.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:29 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5/7] arm64: tegra: Enable HDA on Jetson Xavier
Date: Thu,  6 Dec 2018 17:50:20 +0100
Message-Id: <20181206165022.23845-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_115042_424168_817147C3 
X-CRM114-Status: GOOD (  11.38  )
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
Cc: linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Enable the HDA controller on Jetson Xavier so that it can be used for
audio playback over HDMI.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 274937042c4a..adf351010ff5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -24,6 +24,10 @@
 			status = "okay";
 		};
 
+		hda@3510000 {
+			status = "okay";
+		};
+
 		host1x@13e00000 {
 			display-hub@15200000 {
 				status = "okay";
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
