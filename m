Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C8C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234B220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WJSFRTnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234B220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QztZmiL8JFMLalm4H0noLsislODVE4j4t1RPF7UmlCo=; b=WJSFRTnw0NGq8S
	JLM9ClqVOxdPDJ7sBZvE8TuokINrGF6+61Nib1LgQO7Tkd1e53DBDop/3OCwAAnubYe+rMjKhCqIA
	DeFFL/RM+POeUTqBO+MqBbpjCGUfxC4Ix9GPwcmZBM9D08BJAk4+2t7J7mAQsQR5sY5IrxygNSLtt
	QYQRjdI3bEfOW19fTJYGPKYeUEJAr+plLmyIw6e4EOcOO93hlN1jSIAHoU/2NniRD4UgphLyZOQxZ
	EqOp8EmZ+aC9oFUzZTOabRJKlKXhBHbUuXYOUhVyhyhLdec+NtW8oTIGmyRow7G+IdGFI///MFyMY
	DVOsjnnGqklhDrJ3PKrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFmt-0001QT-66; Fri, 07 Dec 2018 13:03:23 +0000
Received: from 201.86.173.17.dynamic.adsl.gvt.net.br ([201.86.173.17]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFmq-0001PA-O6; Fri, 07 Dec 2018 13:03:20 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gVFmn-000120-N2; Fri, 07 Dec 2018 08:03:17 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH v2] media: cedrus: don't initialize pointers with zero
Date: Fri,  7 Dec 2018 08:03:16 -0500
Message-Id: <9db60f061d1c577f14136f81af641f58bccbead3.1544187795.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A common mistake is to assume that initializing a var with:
	struct foo f = { 0 };

Would initialize a zeroed struct. Actually, what this does is
to initialize the first element of the struct to zero.

According to C99 Standard 6.7.8.21:

    "If there are fewer initializers in a brace-enclosed
     list than there are elements or members of an aggregate,
     or fewer characters in a string literal used to initialize
     an array of known size than there are elements in the array,
     the remainder of the aggregate shall be initialized implicitly
     the same as objects that have static storage duration."

So, in practice, it could zero the entire struct, but, if the
first element is not an integer, it will produce warnings:

	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer

As the right initialization would be, instead:

	struct foo f = { NULL };

Another way to initialize it with gcc is to use:

	struct foo f = {};

That seems to be a gcc extension, but clang also does the right thing,
and that's a clean way for doing it.

Anyway, I decided to check upstream what's the most commonly pattern.
The "= {}" pattern has about 2000 entries:

	$ git grep -E "=\s*\{\s*\}"|wc -l
	1951

The standard-C compliant pattern has about 2500 entries:

	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
	137
	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
	2323

Meaning that developers have split options on that.

So, let's opt to the simpler form.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index b538eb0321d8..b7c918fa5fd1 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	memset(ctx->ctrls, 0, ctrl_size);
 
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
-		struct v4l2_ctrl_config cfg = { 0 };
+		struct v4l2_ctrl_config cfg = {};
 
 		cfg.elem_size = cedrus_controls[i].elem_size;
 		cfg.id = cedrus_controls[i].id;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index e40180a33951..f10c25f5460e 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
 {
 	struct cedrus_ctx *ctx = priv;
 	struct cedrus_dev *dev = ctx->dev;
-	struct cedrus_run run = { 0 };
+	struct cedrus_run run = {};
 	struct media_request *src_req;
 	unsigned long flags;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
