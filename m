Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FA020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E3kqdzFO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rF9oQLhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FA020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0wZ9nMq+NgluLmbP4LDyF+88PKBL5nYN63IgzYPDmbQ=; b=E3kqdzFOpB4G+z0PlHvpcXT/Rx
	CjGIH9QPTAwGTzoPPsULT9sGVp1GZx6pboyuy5MWr2Tc168w/+o7QsxLqD2ujT2jrOVtsYAlN0GQr
	AtuOEzXrm2tqHr2SMbozOET5ChCliafz4Coi5AHwPQBKp27e7cy6pGUva1k7XGS5owh+ohO9IsmeA
	EPJMLczMl88s+lgM0WxSvrYVbgbnNMM1iIZS+pQdubaKj02KMMzQpP4MmgOFzMeYFBjXSnKUFU13s
	sW84+E3kyE3vrQ7GRGMtRP9hDth9f2C5WS3i7CzcWA5kHJJ9NRaS2TYyuxm2Vt39R9WvGYs3+naOu
	iRu4CW8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyKSK-0001ia-It; Mon, 25 Feb 2019 17:54:20 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyKS4-0001RU-U9
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:54:07 +0000
Received: by mail-pl1-x644.google.com with SMTP id s1so4822262plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gzq6vfQHzGWyeLb0TiRQKsKtzM247mh6zsfOdLM3MNQ=;
 b=rF9oQLhP90GEfr0vq+e2lst76ilKM4iL70dyP4NE/mU02+65uDyhTG1zCQrQZ2zmkT
 NwZsYlRyyQOQlYc5s7mRl+QiCWLDmdlHlwMJoF/Pmf4oTcadKD92+IKQVvn2BMmtoZtv
 jU06q14WYfnx5nMPV5SxACUIkNyYjQzCtEYL0TIceTGKWA7KD00ZuHH/1emCl7K+6cVc
 OSc35Uv2lSqnsVIcoMC3imDQbKNwuCqRxq0Cq9O7q+p7yfqS6ViTvd25N/iS1zPcQGPl
 GJv/SYtdOaA15QUrX6ykUznfniHVpes/xoUixAuQizPV5C/svM/RSh9zoYk8iysbhGvv
 ia/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gzq6vfQHzGWyeLb0TiRQKsKtzM247mh6zsfOdLM3MNQ=;
 b=O04+bE8shEC4WttxERB0swUzW5wvcCj7gtTX3uwn1+fGxZquARAK05WevLKbWCIB+p
 EDz6rOzx7jfmf2OeLD048KJmBpB6WJCcbGRkTFnSxzHuLsRSU6KM2+/zL/Bdo0sTGx14
 Xp0ao/qFUOOloICSCrQiUuRZSN2V190Qnpx64JHgJPjTkyi8uwF7Y2iI8vaJgMpbrA6H
 wipECT047D/jG79hCR1GxXL9LlrwA88OKhIOzbdXXAJKaT3obrrjyWavKJH+HFtd4CkR
 P5DbMenHd03wAZJX3toM8rWUROfOxB0NU/rjnis/sE7Yf8um2SHj8OXN8mljAGVD2GiZ
 hVLw==
X-Gm-Message-State: AHQUAuZot69V2tr5M4iTv0YvBfWvtwdWX5q0Szmc4qWYYZWHxn58PKpl
 SJvIbLGC8gdY0pausIW53Az20g==
X-Google-Smtp-Source: AHgI3IbvDJnWJuN+Q/1tM5cJoSVVT18nUiZ/7O1aGknZJ8SorMPp2XwcLlm0GbpdqWxi07yuIkj8bQ==
X-Received: by 2002:a17:902:850a:: with SMTP id
 bj10mr21421508plb.91.1551117244186; 
 Mon, 25 Feb 2019 09:54:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm15398997pfg.144.2019.02.25.09.54.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 09:54:03 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/1] coresight: etm4x: Add support to enable ETMv4.2
Date: Mon, 25 Feb 2019 10:54:01 -0700
Message-Id: <20190225175401.26467-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225175401.26467-1-mathieu.poirier@linaro.org>
References: <20190225175401.26467-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_095404_969586_6CC068FE 
X-CRM114-Status: GOOD (  15.48  )
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

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

SDM845 has ETMv4.2 and can use the existing etm4x driver.
But the current etm driver checks only for ETMv4.0 and
errors out for other etm4x versions. This patch adds this
missing support to enable SoC's with ETMv4x to use same
driver by checking only the ETM architecture major version
number.

Without this change, we get below error during etm probe:

/ # dmesg | grep etm
[    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
[    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
[    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
[    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
[    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
[    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
[    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
[    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22

With this change, etm probe is successful:

/ # dmesg | grep etm
[    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
[    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
[    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
[    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
[    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
[    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
[    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
[    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..fe76b176974a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 
 static bool etm4_arch_supported(u8 arch)
 {
-	switch (arch) {
+	/* Mask out the minor version number */
+	switch (arch & 0xf0) {
 	case ETM_ARCH_V4:
 		break;
 	default:
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
