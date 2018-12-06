Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA60DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870AA20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uH9neWuh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vT9gttfL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A64Ef4cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870AA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AApxeRkNTbHQnEfeFBcD9OsJPQ7gfMoHwriNl4DSVBs=; b=uH9neWuhdxdnut
	HM+xg4wX4PZaz8e3Y1ejlqDhSdf7UbKCe27FagY5JH911Y1wcU8npg9z97ShK7J+rsRldCjoen7I9
	uQQf+hn30Z1cHB5UYku5Xb7y1P2gzxXe4O6IheJauBcgWVgatHvJLle8oka/2KzUNP7tZeDYDsXHU
	5uewqiCfJehkvkT5k1O0TnqsrSmDKwXzU8xb7NwF8ThlRpB4HL2H6zBcyHd/JxE1SLNY7GKJEPyfu
	4NG2QmcosjKPDNn7P7N0k7DrzYUz3N1O9QQDuU7m8MIF7WF3Qtl/JBfWTKO7gloutOKZxlIpAvEz/
	3R8cs5AxgjXWf2NMuQpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUx4w-00031W-Q5; Thu, 06 Dec 2018 17:04:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUx4T-0002CC-TZ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 17:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KiijFFi9cxbsD6r8CIzAWnoNEQmYmVE2QIBJaWrrrFk=; b=vT9gttfLhHm6SM0lqK2focCgZW
 EXud4AImeomOro7FVGqS3vGHSPOQ2ZE5gzl3XQy9up0fZo38+NT0mWmbEXbtfFNnolHkv/LLAlSWt
 k+a9oHffkHYqbC6dqzM0TQJN1QW87VcGPWC0uQpz+U1hafgwG0nsLDMz3x2sOt7ELQHgAUN6YcD7P
 8ElibznjcO7Mi2DR40UAXdfrZUggG1S88jfWN1Xmaj3KMNWc8ePgdhzsvux3k0HMpz89VQ2n4Lwyo
 GPPczOa8o2UcunGB0UW78PKkRl8hu1YEFGZN+9xs945u/Y3Z3CPICZ+mzQN52zMynSxQUYlg4mLic
 XVFQ19TA==;
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrF-00064I-9f
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:38 +0000
Received: by mail-ed1-x541.google.com with SMTP id d39so1303318edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KiijFFi9cxbsD6r8CIzAWnoNEQmYmVE2QIBJaWrrrFk=;
 b=A64Ef4cwV4ckKmL2uHjexTMH2UYyACYZGRJFIQMk8kMz7nuH0eJ3Wwu1WzJ0P7woce
 osWCoJA4IjCp25Dl+XNEvDBbTXC2YZ5SaxdlXeweyHcmt1211Ja+Mldt9jWXQQ+UvIZF
 WL9AT6eBnlppk4EKFbvUT+5rLUM7wYx5ShumrLyp7dTawkcM7b7jnGraC3KnD1UpkfPG
 qW8kVoYi2u9Jc8zjENyfKqPmVtIlNDAc3qcpaKwtA2YJzteUZXERUHA6ztE/JayzO8/t
 jP64z4VK6eAvucHsf2IRoP2pyRxfMFDal7PMPGCDZBJQu9mJR0oZuoMx4Xus9JTCw2Mc
 WSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KiijFFi9cxbsD6r8CIzAWnoNEQmYmVE2QIBJaWrrrFk=;
 b=CTADHaO3FJbWv3AUXC5r9uxUgCCZnkTgifLqeE7p18RkmzZYqtk+Ih5bSlVQ3eV05t
 tlJ/X0T2U1YhosHplqGZe6+6pWPRjGXZ6umuhndmWLQq+YLQpkHG8YYvUZ9O7R+7Sfgs
 Gx4l7fPl7BttNFcbRwPRz/b1T2Ut+VU8U6BHmb5znfCXtNglxgIgo5CJQT03jKLFdfLK
 Ta6L0urg4mKihFT9pJ5DZO4C0sYz49VEVqmU/wDtBVyHx9CBWFpL+OLL5rytADYaMlCS
 9rbYXKV4N/CTmbKscRV0Vxb1EpUxShZr8Mm6hsCVNOu/HuMgVY123XekKpwDWTjfqn0w
 OSbw==
X-Gm-Message-State: AA+aEWZv4WpkoWHdOCfq6dANNmawRJs96+AY4MARpzzz0oshnmzuhYUv
 LB3DNl1BT0e3XKRC/f1tv4g=
X-Google-Smtp-Source: AFSGD/WTqy0LLIKVXIDZII7PxXHBrpchlUfQwNTMr+uip3beJ2szkcWSxCouYlgdEZtwuhXQwNtw1Q==
X-Received: by 2002:aa7:d416:: with SMTP id z22mr25014730edq.3.1544115025494; 
 Thu, 06 Dec 2018 08:50:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id ga24-v6sm166667ejb.72.2018.12.06.08.50.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:24 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/7] arm64: tegra: Enable HDA on Jetson TX2
Date: Thu,  6 Dec 2018 17:50:17 +0100
Message-Id: <20181206165022.23845-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_165037_331693_B5C556E9 
X-CRM114-Status: GOOD (  11.70  )
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

Enable the HDA controller on Jetson TX2 so that it can be used for audio
playback over HDMI.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index bfcc00a65af6..0f3c6cebb049 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -53,6 +53,10 @@
 		vmmc-supply = <&vdd_sd>;
 	};
 
+	hda@3510000 {
+		status = "okay";
+	};
+
 	pcie@10003000 {
 		status = "okay";
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
