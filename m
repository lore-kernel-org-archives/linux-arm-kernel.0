Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63404C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:01:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EE6217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QT2T0Q5b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="is/daVOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EE6217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2LbRoHD10Lj+aaoTBndZmRZpluUIpA1tYyLUi2P5JpU=; b=QT2T0Q5bKiKylH
	MVB0IuaTZFO3IdSfl5gDTvG9MZ5POzUL42e64kju0N0gvNADkr00HMQphFOzDYwOxPvr8DP8fda71
	r1sVU1h0QVBHGRYpp57zUt52xZv43z8s3hJVPtDExxpzNLNf/LZqfOiiBRQuEdZP/sX05v1K9iK9d
	OwWUr+UNrlDVBEBAW5h+Ojg/tZ9KHwxezoYKsW53XXEIwclsgullW5zqb9v8Mpfsaup7MKMDAQ7iv
	fIOZG4e2B+CcMpUGClLEGIoK7qvge4IhXXI+eOmKovGNjOTGC4S2S5PYPZYpRr9LNzC/x8nwlm6c7
	o0Gte/aiLqx8t8p+xxgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsH1I-0002s7-5u; Sat, 09 Feb 2019 01:01:24 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsH1E-0002rC-85; Sat, 09 Feb 2019 01:01:21 +0000
Received: by mail-wm1-x343.google.com with SMTP id r17so6361706wmh.5;
 Fri, 08 Feb 2019 17:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CI3snqSxMLXSGc7+y7y7HsUpbrgXSQDsSRAlOoM7trA=;
 b=is/daVOSlvXyh45k+0ljRbh4FqkaUy1WhWgxLO3+gqsaNh4QzQf9DnW5jDY5V4Jdwe
 vtDNui+jJz+vQEZbcwEjG+y6HRNksFN4kJ5ZCieg41OV6slomvdiz7HAX83XAGjzOcdS
 ocAOAP+wbNK0zyZdF49hEjNl9Qm4UNjuriqR3TX0nu9nzFUxrlHZ2z0M3fnhUaQbHCJu
 fixw/oFzV70U+PQ8RwjnvMH0lnu9ubjEr4zzjjYIo9ESxBWEOhFTafWP88KUzd6BVYJB
 2VlxM1Uns+qzMGNg98uE33igFwMDflvm0xaQodgiP0riHmJLKOWg+0ltubUOnmNpXkiK
 r84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CI3snqSxMLXSGc7+y7y7HsUpbrgXSQDsSRAlOoM7trA=;
 b=GgBwNyq5Az2VAw2yhUmEl7Ai++C3vqyNesJynDBEbqO8VceN1ePg9UEkqYLQ5KtCwr
 svXSOnUlxsvnCw+nHiWKdUTAsj6PTvEHv9fIPGz2OkKTFuK+sDC4EvRG4KrfLdMvumfJ
 74Bvbr+zU8ig+pE5xPMaNSQSHcTvVvh3NAYQCKf0OTOmHBodpxvpB65AFShLFuwCDNc9
 Xemu1EtCZzBk/wOgtl6hG/XOjo9mBxd3oDAyocy41q6RqFPeMkD91E+c5bv1weWDEIhD
 EH1zKA8LK9QMYvKFbPbFaxV8cIGEN1huwS60TadbM5xsVkqGP1pFhoL57iT/bUvA1JXo
 Pwrg==
X-Gm-Message-State: AHQUAuZ+ngEvNGbx+Ye9pHXtjunkG/vjm5hK0blEYpJE+JlFt716HQe0
 6rfY62knfZTds4k+i5nL3Ng=
X-Google-Smtp-Source: AHgI3IZ8M8TirmmSmkNZLSknHxCI+aC+gC7NegkygmJvk1Je3uJxc/09DWT+vHZQ7xCuoggYlqri7A==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr13680808wru.137.1549674078545; 
 Fri, 08 Feb 2019 17:01:18 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
 by smtp.googlemail.com with ESMTPSA id z3sm2838153wmi.32.2019.02.08.17.01.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 17:01:17 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCH] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
Date: Sat,  9 Feb 2019 02:01:01 +0100
Message-Id: <20190209010101.12210-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_170120_296988_1C470305 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix the mismatch between the "sdxc_d13_1_a" pin group definition from
meson8b_cbus_groups and the entry in sdxc_a_groups ("sdxc_d0_13_1_a").
This makes it possible to use "sdxc_d13_1_a" in device-tree files to
route the MMC data 1..3 pins to GPIOX_1..3.

Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 84938bd73ac2..7f76000cc12e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -697,7 +697,7 @@ static const char * const sd_a_groups[] = {
 
 static const char * const sdxc_a_groups[] = {
 	"sdxc_d0_0_a", "sdxc_d13_0_a", "sdxc_d47_a", "sdxc_clk_a",
-	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d0_13_1_a"
+	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d13_1_a"
 };
 
 static const char * const pcm_a_groups[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
