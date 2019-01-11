Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB936C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D2C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qvbSfSv9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTY+B/W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D2C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+/4Z4hyIXAHqX4KF1soWAf1D8HxIyMI5Pu+vohcMLh8=; b=qvbSfSv9gnpeFZ
	y3DjH9eH82nR/LZns+1ZZUh/Nd5oUtby9siKxPM5R5frOKt/r6xAC3xO0dOLsXYBzhouNe+naa2oV
	Uw5LlKvAXhtKHz5ykCdX8YUutkmblEJjIudc7b0/6eLQpaBwm87v18QF0SSa2LPnRJ5yZ4d04apnN
	xEBSd5d8bsECoZ6AQWbSpW59z+nByFQ4/98KDxLfURTIqKK41yFf1JivhG/NvVcOFpbjiHfojYq8Y
	Pegnc/8w40YZ+VvqpxqYV4vDxjuGQm6A+K/QJAcnho61YA64Z8AavnaOqVytlHzAru1HkpWIzz3Rt
	zVhvgxbSjc6RGoQRy1mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghrQp-0003lS-1n; Fri, 11 Jan 2019 07:40:43 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghrQk-0003kD-KD
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 07:40:40 +0000
Received: by mail-yw1-xc42.google.com with SMTP id d190so5445194ywd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TBgWp63Kv6t3+fUjxXQ9v9EObO/heZdTlQolaOmCRss=;
 b=JTY+B/W03GKr2/GYBLMU+FyBkFGcYtKHZ4Av2ISvaQHiFqDdoaDz/o4oxpQ6CVZpBU
 pbXLhc6PcqocHkvWR+wdnqQMXt8YpZ66kfs8ggnhmQcMwEcdqUCdtkItkCLCrwvbLED4
 Pl2ZT7xcskAw7sek7eow+l2OU1Al0UZMzKfwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TBgWp63Kv6t3+fUjxXQ9v9EObO/heZdTlQolaOmCRss=;
 b=YXfgSM4a2VlOVMpLL+2yIKJB1wGulr65GgaBEnHe3SM0X1GO7B4ukhSOpT9ykuW2CC
 CB3rwVjXlfLRzC0jJ1zVCcODMzP04fGAQWKnfrEoDQwBaD03EF+XdRminyQFyongXn6l
 x0D31rXnRzaU5ERrzu4mS43FfisgVCKfzd6fSwajreD4rO/t6vbS9snEy0T1R6dDcmS5
 N/1h+6x/waLyFjDjxGGo6kknuJGxOZSwbNcEN64UjvBjxZikDkS4DZunZ1NqaONGOHSJ
 BbP8RM2HAn+LKBEbPOTzFyJVH8QwJuYIudTN9gL0tL3kYYkDvITPreCGkOtuEbQcQV+v
 T5og==
X-Gm-Message-State: AJcUukdIsMHheqXSNxaQ4PSJtki1nRPgE+PEE7XGpvVS7DP9lwVv3kOR
 nvib1/Uwm3iZLlj6PmAfQ3H9XA==
X-Google-Smtp-Source: ALg8bN5eWG5t9NbVVuTxNi9aomZQ9rHMonocs4eWlo7f13FhpaGFfbiXDhxK9jDxoR4dZsDq9yHIJA==
X-Received: by 2002:a81:6b57:: with SMTP id g84mr13072469ywc.108.1547192435679; 
 Thu, 10 Jan 2019 23:40:35 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
 by smtp.googlemail.com with ESMTPSA id
 k127sm45492642ywa.81.2019.01.10.23.40.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 23:40:35 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH] arm64: kexec_file: return successfully even if kaslr-seed
 doesn't exist
Date: Fri, 11 Jan 2019 16:40:21 +0900
Message-Id: <20190111074021.23639-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_234038_657939_A4305095 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In kexec_file_load, kaslr-seed property of the current dtb will be deleted
any way before setting a new value if possible. It doesn't matter whether
it exists in the current dtb.

So "ret" should be reset to 0 here.

Fixes: commit 884143f60c89 ("arm64: kexec_file: add kaslr support")
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 10e33860e47a..f2c211a6229b 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -87,7 +87,9 @@ static int setup_dtb(struct kimage *image,
 
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
-	if (ret && (ret != -FDT_ERR_NOTFOUND))
+	if  (ret == -FDT_ERR_NOTFOUND)
+		ret = 0;
+	else if (ret)
 		goto out;
 
 	if (rng_is_initialized()) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
