Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4672B20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lJQchRJy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF3DXd+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4672B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ilpeG64+88uLNPxdkBLUmPSwVO0lxOXsrrTPCtMi4dg=; b=lJQchRJygkup948S5sQlTGUsM5
	RqC2OJXpO+vmoCYpG70gibtrMTTQ8Qwzvj0jkOXk/hT3NUQ/3TVMjI8P6fl3TkevTS5/6CgGAotWR
	K/W8wc/apB8Vgpinf96rA3YKnibwZSjTI0uMsi9UA5hITMgnFJhJagCuBMtrXfSpPPevqEdgiWt5D
	WEsp3uFtdH723GiC8oMdwLkTfaG8elWYkpFAxIhyxOLus4ofQdvpeCkM9q4rHIfizHkZEyC+RrSNs
	vxJEHCl4f9BQQCjs50tnFNi0fYjk4hFQUHUfo7gaajwYUc5xCtbBIp3UCHgT4Aazb5oY8lgIWPhv9
	ltwe4hmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnnE-0002xD-Fj; Fri, 30 Nov 2018 18:45:36 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl2-00008b-Nn
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:23 +0000
Received: by mail-pl1-x644.google.com with SMTP id x21-v6so3217301pln.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YQ8V65+iAbYCwafIxsu/qixXdC63ZH4JkQ5OQ19U4Gs=;
 b=iF3DXd+2Blda6rapqabTdvaXC2MzxGz9RMkey1xEMGRqu+T9w5m4YGfGPH7bRGrg9q
 HiXRadkTk23UznKu4S+xWuuNO6BtKV5M2tF3Ev+Hmd8TJKHzEHqP9h9CgVfl+JossOhM
 Pncvrrq6by1HknrOi47aKPXVs5HRLMbRO7sTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YQ8V65+iAbYCwafIxsu/qixXdC63ZH4JkQ5OQ19U4Gs=;
 b=ArV4pXTqdcwx+9/R/MUg/ntLH5U5NHQMj/a5Z7xgB9sQlwl/5ziBYejWgZGKRfXTp2
 ff0AMEkVLMD8amJ3Ifr+ijsYe7anku/asEdDZqC9W2AaKAlkW54p4ZLIka/TpzcMTpkR
 wyShHMukKwsiNk/xG6p21mlFaYiGnSbCa1iB4Nx5g5TczLEAoYBz3RYiQ3zgXvxUVbV0
 pKqv97vWY+uupI1rEjNhB8YwzfI5Ro9W7sy6+nRWCFSUbq6cqMX0fsN0xLE/E4szlpm3
 RlRYbjZYVeGTX9e3bG9TkjxqvohniyC1cir87Qsq5dg0iu6f5qQrQygTzgVM5O7GpRI/
 STpw==
X-Gm-Message-State: AA+aEWb7a1XhBKIeILobxX4rHfZOKWhuPA2ZWnltRKOuQIIOpfn8aapL
 eKg7gW7ens+NRbeIqjtt3j9iIg==
X-Google-Smtp-Source: AFSGD/VALCb2sV63kLNOIYaARePo6KW+5Uswi9iWGnIpsSkgaT+Dm+bRhO22GrKkrk/iOVvRTz6YcA==
X-Received: by 2002:a17:902:59c8:: with SMTP id
 d8mr6794781plj.116.1543603390155; 
 Fri, 30 Nov 2018 10:43:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:09 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/6] coresight: tmc: Fix bad register address for CLAIM
Date: Fri, 30 Nov 2018 11:43:02 -0700
Message-Id: <1543603387-32645-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104320_772163_3039E9F5 
X-CRM114-Status: GOOD (  16.88  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Commit 4d3ebd3658d8 ("coreisght: tmc: Claim device before use") uses
CLAIM tag to validate if the device is available, it needs to pass
the device base address to access related registers.

In the function tmc_etb_disable_hw() it wrongly passes the driver data
pointer as register base address, thus it's easily to produce the kernel
warning info like below:

[   83.579898] WARNING: CPU: 4 PID: 2970 at drivers/hwtracing/coresight/coresight.c:207 coresight_disclaim_device_unlocked+0x44/0x80
[   83.591448] Modules linked in:
[   83.594485] CPU: 4 PID: 2970 Comm: uname Not tainted 4.19.0-rc6-00417-g721b509 #110
[   83.602067] Hardware name: ARM Juno development board (r2) (DT)
[   83.607932] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[   83.612681] pc : coresight_disclaim_device_unlocked+0x44/0x80
[   83.618375] lr : coresight_disclaim_device_unlocked+0x44/0x80
[   83.624064] sp : ffff00000fe3ba20
[   83.627347] x29: ffff00000fe3ba20 x28: ffff80002d430dc0
[   83.632618] x27: ffff800033177c00 x26: ffff80002eb44480
[   83.637889] x25: 0000000000000001 x24: ffff800033c72600
[   83.643160] x23: ffff0000099b11f8 x22: ffff0000099b11c8
[   83.648430] x21: 0000000000000002 x20: ffff800033a90418
[   83.653701] x19: ffff0000099b11c8 x18: 0000000000000000
[   83.658971] x17: 0000000000000000 x16: 0000000000000000
[   83.664241] x15: 0000000000000000 x14: 0000000000000000
[   83.669511] x13: 0000000000000000 x12: 0000000000000000
[   83.674782] x11: 0000000000000000 x10: 0000000000000000
[   83.680052] x9 : 0000000000000000 x8 : 0000000000000001
[   83.685322] x7 : 0000000000010000 x6 : ffff800033ebab18
[   83.690593] x5 : ffff800033ebab18 x4 : ffff800033e6c698
[   83.695862] x3 : 0000000000000001 x2 : 0000000000000000
[   83.701133] x1 : 0000000000000000 x0 : 0000000000000001
[   83.706404] Call trace:
[   83.708830]  coresight_disclaim_device_unlocked+0x44/0x80
[   83.714180]  coresight_disclaim_device+0x34/0x48
[   83.718756]  tmc_disable_etf_sink+0xc4/0xf0
[   83.722902]  coresight_disable_path_from+0xc8/0x240
[   83.727735]  coresight_disable_path+0x24/0x30
[   83.732053]  etm_event_stop+0x130/0x170
[   83.735854]  etm_event_del+0x24/0x30
[   83.739399]  event_sched_out.isra.51+0xcc/0x1e8
[   83.743887]  group_sched_out.part.53+0x44/0xb0
[   83.748291]  ctx_sched_out+0x298/0x2b8
[   83.752005]  task_ctx_sched_out+0x74/0xa8
[   83.755980]  perf_event_exit_task+0x140/0x418
[   83.760298]  do_exit+0x3f4/0xcf0
[   83.763497]  do_group_exit+0x5c/0xc0
[   83.767041]  __arm64_sys_exit_group+0x24/0x28
[   83.771359]  el0_svc_common+0x110/0x178
[   83.775160]  el0_svc_handler+0x94/0xe8
[   83.778875]  el0_svc+0x8/0xc
[   83.781728] ---[ end trace 02d8d8eac46db9e5 ]---

This patch is to fix this bug by using 'drvdata->base' as the
register base address for CLAIM related operation.

Fixes: 4d3ebd3658d8 ("coreisght: tmc: Claim device before use")
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 53fc83b72a49..5864ac55e275 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,7 +86,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata);
+	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
