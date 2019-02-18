Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:43:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A9C21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjl3fnHe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tA43GiiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A9C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=acUmXAY+cRSInv+nIFCaF5GbQbmP98G6Zfc2sdrthKQ=; b=rjl3fnHe/LGy0p
	E51xyZb7zEFWoc71Af6667mzjkFldBx7atdAzu4oMDMQZb4t5xqh4Kr20ow/fErm35ZumUCsSRy0X
	UinzauuHfAa6YruG27B1ME+1KBox0h2OelKjubHXiJxMYRZsESNPhCKjETotp/qq33twC7K0FOVwz
	y9f4lVCBbfEtmgtOoGEBVzaGjTvyyjlyTUuIAtzKmC/Cx0sUUPCfFRgCNSmHAv39Px2a5D5beAnyH
	Wt6fzGIcFU8Mi6KUWyfSN5ScwhLGm55Ey0tq/ntT8GKRCsxVoipFAC4hITlf7RZkcjELIHHhDzHcy
	wZa/fmMB73EfykcfZUiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqh7-0007Vt-HA; Mon, 18 Feb 2019 21:43:21 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqh4-0007U7-6r
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:43:19 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id t128so11938387ybf.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=nczg+7QUtes2Fh3C29CPunHu3OPe6LiRWzK630XjV4w=;
 b=tA43GiiSLoJGWxf2igP3CH2mgYlDyKliVemoFw5JVnpvlNYCKg3RdeT7ytpL74DuEG
 GiXHe3kuSFhEeVcRVbpoixWPO7GcDWmD65EZLNyIZkjD7TnOCTUFSL2Mp78Ss5nh5tLk
 W7BpoALQ4YESMpoG5WvyI3J3Rk7pDDlSNutM8Ol1iAtG8XF146LBaKxSld5MRUwIFbcm
 BBCjD91Q09bgWQx60dGwoP1iy4NY0jEXQfpSj5bCgJHnmdCDe7po9xlTTRw4EL2MZLD8
 t5nL/DfUIBY6IExgHOb9UgDUKL/eJVpan3hjx6cVESa5CMM2/I7VQpzz51b3ORAzKe/C
 Ey2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=nczg+7QUtes2Fh3C29CPunHu3OPe6LiRWzK630XjV4w=;
 b=Fa7nUwGGcggZLA63PjlUSG3wHTkJDqRWXCVMFQukxxvdOnJD6mH/ah/S9k0aphFgfY
 PoV0UH89FW10ru1u/pz1k6cZiE/cCEEFAgJlusLw5e38lKKfxpoR9ZVaCTCSsry5JQ4I
 xwILeTzqWJgXjmy/BFhChowOsvnULRL3i8gUzo1osB1VjRVFiGDJsu6x3Rs1eKdkACAp
 1m6gJ9OmWejtkJ7RRqlrCL2FY3fhfmseVDtNzyKlHZ+a3kLeOLULLobS0NI2nRKQu74x
 jVJWwC5loXbgJHtLsvsQb0UclvOOqyloSEwyOwBivQQS+W3K1mQhCEoYAlLzmNa3l7o1
 Y75w==
X-Gm-Message-State: AHQUAubVaMc0CtI8ciN4dQeHj5KE/VVtgf5o19nMMqpBQ+V1yC7qIYkB
 ky+Zirv9o3eAG+XaeBnuLJfc3HDNag==
X-Google-Smtp-Source: AHgI3IbA7cgyVHRbhKFdKSJfO5KKFkvEQERB0U2tMu97Jn4k3vnlX28TAaUiou6zNuly4Ulh0x5EqqZAUg==
X-Received: by 2002:a25:2acd:: with SMTP id q196mr11133435ybq.57.1550526196177; 
 Mon, 18 Feb 2019 13:43:16 -0800 (PST)
Date: Mon, 18 Feb 2019 22:43:09 +0100
Message-Id: <20190218214309.29985-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] firmware: xilinx: fix debugfs write handler
From: Jann Horn <jannh@google.com>
To: Michal Simek <michal.simek@xilinx.com>, jannh@google.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_134318_279762_290BEF94 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Jolly Shah <jollys@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

 - Userspace wants to write a string with `len` bytes, not counting the
   terminating NULL, so we should allocate `len+1` bytes. It looks like the
   current code relied on having a nullbyte directly behind `kern_buff`,
   which happens to work reliably as long as `len` isn't one of the kmalloc
   size classes.
 - strncpy_from_user() is completely wrong here; userspace is giving us a
   (not necessarily null-terminated) buffer and its length.
   strncpy_from_user() is for cases in which we don't know the length.
 - Don't let broken userspace allocate arbitrarily big kmalloc allocations.

Just use memdup_user_nul(), which is designed precisely for things like
this.

Signed-off-by: Jann Horn <jannh@google.com>
---
WARNING: completely untested patch

drivers/firmware/xilinx/zynqmp-debug.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 2771df6df379..90b66cdbfd58 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -163,21 +163,14 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
 
 	strcpy(debugfs_buf, "");
 
-	if (*off != 0 || len == 0)
+	if (*off != 0 || len <= 1 || len > PAGE_SIZE - 1)
 		return -EINVAL;
 
-	kern_buff = kzalloc(len, GFP_KERNEL);
-	if (!kern_buff)
-		return -ENOMEM;
-
+	kern_buff = memdup_user_nul(ptr, len);
+	if (IS_ERR(kern_buff))
+		return PTR_ERR(kern_buff);
 	tmp_buff = kern_buff;
 
-	ret = strncpy_from_user(kern_buff, ptr, len);
-	if (ret < 0) {
-		ret = -EFAULT;
-		goto err;
-	}
-
 	/* Read the API name from a user request */
 	pm_api_req = strsep(&kern_buff, " ");
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
