Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB22C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E208208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LRMh5Tu9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4Tb8vA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E208208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Bpxgp+e63wHXDrsHBAsjtnz//7pd0G6UNQr5nt2C6FU=; b=LRM
	h5Tu9gBrsQx4Rh/u3K82HXE17sVrqoGcgdFUfcWLJP4Hd2lzqoVM53kSH/zjHDoi0UAlMxaV+4Uka
	76jh7Qc52x7XcLironW9iBJFIVWTFaZCYeAD6Ncto3yatH+VJeaksFuh0OxZddKFtgIUG5i5nnGd3
	XyIVcHPmjLbfLkFf6VhzbowVCnrdQpj0esQwaC1jz1YxcwvDLFlxLpRwgWdB8MlMFyNU/0fl1jjrY
	Vi6+WZ7xje3dHW6QwuN4W8ejAIJ4OExcnftSXSt5YBfPqCdkClnRFJoPg5SSJuLD6nvNKKWPkMe3o
	Xz5Jx2rCMjV6DMs+OoqTUKlGhX97yCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZtQ-0004Xh-AZ; Wed, 05 Dec 2018 16:19:20 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZtN-0004WV-II
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:19:18 +0000
Received: by mail-pl1-x643.google.com with SMTP id 101so10289662pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TkmL002NIrFI/+qlHIQs+8PHenuR75IqlFLC7k33xLk=;
 b=h4Tb8vA4breO2EQ5nRHAlajpKtVZwS4M19enDNuL/h72S0J0Xk8HY+FqCYMti8Bi3d
 57gkNY9J8ZDog3o3O3Q+w0Qfk4A7ntOY0yUU84ywqtRyEGVkoXmG7/9JqaA5UOOVPK/V
 1smgF1Z2gJCvYtJ4zW5ZOnf0GHXEK/KqfU1F/cD//mlV/q4lqC9sumKSyoXTZwZ68ba2
 +PA7u1AAAhbdIOxvN4d+Wvixr/uPN5Ck4i2MbOJqouFObt1SKVytSbp3AGlpd1Y0+2kI
 9PB58N8BMjqanRlJdziFthD5U4HKPZS8j91HB5e8SRsOoeF4hm3U+p8Wq3THXzve2SYM
 92YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TkmL002NIrFI/+qlHIQs+8PHenuR75IqlFLC7k33xLk=;
 b=gEjs2Sn6xYtiP/c5Lxf/Lq93xufOIfBebIW9vLr8EF25jBckj5yWHgLDKTqxDHyMNl
 2UPfUXWL/hOjYBwe2fVw+Ikb2tSF/qrYvdCcwMkJ2tMhA5rg4Al2+mvAK3Ac2Dk5xr93
 aGKEZtKY2trSJZiLhSws/zGFOV5P8y+HIruFxbGjEQu5OeUGpfE0hbISgGDlymm8N1hl
 oX6tpxztAlv6h0vKi7P3TcIdvFC0MhVgpnButtxkugEI2KMKlP/XMghhy1j2r/pgQPxm
 IXTK+9a3wsmPfArm6oIdh5jrRR+yuYy1xGMVG82mIaHkFUCjfLNR5HNwRGtqGEPkG3Gk
 F83A==
X-Gm-Message-State: AA+aEWYBFSELLc47d621kGjC9SQSarmW5jagtwSCYo05f3XRdYYCrbta
 9Aiwl2RzIX0Jd7x3S7navy0=
X-Google-Smtp-Source: AFSGD/VVDjWyxipNkFrCccRko39MIoR6sZ9UlhG9MGv7loJC8nVBAFn1I0Q6bVwS3isDcnw3CW2L7A==
X-Received: by 2002:a17:902:6bc7:: with SMTP id
 m7mr25362376plt.106.1544026746670; 
 Wed, 05 Dec 2018 08:19:06 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id x3sm66303001pgt.45.2018.12.05.08.19.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:19:06 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
 ashutosh.dixit@intel.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, okaya@kernel.org, andy.gross@linaro.org,
 david.brown@linaro.org
Subject: [PATCH 1/4] dmaengine: amba-pl08x: convert to DEFINE_SHOW_ATTRIBUTE
Date: Wed,  5 Dec 2018 11:18:57 -0500
Message-Id: <20181205161900.16434-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081917_601628_FA780C46 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/amba-pl08x.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 97483df1f82e..fc8c2bab563c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2505,24 +2505,14 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int pl08x_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pl08x_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations pl08x_debugfs_operations = {
-	.open		= pl08x_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pl08x_debugfs);
 
 static void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 {
 	/* Expose a simple debugfs interface to view all clocks */
 	(void) debugfs_create_file(dev_name(&pl08x->adev->dev),
 			S_IFREG | S_IRUGO, NULL, pl08x,
-			&pl08x_debugfs_operations);
+			&pl08x_debugfs_fops);
 }
 
 #else
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
