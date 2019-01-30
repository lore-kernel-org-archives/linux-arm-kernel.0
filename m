Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E3FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386702184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3nYTM4D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4ICsNpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386702184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=amTY9WdYfFj7NUR35aYwnSXkufLNYNkGyhhf8ikGtg4=; b=q3nYTM4DITI5g3
	kH0UCkjmlEtYEE00Jz2S7SO/yb8qJ3qcEdfX1fYTnTKw9Ud8t71vsGry8FJeCnBQZaFgTAdSXYsc5
	2VglCUq+t+DXi8WXd1fLBIs1wAGB1bHBEE9tLEv0Y4bc/r0BwTVNY+6aGKRKF16BMg12CcOVamG1b
	6oIyiGUdVM2Q6PMYBfJATpKmLtlKk+DjI+pTnud2Ar6D8+4K9apH83KHWrJ+dUlD7tV38vtM0/ZAv
	RkYZ/EMNKs4bptW6wCyjTGh1fML54cS8VP9448Q8ownDe2LsaCaWvTvgHmK6VGByXkBrHXZbP9xLN
	lsoxLsXzFl9zGyxvoFaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozUE-0006WF-MG; Wed, 30 Jan 2019 23:41:42 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozTZ-0005to-AL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:41:02 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so1296802wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 15:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N0+MiYkl2FyUrNQhM06/7391PqinzSAuv8ZoqqjUEE4=;
 b=A4ICsNpMFi+QJWC1G7cGMifLk7QGKMRGBKWrFYbboVsNH/8mdeQwKL1b0XE/rNcup7
 2T/DIqLlU0K0Zzd98Q7j+cTCFsCSlGookt7jBeM9iSepujof5qpJlckNf7cprfPxfi2S
 9ytIC2pIsbtAFcrytL90m0Qo+vFW3Jz7h0KVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N0+MiYkl2FyUrNQhM06/7391PqinzSAuv8ZoqqjUEE4=;
 b=szcRKLAv3+Lvxc898KnmeCvFjEu7TYvGS2g1Y7F0ZaVaggdmzSaP/Xu67J5pcohaYx
 OyeHiKpxOnKdxpTcxm4Bn+c2I0K2ROvH20I4eQCF74jfhEwempEeZb/kKASj5hXgVFo+
 O8q+66T+gvIxf3pUwgf0RvcC9WDShBtNhCA+WXZiBmPQrqKKUZhjQgbFQve8su4mwfcU
 mv2ns98lC5msukSy04tsxKyK6wR8i2uetHpmqkbBpjpLXHynNtfu7RuDQs0b78txvXM7
 3ezruIonlBE4pUQpBbhP7TKUB0dbTbMWJ6uk3MVS2tgNWIJYKMkGNs+HnhDILAAMCPZK
 owgg==
X-Gm-Message-State: AJcUukfFDJiG2xVZKP8lz1gNP3QCJXjJiJRfIBNgIPosAmcMqlu4Bd8d
 hUUn552ULsJwGbC9104ezbMMIg==
X-Google-Smtp-Source: ALg8bN7+R3FvVFV+Gg8YnqDPIMvID5fvaGHBJxBJp8GNh1mkKpMabsZfkZ9IUjywIsWSd5vEfueGRA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr30735806wrq.5.1548891660014;
 Wed, 30 Jan 2019 15:41:00 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 15:40:59 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] coresight: etmv4: Update ID register table to add UCI
 support
Date: Wed, 30 Jan 2019 23:40:51 +0000
Message-Id: <20190130234051.2294-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
References: <20190130234051.2294-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_154101_352029_C03952B2 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: saiprakash.ranjan@codeaurora.org, arm@kernel.org, linux@armlinux.org.uk,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adds macro to enable UCI entries to be added to AMBA ID tables.

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++++++++--------
 drivers/hwtracing/coresight/coresight-priv.h  |  8 +++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..dd9b9b5ebb84 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1067,18 +1067,21 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-#define ETM4x_AMBA_ID(pid)			\
-	{					\
-		.id	= pid,			\
-		.mask	= 0x000fffff,		\
+static struct amba_cs_uci_id uci_id_etm4[] = {
+	{
+		/*  ETMv4 UCI data */
+		.devarch	= 0x47704a13,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000013,
 	}
+};
 
 static const struct amba_id etm4_ids[] = {
-	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
-	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
-	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
-	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	CS_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	CS_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	CS_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	CS_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),	/* Cortex-A35 */
 	{},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 02a1f5204f9d..fd69ad24432a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -183,6 +183,14 @@ static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 			}				\
 	}
 
+/* coresight AMBA ID, full UCI structure: id table entry. */
+#define CS_AMBA_UCI_ID(pid, uci_ptr)	\
+	{				\
+		.id	= pid,		\
+		.mask	= 0x000fffff,	\
+		.data	= uci_ptr	\
+	}
+
 /* extract the data value from a UCI structure given amba_id pointer. */
 static inline void *coresight_get_uci_data(const struct amba_id *id)
 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
