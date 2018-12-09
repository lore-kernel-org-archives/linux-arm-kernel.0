Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C30C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCF920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JP2pyJ7G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pNN+iuMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCF920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yLDVyqqKlkRyDM38meIllgFVYaX09kABja/YZi6WUUA=; b=JP2pyJ7Gnm+dPl
	F4Ztmu/0BetDce58PCRHwi24bGoFFDFTbY0XbY+aKLhqAHXBRJrhb3R45+8XoSuyKwNWIO5CSGjob
	MqhC3Zofug3ImyTlqYZVQfC6CNdTSqn1CaOcPrch21LN2ce1ZhYpcBGibR1KZFqIB1WTOZmfxp2zZ
	aDzeKLIRDSxNVZ6Idmi2y5UtsU9qub4ucfNjAhHD/SRYbwoLxJ6+7bP/eol5olET2zA1QNW89RU/f
	zzlg/uEkHHvMjE4x0+DOVFAsMLqW9L13ttQYJyGOBH9HZhYKoISKdIaLWPA5x1ctarzkSPqtkQeSU
	VACEMoY/uUU95sNbHkKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW586-0007Ku-Ke; Sun, 09 Dec 2018 19:52:42 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW56k-00064G-0q; Sun, 09 Dec 2018 19:51:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so8380605wrt.13;
 Sun, 09 Dec 2018 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wFi788sDnujp6rjIMSWVzX7d/CUd1EfTK7PJQ6DlBVE=;
 b=pNN+iuMNOu2GOB1n61HDXSZY5o30wgR336KctlRR7IBEm9KIk7RgQQy+N1JA1tp3Je
 n491Fpsf0gDHoK2emBNBiXaQxJC7Es5ZaO2UdQJRb1uxYgiVEKyWb3NUEeQEpxu2BRnQ
 lkj0vifwHHvMsM+ubXthfp0A+V/bwnIeB6WMns9hsEoeMdUk/WvcNrrf5Vz6RQa6xDyZ
 Aq1vqQPaXtzN0Ol6UByovuadN/6FJsBkwfQxvD6FfXYRzKYziTnWpdmianVqqyeXGb55
 4NWNwhAjNqHVj8Vkf8vcPc5S11wdHeSgUTQFtWizCb1SQccoxGBPKxz3S7wUpRQhGgDz
 u/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wFi788sDnujp6rjIMSWVzX7d/CUd1EfTK7PJQ6DlBVE=;
 b=F4UiqQw1Yhtuougrj07aLIZz+F7z4nn8itcV/PRsMKVMygEi4rNqV9jEKIIVrHv7FL
 u3fM9WeeKEGjWnmX/9epZvV6zb6pmsHMC4px35PyPlrhbVYnw6fSnU838/0QS3ObntqH
 gbl8s2RZhRg/TC7hTlPSSpYkmp2BnDjqqZoyYFFM+eXSDLpIyPhRWwUgG1YPTifuVF9A
 c4VyLg04OGG8jXCN5DUtR7WBisNGI40Rn0XxoIPOggaIH4mdn5Pts742EH1i9vPRFjj3
 0b8BNlt7mUz3l3WYj/FuNzjT3jEoyQreNMkxWpRok1bAZ/JYjimSjAZDRvlJrUtgxNxH
 rrSQ==
X-Gm-Message-State: AA+aEWbpT/fB+w36/p2khNg0z34NJT5D7PJm3fJ0WmrqoIMlIKZpVi7F
 ps8atJv3nrvi3lIzQLPHac4WJnTY
X-Google-Smtp-Source: AFSGD/WJfnDLpniSUCUz9i+RGP7fLMRstRLLHp+SXM5J6z7ndJQjIwps9yqA54zpmhuaDo0SVTpy+g==
X-Received: by 2002:adf:f189:: with SMTP id h9mr7650610wro.35.1544385065674;
 Sun, 09 Dec 2018 11:51:05 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 11:51:05 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH 3/6] pinctrl: meson: meson8: rename the "gpio" function to
 "gpio_periphs"
Date: Sun,  9 Dec 2018 20:50:52 +0100
Message-Id: <20181209195055.26813-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_115118_135156_2F6EEB0A 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: carlo@caione.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rename the existing "gpio" function to "gpio_periphs". This makes it
consistent with the "gpio_aobus" function. Also GXBB and GXL are also
using the "gpio_periphs" naming, so this makes the code here consistent
with other Amlogic pinctrl drivers.

No functional changes since thee "gpio" function is currently not used.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index e482672e833a..5f4935a81295 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -774,7 +774,7 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 	GROUP(hdmi_cec_ao,		0,	17),
 };
 
-static const char * const gpio_groups[] = {
+static const char * const gpio_periphs_groups[] = {
 	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
@@ -996,7 +996,7 @@ static const char * const hdmi_cec_ao_groups[] = {
 };
 
 static struct meson_pmx_func meson8_cbus_functions[] = {
-	FUNCTION(gpio),
+	FUNCTION(gpio_periphs),
 	FUNCTION(sd_a),
 	FUNCTION(sdxc_a),
 	FUNCTION(pcm_a),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
