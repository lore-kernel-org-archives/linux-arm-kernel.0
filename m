Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C49C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEE32184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rk+x9ZBI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SyXCMPrs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Neb+urI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEE32184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGx0B5nxvZy4gup3G+6LvnI5E5BYlKNgHn2Ux8JbM20=; b=rk+x9ZBIjdqoj/
	YFThat4h24h/8B2xDXhZRlCGGqJdAkwdeBh5gaqWDI8k+ZMXTay+MV+k0ok5GHwk9+Vgdy9q1Aaoi
	ge3LBLs1oVcvkl4QIU/Mh0MT3N3Bw3vy3IX4vM75RyJJUFJPWOXvwiphBCsue7zty3NBphj1XsxMN
	PatXtHjzrzuskXJv6dU324OjIzMAcDz9+EjmoL4/niVxuQdKQJCcg852w47bmNcQpiQJQ/GQx0GQf
	79xTDLik5oC62QM3SmUlv7c2C5YiHr7wRFlOYfii+oPwWl0TOy1ADT3sK3CvpY6BptspBnYnmDBdh
	ye6seRcOrjyO49FvVrww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVyW-00045c-SV; Tue, 12 Feb 2019 11:11:40 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVxh-00037j-LG
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 11:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=; b=SyXCMPrs+Ko1wNqyx1lciqu/KD
 GOAieu7KnH44JQ4xMBFLvzryRkdvlSKigZBrj/tDO174FAMe6PRmdHo1/zY+HYS7vbE/ELcX85PHb
 PV//3lg47IrVm0q/7YOahY2QSQRkrXdC3koSD5l1EGNg4+0iA+t8aqlyprtCBqyiRAZ8+4/l1cA4Q
 brUJk+ODo6z+HQiEaERswGYfyCdStaABhk8xpJqoMYmHPVEuLlzotBkc84dKgpYgZGOT3d18VvK73
 STTfSJCkiAsRiSYjRgtw8qY/CpuCjtPJFzxgEUlh694NTvKjwB8oNE0RRtropFoFRXwLS9SmMi3cN
 ydA7w+yw==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTO-0002G6-RP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:31 +0000
Received: by mail-wr1-x443.google.com with SMTP id r2so2063376wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
 b=Neb+urI21I0HLEAyckGEuIVN34/XdQJ3dLtZjhvLvZSZkNhOSD506mPMhDr2RmO204
 cnM0r4q4hlXesLC3DTzuJtXOcGffnhDZT0obfcI+3GRTitLjiwODX4oNlWRsrX+BHAls
 O93qnNX/xhT0cBu2URQrlEfe8jjJGt2mp4LAHR5mmdes8N1pk8O9BKWToCPHNUMIIeNK
 eQQjoOtSwIvOxi5F74CLCiuxQcpHWpl5fqeVJ2vcw6dS0WZB1Nl7t34n/DMZNdfYeUWL
 C0qY2N+6dDqU7207jS2CDFRGqG0zTgUyqlEPrd7ENsfJYxpViFQipwz404A/i9c/tXbf
 hIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8q3N9QJP0kKocjZRYLcTGHxt0dwwrAq7qRa8kv+RaP8=;
 b=SXgA0DLNcGFxaZ18+4DZTqgGoJUAaAMquyQIlAAhLP3QBM3IEre06HlDiNzqMhoujm
 kkBUnefXdDhLAFh5AmHUaredvwsdJzLy0OL31oe6x6WbcFJImG2D7LH8F6cOTjUFb6+O
 ak3M5hUPVR/OmrOyB18Rip7Y65bW2lqrZ6W1A18SfwDxvGyOnA9KkxKWZAaUSqWd/4G5
 45m56xnXbx6TNPb7KlVCVTPGmKjJROVszJpXvbGl/IHjNl66mQPfAqyyPc/spRLzFaCa
 libD5vAImjMh+W8bmy8NgPG4eDGYNhnnp5eihZY6PT6Suq8Hsk2Pfge/OYj3LQH7jIDw
 a6sw==
X-Gm-Message-State: AHQUAuZhXAbKSEI70/a7qEDumrnp5PvC/7PQ0dKo5D5xnCVvq7wob/CO
 5QslQVwgmao4xOzIvy/+JmNbzg==
X-Google-Smtp-Source: AHgI3Ibtg5Uyn8iJDbrCmsGH9KS5wPuVnCgbYmpMY9BakQZBNW/xdDAtNRuK3HRSWE/k+zCWcr8Igw==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr2264960wrw.84.1549967969283;
 Tue, 12 Feb 2019 02:39:29 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:28 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 28/37] ARM: davinci: cp-intc: convert all hex numbers to
 lowercase
Date: Tue, 12 Feb 2019 11:38:26 +0100
Message-Id: <20190212103835.7768-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_053930_933109_D5571A5F 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use lowercase letters in hexadecimal numbers in the cp-intc driver as
is done in most of the kernel code base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index bf77b6950273..dcd43b067a6a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,19 +23,19 @@
 #include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
-#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0c
 #define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
 #define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
 #define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2c
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
 #define DAVINCI_CP_INTC_PRIO_IDX		0x80
 #define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
 #define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
 #define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0d00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0d80 + (n << 2))
 #define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
