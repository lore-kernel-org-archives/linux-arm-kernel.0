Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C5AC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6530217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDsmUtnD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tFTcuipl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jl0+3mCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6530217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZvmodMe2c1JfbyaAup/aRAc30bs0znfEd7l8N8cQZJ8=; b=PDsmUtnDEtsb3w
	fZvj5iNMkRxs+knixFo4tyYvohmPYz0McJg7FCR3n52tt1xuiShuOt15r6DEzUMBB1ZegCUDTnsEX
	WKf1Y5wJ32V/+1gUJF61vXQTu256fvJOqleN/B9Mn1VuTy+Xh5g8bACMJVsJ0U4HG5VjoafTIAMRA
	+dErV0/1BJ1gLJnhB2sa6rdIb+KpCpx26ttWilUZy4ImnSVpjJRT15Ab8IUL4lzjG+Qyg0G5x45Dv
	SlV5I4QWWaWBtXTLoh/9W4HYnxcBy1vF3Celb1XP51t1ehu7zx5pyINUzNjLIBxV7gZgpD2GQPhdi
	q8JSahG1hdxBeo8ffWQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlS9-0003bU-3h; Thu, 24 Jan 2019 20:18:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPn-0000xZ-6a
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=; b=tFTcuiplGgnTlh38loqVQILdiq
 nrLFuNn1DsyoboqkECsqgX72dTbGYth3QnLZ4POq3F8eeZraoIRi6iTLuRZY7JhTZQTaweMREYiNI
 /J8mr+aenOE17caiXuwmHqr7Y7wKb9wWqLF3G4kukJw6YpSlVE/JCP71JckEXeZrX3PjdpsssFcw0
 AR5tJ7Bb/5k0C8RHHol1YKTcLPPCy6tz4zKdQ8TwxEXSQX4x5OvH5bMRD617/rwKipw546hdIctnu
 QYPesl1ejIFYDsCwJ03dVko3T7HBWxR/5PFZG10YsyHwcUAPc/zJ/71v2dBzfdBUcHfEXmYC8glXY
 jAKChhsQ==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAd-0001rt-Oe
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:17 +0000
Received: by mail-pf1-x443.google.com with SMTP id c73so3510057pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
 b=jl0+3mCU+nCI7YGq+itsqShkC/SfgVti3hEQ1ulSvukcgTB3ChDjHL1au/xyTtFmei
 gQYNExKO3Imrr0vQPZTTFzsBWG6MQKp50I0UaMarYeGQsx7pcN3ZG13p/jAWqjEKAxqo
 po5DR55psBPduQb+2DpXUqolNrzeewmlxyKzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
 b=gdARuSzOGxd1GpqD1kiagJFdTjLmiu/o/R5F90LPkCp99DDjDtPl+/ySAnO8XFpZ1x
 YTQXZtZpe3micq/uorL2tHy6VDTsDwXGCIv2muminlbRzjKZs28XbyMjzMydBdTXmTH5
 b1vMKqTeSZ8mRS2ri5ugwyZohRi86F+MB31yM7IY9tBdFwYsHmWduQb9/S89V+OOp0OV
 aByg9/RBh/FQUfpQrdk/IkJLIc4s1qD3xTZON8Nao5pYOaVGCLNJns5Sbf87YQLCGuvw
 ddrBfKLzVLUjfy4s62d9ydq8tCuiwRvXzLCuOL7CIyHTlshAq8JyXp9RS3qtrmbwftvy
 NFyA==
X-Gm-Message-State: AJcUuke/LsZjVICLRy8oQTBXUCk0eWGWCR0kEHPcbUdN8wIGox2Grhxr
 IDGRU9dLr5AbLvsKAOEJA0SjIg==
X-Google-Smtp-Source: ALg8bN4X3/hdgvk+W8P6tImZrbs+xvmgwlVFgfOK7unjfkPgCq8ckI457VZI6BJ2wPT55mSjYoPRvw==
X-Received: by 2002:a62:3943:: with SMTP id g64mr7995857pfa.114.1548360012725; 
 Thu, 24 Jan 2019 12:00:12 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:12 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 10/22] clk: sunxi-ng: Add check for minimal rate to NKM PLLs
Date: Fri, 25 Jan 2019 01:28:48 +0530
Message-Id: <20190124195900.22620-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200015_811659_EA5825FC 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some NKM PLLs doesn't work well when their output clock rate is set below
certain rate.

So, add support for minimal rate for relevant PLLs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 5 +++++
 drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 841840e35e61..096ff4f4839a 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -125,6 +125,11 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
+	if (rate < nkm->min_rate) {
+		rate = nkm->min_rate;
+		return rate;
+	}
+
 	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
 	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index cc6efb70a102..ff5bd00f429f 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -35,6 +35,7 @@ struct ccu_nkm {
 	struct ccu_mux_internal	mux;
 
 	unsigned int		fixed_post_div;
+	unsigned int		min_rate;
 
 	struct ccu_common	common;
 };
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
