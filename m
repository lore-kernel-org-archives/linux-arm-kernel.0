Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E16C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425D420652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PPduX77y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZjcIYX6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425D420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4ZbnlQzCFgkyev2IlkI2Cs/MS8Z5g3InvNvIyo+gag=; b=PPduX77yM9k3Aj
	nihD1gZagzqosDE3zZ4HM9Hz4O9UuDM+G+p7Rov9DpzlsJbkA+jF4Y+ODTLphaweue+pVHwkIO8Pg
	VTg4QolLP2D/6FlSEM1RLApPhePL9oHYTrDwIzyhsrX+mKl69yjS329XaOajv8g1kYbNwJ0aAnBYu
	j0pi6p7pVUHaHohzsWha+Xbx9fAj3+Ge87dWku5Dgu5n13WVWX9zfJhhCfM/k8F69BpKfVesYYYqu
	DXKwZzbjTr8x1AziMQZw1cbXEkyoMcNWyV8hHZlB2UnAlNeSlKqdI0woY/3u1bbMcwwM+tzDd4TXW
	pClvDB1GSqJFokA+qMSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0XA-0002Le-9I; Fri, 11 Jan 2019 17:23:52 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VO-0000RO-JW
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:09 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so3116799wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5d4Pl0ken6pXZX1p6S5lDG8psK/cN8ZLaLkv7xqp5gU=;
 b=ZjcIYX6z+7gmHH48U+8QqXnpq9exWw1Chs3QOusA6jXqa85nGYJ+rsv5dOKU1vNGCV
 N4ftQcJBzzie8M5aCMMuX6zgSSnI6ggk0Udd8EZFbSojt6fcJWySo99EfCj+14wsmg3A
 60ucsqxz/E0Ai6Hkomdk2vrbkOtKoSnob/RtsSgIrVyQxHDOsEot11iEk8xTvh3J9K1r
 9KfS3QQQkbq2ZocV5LVT0pAt/KbwFEbGUvE7eb0aqcncvwRsQ6CmNQnLWbQezxJygkMA
 Txu8keeDpH4IoE2oEKPUeBEENeTDIjsXKgfRNKoD4Fc0X5oQF1BZPZWm2bfud2RVNW1Z
 Dbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5d4Pl0ken6pXZX1p6S5lDG8psK/cN8ZLaLkv7xqp5gU=;
 b=Kt5MHkbJ0zv1b6RouSLxn8v9ffVclU2NUGt/E5ha9CYvRX/bEzKI1jfHmmY/3tVpMr
 DoGL9DTIsGpVP6jNAiKz85iZuS7K034OXlpHr/RM5PslFZQ1bxNaUPO/M0SX8ckiBji/
 JSs9UMMyHBYJ/IIax1wJCPlkrsRsuCdJkkpxpd8OgAlY6z/4Tu8kwdPjDbLaxIuobsTb
 4YXGytg9H+T0pXU1nyZbQtsVndXiUiskqCZriW7dVFJpSjSEYhZEcpTgRe0uM/qEUmyj
 X9PXKxNF1b9jsHolekTxja1mhi6/jax0/9nKGqTDQh9D47AWMVtX5ciak13oryEvimqC
 MEoA==
X-Gm-Message-State: AJcUukdoyD8uHFDsszZhjRqzEPBv2dtdq4KE2+HsMLhuwc0tx4rY1l3i
 fcoTG4tIclKH6gonM5kWij5Gt15mZGlhwA==
X-Google-Smtp-Source: ALg8bN6kScczA65jwRPm8nMMtox2hVlUgH8vKdEggfvhVcOqMebYDC+oQ+YD0/pGrVRZKQH6CrEpQQ==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr2914717wmg.21.1547227321283; 
 Fri, 11 Jan 2019 09:22:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/17] ARM: davinci: dm646x: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:26 +0100
Message-Id: <20190111172134.30147-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092203_432651_F0063767 
X-CRM114-Status: GOOD (  12.76  )
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
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm646x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7dc54b2a610f..018315fa9aa9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -665,6 +665,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	dm646x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
