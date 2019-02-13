Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7B42075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q3rBqIgp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pk3YeoWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7B42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aWtkQZpmG45Ra1GJu+PfNAIRyKML3cr+IuNZFTRELs0=; b=Q3rBqIgp7IFXil
	jGniWhO+z66lRBBUbvyjYBKncaAzhFLVVLCK4PBJvo0b3OybokvzfdXaCRKNZuNE3n+kSQO2063SB
	HGt45lTWn2i8XXdPyvneoZyTuKcGKAFvYwNk35ujHvmReAAU9FKKuqc/Y6X9Op60Z0+Rhbz5Jz0te
	tEuvuFNJT3WBYZm5zgqbf6as7Lrzlrt7EaII8efAJVg4rKl+0eWkAryDPpYIEPF66N3JmwQUxt6ld
	C3bQ497gj1PqKwB53dsDWwJ0XeaOzjzei5HNndraGag2kMhcy+D6MSlm9laHv8AAu8LJf3Q/dUwVp
	zoi2gopF65B/wxNUA7GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuuq-00010J-7i; Wed, 13 Feb 2019 13:49:32 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuuM-0000HK-40
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:49:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id f14so2596145wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u3GTUfEjWcRlL+RFmW66nHLJMZPBhcSQfWl8hByhtwQ=;
 b=Pk3YeoWvl3CfZ1rl4mUysZtzi5euC0dKfzFPul1QnAKspstyb3RXak9bDEt0fZE1Gv
 5Me8pSyP+zJIJ6JZQjDZ42SkaSP/WuRb/t4Zw5KShUn6q0tCGz9qVw+39Uvr6+DJzmCM
 iKSE6v0yuk29oFmgyfdehDE05UTfQAZbWVnrkLKMpTvRMwrtF5dDh6au71vQUjgrBGV9
 q11CFpxyk9kEXd2Ph8LUF8BUkfY3sL1+HnTRVhLsVmsagGA8meE5AsouvGyg/M9lD3Cs
 Jr9NNAE8QQ2kHQHgvmnRG/IZ8MvBocb3rtinrFVNJf02Z+ZzFdDaiksE1jXKPCB2I1KT
 5ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u3GTUfEjWcRlL+RFmW66nHLJMZPBhcSQfWl8hByhtwQ=;
 b=ElLjlBq6sVNKH5AMsPAeM0T8FNdGWq113QtKjt1lwl0gJbzfKYkU6Q5AG95RMVBRqn
 ImtgVYTUja86/Qn/picaATzGrseeQg0Ak/yXFstt2fyMMU6dRx07klKmpcQ6HtCj7dPJ
 kHQGOgkez4izj4Weuinp4iUlqNmt7XqdVoHDvH1GadfhbAexUK8/odEnZ8eDra9zR7BA
 spRrLSH+w4dsx1+oH61yue7NMEGOvLo21OOkDEfdSQ200MGlT2xfG2aED84w93L99prE
 UI4NvW4jHsBjBgvR+TpbASFwgV/G2CCAEiSbCLyNf+Z1yT0ErgD6Jcx0gc6BjUR2MyhX
 S9KQ==
X-Gm-Message-State: AHQUAuZlJBFAOmVj7j0FFI4HTZ9qyWjBQJRGIjs5jTqD05/P0xoSXh14
 gqHWlm5c32yLylUbiy8DVqzSYA==
X-Google-Smtp-Source: AHgI3IaI7ONa+h4AZGYuUK5gwEcfAzas1i+JRQ0416nZytp2Ta1mnsaAGR/GXiwjHIygq60bCbLUcQ==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr536869wrs.70.1550065740559;
 Wed, 13 Feb 2019 05:49:00 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id g11sm3333838wmk.26.2019.02.13.05.48.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:48:59 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] coresight: etmv4: Update ID register table to add UCI
 support
Date: Wed, 13 Feb 2019 13:48:23 +0000
Message-Id: <20190213134823.20150-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134823.20150-1-mike.leach@linaro.org>
References: <20190213134823.20150-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_054902_168257_5BAF17A1 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adds macro to enable UCI entries to be added to AMBA ID tables.

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

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
