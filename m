Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ADCC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132F82083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkzIo7iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132F82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pW+wnpWups6uLGLSQqFRRJUAjjpOhsZRnnzKoO/Jd/U=; b=HkzIo7iy+sKsbA
	Nn8YKX7wy3G9e5n/PIG5fODCeZtsNmXVQnjdWF6fvcG6TpChu7LpZ1LAJ5rLR/nkkG06Q05PD3UDj
	harSzas6oBZGNBxSjBbEo+nI/hIupydJYIaQi7CLc998iLht3jzZa3t9yMWl8ltIBIMIM9OPrVwkc
	/b9PjE248tiKH+1DhYzdoZtdA4WJS03rIVe4oUqzRp4LmiPOMUt5MOM3x9GcbygKjW9Isbsd9DGCP
	RQ3Ql9AbxqcsaanYjYQ6wVwixrqZZBh77o2DzlS3Ff4noPT55LuVfytxWsWILbfCrgVuGgkCwxSXQ
	PerhXSk9fMNLCB3lAdrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDo4-0001Vw-8n; Fri, 07 Dec 2018 10:56:28 +0000
Received: from 201.86.173.17.dynamic.adsl.gvt.net.br ([201.86.173.17]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDo2-0001Vb-Eu; Fri, 07 Dec 2018 10:56:26 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gVDnx-0001bQ-0W; Fri, 07 Dec 2018 05:56:21 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH] media: cedrus: don't initialize pointers with zero
Date: Fri,  7 Dec 2018 05:56:12 -0500
Message-Id: <dd25052db89ccf292f2a5e45b7e94e8e6d000c40.1544180158.git.mchehab+samsung@kernel.org>
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

A proper way to initialize it with gcc is to use:

	struct foo f = { };

But that seems to be a gcc extension. So, I decided to check upstream
what's the most commonly pattern. The gcc pattern has about 2000 entries:

	$ git grep -E "=\s*\{\s*\}"|wc -l
	1951

The standard-C compliant pattern has about 2500 entries:

	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
	137
	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
	2323

So, let's initialize those structs with:
	 = { NULL }

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index b538eb0321d8..44c45c687503 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	memset(ctx->ctrls, 0, ctrl_size);
 
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
-		struct v4l2_ctrl_config cfg = { 0 };
+		struct v4l2_ctrl_config cfg = { NULL };
 
 		cfg.elem_size = cedrus_controls[i].elem_size;
 		cfg.id = cedrus_controls[i].id;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index e40180a33951..4099a42dba2d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
 {
 	struct cedrus_ctx *ctx = priv;
 	struct cedrus_dev *dev = ctx->dev;
-	struct cedrus_run run = { 0 };
+	struct cedrus_run run = { NULL };
 	struct media_request *src_req;
 	unsigned long flags;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
