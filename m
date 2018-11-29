Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A19C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2425F213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nPKB20/3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHuUacui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2425F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T2gKb9UzklGBj26s1BGiaJp7OuAHgoXovtvFBin5dT0=; b=nPKB20/32N+Xh1
	eqm7bx7cS4ZIANkYxrgVa0iX9C7rMvq7pkAn1oV2Td1Egkizejsa3qO8pGmnFACvkLK1vGIxft4h6
	0gCt1BLVPhj/VJ+z4IFWW1/Uzh/2GsMixJSvQknZRyYphhCKlOZPy3TxLixmzExHT+eubbKW7QiWM
	QPHzqLL86CyPaw/mO1adSVohNuWsKwASSCnUbdRlUT58RALhkG6WUXNJ13/745YUFhCaVH/LOEJjJ
	tbPNsLC1Iz6qNDy9NE6RyCFKyEdg4EPNnJ3q3FVYEaoc7bS6Nxw+9ym/9xDQfTKa2+0novRNXyBLd
	GvLCnDPFCBaEhUK0QTFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPKt-0003GK-Fk; Thu, 29 Nov 2018 16:38:43 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPKo-0003FB-RD
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:38:40 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so1310509plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4KAWB8thmpYH1WwjCgumPIS1PyiX7+UJj97tYgIK5o=;
 b=ZHuUacuiSSYMQEtgRUiXKlj3vykdcFrM2GcB2KYfq7rKkw8B3kfMoDOPlUyuekZ1BL
 10x4k4jwYAZhq9LHCN1sh0lhH7vuZcXVjqXot5mt9c8q3y7TsMJtxDTdBlexFrFPUfGy
 P+/orrYrGhSDcz/uIykP7tGUzT8p+hyRF5qS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4KAWB8thmpYH1WwjCgumPIS1PyiX7+UJj97tYgIK5o=;
 b=QC4I4A0gUeAkHpOStc6ZUP3EDbbwQmOD2RPrAzs/IXqvDVkhcHbtUY+uD0rjeuBCx9
 1AbqZLygDIvEmEY/5bxtceoF3Kx16crfA7Yuip6pxdQfY97FtfOZ50vzn0MdYPfQGbAq
 Y2kzZkerMgslbINaR9/wtvGLLCN9poTf0Ue11nYp3Mbqadn1sKORJ1lu7Y2Zo13V0cYe
 FndNF7N0VCcKQZ0mncK7MBFBfo2nZRUoR9BqCbXDXQ+hqXpIh+DwDjKR0HR+N+PcqnNc
 OHU+R2CLK11dnGADPqzTY3psAlalLUHOnw9chVAeyqov6T1j2evh9uYlx1LlHlKfDu20
 Tarw==
X-Gm-Message-State: AA+aEWYtn030W49/+nixGxEBzx9aH2J/XwyjJDxiwzNWkDJYmoVsFTYz
 4xJAOv74VUVLVOOUiZ9zsygnfA==
X-Google-Smtp-Source: AFSGD/Wsg40NT0WJBkAv5b8UhC82zU0+NQCzi6mFuMdjDjr6DS35UublCovKp/d0QS/0dJgUMQ2Djg==
X-Received: by 2002:a17:902:5a4d:: with SMTP id
 f13mr2219688plm.49.1543509508040; 
 Thu, 29 Nov 2018 08:38:28 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
 by smtp.gmail.com with ESMTPSA id s37sm3033836pgm.19.2018.11.29.08.38.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 08:38:27 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Date: Thu, 29 Nov 2018 08:38:26 -0800
Message-Id: <20181129163826.178670-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_083839_221479_456D67F6 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We need to check the call to cmd_db_read_aux_data() for the error case,
so that we don't continue and use potentially uninitialized values for
'pri_count' and 'sec_count'. Otherwise, we get the following compiler
warnings:

   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
     pri_count >>= 1;
               ^~~
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
[-Wmaybe-uninitialized]
     sec_count >>= 1;
               ^~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 8cd294e2846d..b450f7ea0422 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -936,6 +936,8 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	size_t pri_count, sec_count;
 
 	pri = cmd_db_read_aux_data(id, &pri_count);
+	if (IS_ERR(pri))
+		return PTR_ERR(pri);
 	/*
 	 * The data comes back as an array of unsigned shorts so adjust the
 	 * count accordingly
@@ -945,6 +947,9 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		return -EINVAL;
 
 	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	if (IS_ERR(sec))
+		return PTR_ERR(sec);
+
 	sec_count >>= 1;
 	if (!sec_count)
 		return -EINVAL;
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
