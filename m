Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C76C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263002084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFpLtJKO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DULst49i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263002084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CgutxfIDSUAAdcVRpKz7ZFtEZRDbbDrdIRxd9v1BvkU=; b=BFp
	LtJKOZn9DOYAhLtcfIXjIhMQ9AQrJ+tvjxNkj2i+y+r+qWdJ7ScqODX+7ZQp22eq9LWzrBLAFviqv
	LF8Rm+S0SKIibAbUZB1k5VHZbRl7+SgCybIxiRZJmrgz1oqW7gUMzTlfHwAaPgO6RZ9ZJt31nJQRX
	lPfbM9Ptl4GD6jb5jlu7x2qKO0QrKsnkGVjV8ahn2vDumJFNK1NBPOM7utkV8Os8a5KbW/coJxq8e
	JWd+oclGitHMxvOB7yDIoHP/hLwMjImLnio9CoNtciGpZpNEYkPx8ABMIw+yAaMqNrVOEEIK1s+VR
	ShXZheyS/e+RDgUVQh2tjPKP0eHL3mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY5pC-00043C-S4; Sat, 15 Dec 2018 09:01:30 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY5p8-00041n-Tg; Sat, 15 Dec 2018 09:01:28 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so3835077pld.6;
 Sat, 15 Dec 2018 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Su8n08XRlyKs97RUCXcwmzT3Jsdm0K6ctXziX1UaMAk=;
 b=DULst49iCyZ7xVT7jW9S4FwmOPcFhWnVvVJWAPIr27fnqvvTS5+Pz1/XjKmOSAMaKL
 1lrBQ8It1XtIMTMICJBecC4fbqJ15Pien5jkQSNvXP6PMN7YyxfMxJlDAOKcwQzGNoWA
 5bVmdmNXHlLJc9aiN1mDbflTbUpQmyxxvlAiBIgFvTGlKzohMU/okAJIlZVllFL0HNRZ
 jryLinBSnuG+Mof/iAVVVftagqWNxBTZuXbK1OyRsx4fojV3OkLqE2H/5hvcMhEjQCRT
 GHfp8rdEThQXhSWqNSTMoOH4qB19bN8sI11rk5QLuB52I+GdYrAS/xIUZ7UZ0CiBQsSe
 iSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Su8n08XRlyKs97RUCXcwmzT3Jsdm0K6ctXziX1UaMAk=;
 b=nhaPglT0a5ulQ9ff2WMsXWVQiG2QMg8e2VDb1xRvstcSiLSfG3lWV57kChpImmOEA1
 ABmp992eZ3ht31+pMnP8MXo5mLmcf90UKEn5r9cRjmnxVkMlGDgNE8Mgji+cZV2WXlhf
 h5K/V5IrkncOLC3+31JueLs5jRhT1OLZK+2z5gvKFcA66d/8BpaP/OyvW1nRiSld4egC
 s2rG27Gr6+HB2RSG39at9wdt6r5hzAFQV1AjAb364BZKn9kZaNyDoAPgSVnQRbGDvh+4
 V2zE7LS9fU8DmI/T1VjkVh6TWeyqxhFRC78R/a2lMJ7WBKgL3cAVZWE7M0G8zQV7C/3E
 xHww==
X-Gm-Message-State: AA+aEWbG2WtvK+FR1GV1vAztRqBees/ZQ3484+gkHZV0bYE3qVpsHNba
 +CxfEiFxomNAOzdEAu4PNj7H4I3Ndl4=
X-Google-Smtp-Source: AFSGD/XPldE48M9ROqu+va0waBSk1lhcnhZKtKwK3eJIUlRfqw8beYYSbu5EzBQTwU5Giyp7UpkT1g==
X-Received: by 2002:a17:902:4225:: with SMTP id
 g34mr5929460pld.152.1544864475852; 
 Sat, 15 Dec 2018 01:01:15 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id r8sm8170734pgr.48.2018.12.15.01.01.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 15 Dec 2018 01:01:15 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: eric@anholt.net, stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
 colin.king@canonical.com
Subject: [RESEND] staging: vc04_services: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat, 15 Dec 2018 04:01:13 -0500
Message-Id: <20181215090113.27847-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_010126_956117_E731C1B0 
X-CRM114-Status: UNSURE (   9.13  )
X-CRM114-Notice: Please train this message.
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
Cc: devel@driverdev.osuosl.org, Yangtao Li <tiny.windzz@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../interface/vchiq_arm/vchiq_debugfs.c            | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 6a9e71a61142..46ba21967820 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -153,19 +153,7 @@ static int debugfs_usecount_show(struct seq_file *f, void *offset)
 
 	return 0;
 }
-
-static int debugfs_usecount_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_usecount_show, inode->i_private);
-}
-
-static const struct file_operations debugfs_usecount_fops = {
-	.owner		= THIS_MODULE,
-	.open		= debugfs_usecount_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debugfs_usecount);
 
 static int debugfs_trace_show(struct seq_file *f, void *offset)
 {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
