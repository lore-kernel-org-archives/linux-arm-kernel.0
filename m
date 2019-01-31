Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAC5218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNlkEIbU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9j8cW90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC5218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xhFLLQbM9B9zPytxlCGekiRjm17mPGUrJRxO6BZ5miU=; b=gNlkEIbUMSV9+q
	N3IRnpY4MLobvaYj7shPNvqW5oBM68eyTd4/KsoKmRfq8zC6fGMmJ/+zDMUND5TSyFvyld6HiV1vP
	WnsVkrsrS7tQQEH412KikNPB9qH/ap7d0W7FLWxJ3zvWuV679J5XOcvp7z60V4I4rD9J5HMDdvc8/
	1akUaONyhQ+PGHU8zudRpvkEUohqUJG8O826xpS4g/ZyOD/BNTuzZChaZ4w8oWlrmTu/us8uPzNQG
	oS+xO6YFaCTNKeWSzLgqKtT/Mso3wCA/4xIDrWnFbpSozAoZC0Q7LNV73lCUlJazzigREuvzVwkkr
	FTIHM+72AzY0XCsCcoZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8ic-0002ZF-69; Thu, 31 Jan 2019 09:33:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8hZ-0001jM-Nd
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:32:27 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so1221317pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KYayTLAIjqbiHgbKVBbyF73pC5IYaCQpN6ywaeYZLhk=;
 b=X9j8cW90LeK2WsQyDgUHYwTnO3OihBXBDRBqlI7Tc1CJ7NuruPbmi0DTo3FNQbQjxd
 0Gqb9vHPSR0CiPBhAHp9kpfvZieAkc5G70SYXUvPzJLvsRVh2KLKU1WkrQUJPrGiWKJu
 5C0X0oGn/kMpST7Ljlsom3sMiPKw/nM7X0gJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KYayTLAIjqbiHgbKVBbyF73pC5IYaCQpN6ywaeYZLhk=;
 b=GXA2Xplws5MkG+N5mEogC0Tum8VYTiz9L82tcvIZdZ7HyDiFYeF2IfVXHopsfAvKnf
 tY+kx0nzASbWf3ltFayvys3vlcmxwtjqPCp+5qNX0Y0wp0W6RRfw1mbgoH6PIpPTXO3O
 8ip7DM4goFW6muKbcvTQ346GPYHN7JN3kZq7YzCNODMJeLUgLgrQ5koD9h/b8b/HY7DT
 ypZ6d7BTc1dD9oHvhU5huRj8YackNSiU86aY2rw3vOKB8RX5m7oh70WZarTIcLY4Kmve
 wREEbaxzAriwyr9PxORM4dsICMnk94o7ngmLwEyYON6S1abZWi33lDFS0o9J6Xq3xX4h
 O7WQ==
X-Gm-Message-State: AJcUukfrOOgBDC/RzDwUjQQbzb0zKIWPyUnCgx9gBz+DAte+nPRmYz+x
 YuI29xvjzkw3XT9n/WcBA7cQiQ==
X-Google-Smtp-Source: ALg8bN7DUK6LyOrUOEcGJ7vtN8iZZyAFdTD0HIW3jW/LZF6c5e+10zrYeAmDej9RsedLjCe1N5g6fQ==
X-Received: by 2002:a63:f717:: with SMTP id x23mr31147048pgh.317.1548927125228; 
 Thu, 31 Jan 2019 01:32:05 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.32.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 01:32:04 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v4 6/6] remoteproc/mediatek: Load ELF instead of bin file for
 mtk_scp.
Date: Thu, 31 Jan 2019 17:31:31 +0800
Message-Id: <20190131093131.245531-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_013205_872134_092EBF98 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For better flexibility on loading firmware image, change firmware load
for mtk_scp from a plain binary file to ELF format instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v3:
  - New patch to load ELF instead of plain bin file.
---
 drivers/remoteproc/mtk_common.h  |  2 ++
 drivers/remoteproc/mtk_scp.c     | 59 ++++++++++++++++++++++++++++++--
 drivers/remoteproc/mtk_scp_ipi.c | 11 ++++--
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 7efe2e7374e5ec..dffca9fbea9f1e 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -73,4 +73,6 @@ struct share_obj {
 	u8 share_buf[288];
 };
 
+void scp_memcpy_aligned(void *dst, const void *src, unsigned int len);
+
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index c0375119c53289..314ae3f8a82cf7 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -140,6 +140,62 @@ static irqreturn_t scp_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+int scp_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	struct elf32_hdr *ehdr;
+	struct elf32_phdr *phdr;
+	int i, ret = 0;
+	const u8 *elf_data = fw->data;
+
+	ehdr = (struct elf32_hdr *)elf_data;
+	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		u32 da = phdr->p_paddr;
+		u32 memsz = phdr->p_memsz;
+		u32 filesz = phdr->p_filesz;
+		u32 offset = phdr->p_offset;
+		void __iomem *ptr;
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%x memsz 0x%x filesz 0x%x\n",
+			phdr->p_type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (phdr->p_filesz)
+			scp_memcpy_aligned(ptr, elf_data + phdr->p_offset,
+					   filesz);
+	}
+
+	return ret;
+}
+
 static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	const struct mtk_scp *scp = rproc->priv;
@@ -157,8 +213,7 @@ static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
 
 	writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
 
-	memcpy(scp->sram_base, fw->data, fw->size);
-	return ret;
+	return scp_elf_load_segments(rproc, fw);
 }
 
 static int mtk_scp_start(struct rproc *rproc)
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 1026089335a5c3..b6b248c9da50ac 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -55,7 +55,13 @@ void scp_ipi_unregister(struct platform_device *pdev, enum scp_ipi_id id)
 }
 EXPORT_SYMBOL_GPL(scp_ipi_unregister);
 
-static void memcpy_aligned(void *dst, const void *src, unsigned int len)
+/*
+ * Copy src to dst, where dst is in SCP SRAM region.
+ * Since AP access of SCP SRAM don't support byte write, this always write a
+ * full word at a time, and may cause some extra bytes to be written at the
+ * beginning & ending of dst.
+ */
+void scp_memcpy_aligned(void *dst, const void *src, unsigned int len)
 {
 	void *ptr;
 	u32 val;
@@ -80,6 +86,7 @@ static void memcpy_aligned(void *dst, const void *src, unsigned int len)
 		writel_relaxed(val, dst + i);
 	}
 }
+EXPORT_SYMBOL_GPL(scp_memcpy_aligned);
 
 int scp_ipi_send(struct platform_device *pdev,
 		 enum scp_ipi_id id,
@@ -117,7 +124,7 @@ int scp_ipi_send(struct platform_device *pdev,
 		}
 	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
 
-	memcpy_aligned(send_obj->share_buf, buf, len);
+	scp_memcpy_aligned(send_obj->share_buf, buf, len);
 
 	send_obj->len = len;
 	send_obj->id = id;
-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
