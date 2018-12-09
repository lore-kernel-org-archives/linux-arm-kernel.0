Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E23C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D847020831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t6JQuOK0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qigJXV7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D847020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QNYXY33HwubyvKYwU91CzZpXTMlVBhRi7LcxTA29ick=; b=t6JQuOK0tz2Wnq
	lamTpNQPxmR6PW3izJjhMkzo8yq+e+3Da5/yNaDsKV+rLSRHd49KazwSsrxccMbOUpZvQNHQ0bIjc
	u7DLE+A4xC6lvl7BPH3Rs2n1jecYBWjKW/AoD19x3bvB5Z7Hy6lZ1hY8vUY1foIX+AV8rUXBWOs0H
	0tL1K6EjUYEUwroV4k1yInshMMvkdqP2PCpxFIr3aoIvJ8yels5Gii99o7Jb6T9zKItpQ5LOlV6fD
	iHpnAYt9ki1uA0LEyO5oUA0ih1EV772P50yRSBZMTZLRw9cLZrNGsyoSGtwcXZ5H8Afwoc67AfEhT
	QOpJdCVU7TumBSQhpPtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW57Q-0006jk-FC; Sun, 09 Dec 2018 19:52:00 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW56i-00064I-Op; Sun, 09 Dec 2018 19:51:18 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so8415722wrt.7;
 Sun, 09 Dec 2018 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uWw97g7ElUgJ2je8JI19vSCNfFEnazDluRAzx8g6jHM=;
 b=qigJXV7eykLEw2HNvRSnSafNDXB74tVhzTxsoMna/5OFyTN4EHbbjF69nWhsKLz5H7
 Bl6SLcqokgsLdjP6pm3tlArBxEM0Mh5+XMW8U2R8Jjz86zF7K5f9gr0+mM0mIkSacKZD
 xaeNDnVtGwmKLhRkHnG3SnEX0AU8SrbtxumT16OGjySJxdAafY1+CkMv0k0XARHKRjox
 4sYaesWY2NgENwweK5m//iXkcvYAIsFWEwZ9qAzlqvjTbyPE2WbhRy97/YBA3dkKO2Dn
 vLmX5cequ3KYMDn6l5bjId7bnrrggCwKy46DqP2fU7HHhfMowjYFjnYXKvW+cQ2oGV9x
 4saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uWw97g7ElUgJ2je8JI19vSCNfFEnazDluRAzx8g6jHM=;
 b=glj+tUBh2NIv2iexc84rmmlEEzxJvgzVXr/MhA8MKy+ACcsHnSZAWiekBeX+AZSER/
 JOSIROu7sUeZwlAxCdWR6HLpzjdsuD+MzapZUB0+LJMRFEWA1wWfV0MR2mX823D5yEqq
 wtkRYh3BFfYqD5ydv9gjW+64CYFw0bVOWXTw56pMbvIZF0bcfl9n3s714WLjysWaM2x7
 2uVda9u6N4LMPmneN4PBKOl79n2mV4SFfTGTAZ0NcgwJ/ShmSIn6gcvJL3O934C9lPip
 KMROWxrPCYVqlt0NXejwG8q8gXQYcrUb54Ha6OfA33gDHMUjaiopWSAV7Hmfm56bVioe
 mPMw==
X-Gm-Message-State: AA+aEWbuBocSEhZD+c4XpSsE5WJKx6tHhghGeJYMTFNWekLLsMzCsSb+
 sHumt0xMK9/EWPSBX7gIz561K4g4
X-Google-Smtp-Source: AFSGD/WuNWoIvyybaMiPYlUdNs8S2clBrxB604ziXFmNaZ4F3Fc5rQZqWqB7gs3uAhxj38Z0YZd5OQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id
 b17mr7593184wrx.306.1544385066607; 
 Sun, 09 Dec 2018 11:51:06 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 11:51:06 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH 4/6] pinctrl: meson: meson8: rename the "gpio" function to
 "gpio_periphs"
Date: Sun,  9 Dec 2018 20:50:53 +0100
Message-Id: <20181209195055.26813-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_115116_822800_48A24EE0 
X-CRM114-Status: GOOD (  12.69  )
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
 drivers/pinctrl/meson/pinctrl-meson8b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 91cffc051055..b455e0c7a282 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -622,7 +622,7 @@ static struct meson_pmx_group meson8b_aobus_groups[] = {
 	GROUP(i2s_lr_clk_in,	0,	14),
 };
 
-static const char * const gpio_groups[] = {
+static const char * const gpio_periphs_groups[] = {
 	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_16", "GPIOX_17", "GPIOX_18",
@@ -839,7 +839,7 @@ static const char * const tsin_b_groups[] = {
 };
 
 static struct meson_pmx_func meson8b_cbus_functions[] = {
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
