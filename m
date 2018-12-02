Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA0BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE75D2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vt3V7AMq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGJaLXGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE75D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7kCRstV6ESJf/zv2QAwa8vYbQMdurYU9XMUyYRudVnY=; b=Vt3
	V7AMq+TPRNj40fMFVrnBVesJw6FFdOjsBd/WZrBgBC1Qqy30d34yiEsN+cXaxk/Uf9ZoxW3ATXh5U
	WgQMD7yiqip2UBMhA9pyPnQ31ugOonxZtJqi8UDEUfXGxBiUSnjcoNKAVpAbmUaK1/6na+mrZxlZH
	xKIEjbTJmQ212I7g0D8d744xios2f6uxL52U42Dv3WNHuPkgr+AUXnhHWjsuld7GTGDDXLe6/Eunz
	mI0iwIF1Fr9cTKbpimUH36652qkDdiDPygDmEN1esEsZvpxJORYF9vRGW15Ca6nB6vC6yqsMDLjAi
	TAYUwVPxfxQU+UEJACdTMix4uW8/0HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTHK3-00021i-4T; Sun, 02 Dec 2018 02:17:27 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTHJz-00020g-Fx
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 02:17:24 +0000
Received: by mail-pl1-x642.google.com with SMTP id a14so4671955plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=74FtgDJCxbK06huEL3MZAZ7K0y7aPnoVSsRLCnp83Ec=;
 b=EGJaLXGG7Jll2uq2jTGzWkE8djO+6X7yw0TdMuT2i8V6sQ887ptkAWGY6FRKCDqecC
 JrjiVRsswyItHgLPbliKP7UA7Ug2y0E9jxa321BATtAX8yRKkA4NDBpqa/UMip3OKwKa
 dIiN9x3QrhUFeLK+IDP8ZiUM7+5XutMVpuzxF5mCN8fu1FGGVJ2IQazGP4Qe3V2fJ3HD
 hsgcvGUm5dTUcYfMJD952Bi+484Qyko78a/AigsmaSkLtHvlV+6lpCbD3fQMmVLKHuXa
 bmU6CZ55Lf1Q6bqRFFlr2bThs8HFCbN4+IBoQJ+lnZzk4Nz1wsIhLLtLL8ts9mvDtmPy
 hKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=74FtgDJCxbK06huEL3MZAZ7K0y7aPnoVSsRLCnp83Ec=;
 b=oeU0zEjcUNtfgPWwwJOGHbrs45w3Gocx8zZkJhZAo5InEkntFpFbPpXOnDmp2ljtdU
 QYcO4AdYzmI0K0F0f2Mi3jSfIFOYU9FKs9GuNdUIztVw5jYDDz2N3aSjHmxhEVFF9tQq
 k1kCkiwJFoY38BSGMWQv8TSKqKTmY/ctR3URSHagS9ooxCQgX6sy2WV33y86I+N5YL6p
 /6D1yNkybCr+Bsd5YAm5uzCE3V6dxDb15g7Lbm+HEO1JEn7NfL1LbBv1Ql0ula5h/ucU
 kcrFcXji0c1/zx36UenUzGzHN9JXqQAzHVf5WtAdYlMFJNGqHTC1Kj8abCUIQQMib+f7
 bKrw==
X-Gm-Message-State: AA+aEWZmLgJd6JOPmfwE5kXp0QkAAGGCU76zVbgdorRL2OJ3R1FEdXhh
 f1BYR5nnG7nCXwdFf8d/SKTRrTCG6HY=
X-Google-Smtp-Source: AFSGD/U60wrNZPIKrxzonQI8BBmQ39wcKYN3FCZcRYCL3ZtVt4qTXvQH/dx/frJ5rSnvDqcRt4qcRg==
X-Received: by 2002:a17:902:704b:: with SMTP id
 h11mr11177183plt.157.1543717032500; 
 Sat, 01 Dec 2018 18:17:12 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id v76sm24947293pfj.145.2018.12.01.18.17.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 01 Dec 2018 18:17:11 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: linus.walleij@linaro.org,
	lee.jones@linaro.org
Subject: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 21:17:10 -0500
Message-Id: <20181202021710.9307-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_181723_532896_B54D8309 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mfd/ab3100-core.c | 15 ++-------------
 drivers/mfd/ab3100-otp.c  | 16 +++-------------
 drivers/mfd/tps65010.c    | 14 ++------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 099635bed188..3fe448a29389 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -451,7 +451,7 @@ static irqreturn_t ab3100_irq_handler(int irq, void *data)
 /*
  * Some debugfs entries only exposed if we're using debug
  */
-static int ab3100_registers_print(struct seq_file *s, void *p)
+static int ab3100_registers_show(struct seq_file *s, void *p)
 {
 	struct ab3100 *ab3100 = s->private;
 	u8 value;
@@ -466,18 +466,7 @@ static int ab3100_registers_print(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ab3100_registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_registers_print, inode->i_private);
-}
-
-static const struct file_operations ab3100_registers_fops = {
-	.open = ab3100_registers_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_registers);
 
 struct ab3100_get_set_reg_priv {
 	struct ab3100 *ab3100;
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index 55b207a4b336..24873e1ae865 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -96,7 +96,7 @@ static int __init ab3100_otp_read(struct ab3100_otp *otp)
  * the contents of the OTP.
  */
 #ifdef CONFIG_DEBUG_FS
-static int ab3100_show_otp(struct seq_file *s, void *v)
+static int ab3100_otp_show(struct seq_file *s, void *v)
 {
 	struct ab3100_otp *otp = s->private;
 
@@ -110,24 +110,14 @@ static int ab3100_show_otp(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int ab3100_otp_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_show_otp, inode->i_private);
-}
-
-static const struct file_operations ab3100_otp_operations = {
-	.open		= ab3100_otp_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_otp);
 
 static int __init ab3100_otp_init_debugfs(struct device *dev,
 					  struct ab3100_otp *otp)
 {
 	otp->debugfs = debugfs_create_file("ab3100_otp", S_IFREG | S_IRUGO,
 					   NULL, otp,
-					   &ab3100_otp_operations);
+					   &ab3100_otp_fops);
 	if (!otp->debugfs) {
 		dev_err(dev, "AB3100 debugfs OTP file registration failed!\n");
 		return -ENOENT;
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 2ab67386b4ef..4202b5c40f18 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -192,7 +192,7 @@ static inline void show_chgconfig(int por, const char *label, u8 chgconfig) { }
 
 #ifdef	CONFIG_DEBUG_FS
 
-static int dbg_show(struct seq_file *s, void *_)
+static int debug_show(struct seq_file *s, void *_)
 {
 	struct tps65010	*tps = s->private;
 	u8		value, v2;
@@ -296,17 +296,7 @@ static int dbg_show(struct seq_file *s, void *_)
 	return 0;
 }
 
-static int dbg_tps_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= dbg_tps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug);
 
 #define	DEBUG_FOPS	&debug_fops
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
