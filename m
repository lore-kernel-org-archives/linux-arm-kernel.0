Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E30C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5277E218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gxrto1um";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbqF7rO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5277E218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bkt2Up/+XmBRFYfLg5DcViM3TlelM3ylihSd+9ODBhE=; b=Gxrto1umEzbSO1H+TtQik38VqX
	JJnlCBx5dLnAM7L87zBr0zIq8lYYghuC0+LTJWaliWWu6GGCRFnhFHx/7KCKcO5IyZVOQ1C3oIm+B
	oO2iMbSiuMkR/X0CPU8R/YuQY5roNEdHRub6qFuQlqwflehFxzruZOB+rGhrG/tb/YVDQ2ncFiNJJ
	DERN9d3+IT7+FfNtFH4beCXT2fkrxExCGs8onIfQ1R+CaZIqLb+Zy9DBcH0Pwp1jAL2auBDFCn/SK
	lO2je2Ha9XSPcLRfnxr6opvoYlomEuNWxMch3Fie7kXjTHzm53k2d2L92FDj1cFG/sP4+AF4nTeF9
	syJHImUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaus-0008S3-RL; Fri, 01 Feb 2019 15:39:42 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpauO-0007rW-DR
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:39:18 +0000
Received: by mail-pl1-x642.google.com with SMTP id u6so3376483plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tJ0vVOL8XD9yWBH7fkHAUlpmy1k8wF+axXxeAyBhZsE=;
 b=YbqF7rO3XIv9/Gh2ZRe5z22Mt3MOBU5/xMQRWkCA5MMMIftPZdOknSTxzLdaPkRMZW
 DKWwTa/TauZYrWDCtNTUw2+z+AGiUTRPsteQMlhjGsAPEe+YxozS9eDgqYcPDx91X2uV
 Hyq7pM3LidN+yC88pOFL6VmfmF+G2wRqKS3FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tJ0vVOL8XD9yWBH7fkHAUlpmy1k8wF+axXxeAyBhZsE=;
 b=eK56t5zfWy3/a8uoUZkOlnkh1Y1zCinU5oOXKS3FO/j7C6Bw72qParh96Q/pgkZK3F
 xpj6xhqQbdFlCmQwWG3RTTOj9HSAP1IJznNhw1nKkyVACpku1mvuPrnMG7AKY1M0iDhi
 8MrWFcOYNO9+OIHvNnvNztPivCh3KZnw8HuPGAXxjcAz4CoA+IA/hFsiQCrawtZ9q7Or
 7ThCidu2YV7GpH0lT59NO0DvJynU39exspVWKM/th984aEz2AC2m7oFl71wF7OOaICof
 5xiU77kl2Sei2tfgxqGI6W3qCImytm+nXVrbw6ameWY0HqDmOmw6TTSTVLCY5B33ysMa
 cY9Q==
X-Gm-Message-State: AJcUukejUhrD420HyxCrzHuSoVggYu636E+p5M6vfPtSNJFaXyJ23TkK
 kwmSqszACAuEgmPXdYIH9irk
X-Google-Smtp-Source: ALg8bN6+HfmmOQ85GQbZHWRafETMzY8x00axa1Uv2OdB9M2YxpRZzGYf9AbXQFfKG/DWKoKKzwACqw==
X-Received: by 2002:a17:902:4a0c:: with SMTP id
 w12mr40360250pld.8.1549035551741; 
 Fri, 01 Feb 2019 07:39:11 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.39.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:39:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH 3/3] reset: hisilicon: Add HiSilicon HI3670 reset support
Date: Fri,  1 Feb 2019 21:08:41 +0530
Message-Id: <20190201153841.21903-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073912_790089_88C63C1B 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, add the
HI3670 compatible to HI3660 reset driver in order to reuse it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/hisilicon/reset-hi3660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index 17d8bb128e6e..1c22f3457ba7 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -103,6 +103,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id hi3660_reset_match[] = {
 	{ .compatible = "hisilicon,hi3660-reset", },
+	{ .compatible = "hisilicon,hi3670-reset", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hi3660_reset_match);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
