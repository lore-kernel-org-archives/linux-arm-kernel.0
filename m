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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DAC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA54220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qNoG7w8f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rggtcfWf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLioRG+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kx0oR5Stnk8jKVFyaJddGPFABjwhsGaf5aHMEJN7j5A=; b=qNoG7w8f0wQNhr
	5lkgFl/y68h98wTrHCZzxpFhEtFXx0kSIFYLpBO8ml5rgIGAAq8NuxbGytjNioMCEsr+8W+4Ive1f
	2QYcXGY4MjPyEANg+NRw6HVZeeJQROWp11JcxaKNrKi3aeI92f+hxk79sf8ewTZXuiE9nh6nDNNqx
	glLqRSBYbwBe8n2FZ1K6lRZibjGMggbYgjBVJBFRhvATtjJTVKoDDii5jH6mk+Ne1fogXpCY57+W9
	y9LlFV1IsDL4EaCXJyYNDWRdwLBPDoLoVABdUxjoA+M9+E89AofEZZjxfmfLZIuCMa7+DXuqb9/1J
	eHynx1MamGQ31RZqoTtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUx4W-0002SA-1o; Thu, 06 Dec 2018 17:04:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUx4T-0002OX-3q
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 17:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxvFRaElxCAJS6U/+O79RJECVRo3hRbs3/aZiqc5Zi0=; b=rggtcfWfMYL1Wq4csJuz+z2u+N
 4tpF++QtKF8qKJdTcP8umoIHuMjxITrvMgbq1vx6zWWLrfKbc751ftqtQHqsqdEHpm1TlvM97aoGW
 riWYZ1KMtl+bfvdAS2WnjEfscc8EIQnEodusKeEmoqLnpno56RYZoSmfSVh46U5Zm79QUA8RuUM5q
 6QneaXa1yoK5EBHAPZLQdxpwqDRRj9cNUW50qqmOUjZRirhRD+aIVoR6tzdoRTBg5feXvHSJ8ba4a
 FEi7O5YJgoYYK/FdLtU0afdDFiPpJaUiY+n6o9AXp3Lr0UWExrk5F+P0j5HqxcIYX3TXQI8KP4ddf
 yS/4fSPg==;
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrM-000651-Eq
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:48 +0000
Received: by mail-ed1-x544.google.com with SMTP id y56so1307589edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dxvFRaElxCAJS6U/+O79RJECVRo3hRbs3/aZiqc5Zi0=;
 b=NLioRG+5E5x8w4IKGQ/tb7ClRxIsOPSBmc2JgzQylRBtRfZcgHHF7Fnf4SiGo2tIYv
 WmuNvw2qE0FnLCa4YVNxA+hRuH0hpMMvyA/u9tPI8f/+XH8tySu7Jlks/2JntAN4OnxV
 RmHc81c72p5YVRg6ODkmZNMoFqitCwH1PtzG5WMV+BMFrm4HfW7JDtY8bntLUJaJ/msd
 QidasA6XnAgVAT2vjepJ0oT1lJcXakbkcn7KWCANHkxs1nXxUfwUvt3rKXImfgvxuH8N
 4foYUd4r+wlJXDmoXlSQPX6dJ132Oox4gBq4bkvp2cUsYMrC29+S0il0ImtOp/900jgM
 PzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dxvFRaElxCAJS6U/+O79RJECVRo3hRbs3/aZiqc5Zi0=;
 b=bjkBt5nUOECLqEkP9fwZYUnflrrZZ/xXpwfZ2Y2+3drshcBeHbpS0EyBkBM0xMOH2a
 Og+q4ss7IG/OfZLYSI2mWiAMmLk9r51ajbcHrz1Wc8OIEmoDpifZQXq+asjUie9gSLqm
 ZjESeswQEfJ9PkwsaSRAzRor/gUiZhQHrdCvUjS7EP+Iaabwfi6mrY1LYuM28mjvdyGI
 Gadf7AC3fUbb44RHGXpfN/ET+s4+8ktk0nV68secH+aQvdPeNQqIVWK7fLj/l3c7BJ55
 ZbeM/lmXohYOGC5zVj3I61gg3lMWzgy5RL9u8HnyyaF8ZeURmukgczYdblWRL0r6Zgr8
 uVxA==
X-Gm-Message-State: AA+aEWZtxgqf9VAlDiSCQM+EawQQ+DH8kNwacOfcZnonHmqT4x72I1FW
 jjZBHzOb9sOcqUqxBe2X+vQ=
X-Google-Smtp-Source: AFSGD/XgXJ6yqG9QF/8Rw8FhqiRrua+1EtK5cKQPT20i0Zb4B0rIN6L4iOoCdx2dWPETrb+J6cB4hQ==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr25465416edr.153.1544115033168; 
 Thu, 06 Dec 2018 08:50:33 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id n12-v6sm159517ejl.13.2018.12.06.08.50.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:32 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 7/7] arm64: tegra: Enable HDA controller on Jetson TX1
Date: Thu,  6 Dec 2018 17:50:22 +0100
Message-Id: <20181206165022.23845-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_165044_532581_7536260E 
X-CRM114-Status: GOOD (  11.59  )
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

The HDA controller can be used for audio playback over HDMI.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 365726ddd418..a96e6ee70c21 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1330,6 +1330,10 @@
 		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 	};
 
+	hda@70030000 {
+		status = "okay";
+	};
+
 	padctl@7009f000 {
 		status = "okay";
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
