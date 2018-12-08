Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC564C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87651205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jufknfcy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OecMCuBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87651205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1pn4i5221GqpKeKKdWggsZ0SqA7Ul5i6g+Ct13iAKWQ=; b=jufknfcymzJY4u
	OCyJsrc1g5aiIFut16Ry5O4vd6YTwIS7jpz9G88rVXlZccI6bGbmKiRN+7QIuD0NdAmLblasjCuUI
	VFlGkkTVayFGgXDXnW78JdPW6j0SqHqYyv0Rlq8yKKFcpR0fm4XExZnlqEhJBZeWZj1nZ0s4BIuwK
	e05+hlewolzhrsZQw+dlbWrdv3+hFq+70fcn3JWoGj8eu4IT9ynfuNzJUnaQFR3wd+X99rOe69wo0
	2Od6TVOwNp+VPH1gMn7QDT3oOnWmogOuhGajjlicZHTm8ZweZFA4bXPmY9tpf9KK36UNxJpWvRA7O
	4TWGk8/125BPozxVXMpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfoV-0001zj-Q1; Sat, 08 Dec 2018 16:50:47 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfoR-0001y7-S8; Sat, 08 Dec 2018 16:50:45 +0000
Received: by mail-wm1-x343.google.com with SMTP id m22so7296923wml.3;
 Sat, 08 Dec 2018 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dsaJbjcpB24+zLEci7Jp1YL8GeBwVROEK15Bc3ThBjo=;
 b=OecMCuBCNojRkcT5KvSjHKh3PDPlkdrkqfgwRyDFIcEjFSHX0NJfjca6hBqMhaKeX+
 MoBb3/VB+VCryFRKLyksxdh/VwmJnVajNTuM2/LhGdt2UpmdcCaV6Ci7vsroxrfj3+mG
 NV7lOsBWBBVWs12Iv/y/Lbh24HyimBlJMN0fMKNk2C2o/px0HhNGASvyD6UzjOHsJD21
 NfQtnf7eNQQbTYvIu2QSOHdj1ctwFlBNtWaY3AtzawbvyM+2ElNef5RlLz0UmnK/TN8C
 nmxIyW6nJcRDntNgMwB2aZGxnxpwT/eiQTvcu98/Fj2fCM52dzv5ZoM+iKUYCBHliKOr
 hdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dsaJbjcpB24+zLEci7Jp1YL8GeBwVROEK15Bc3ThBjo=;
 b=oVA7b6ak/d3CtFgOavs28V0M6OqJupUqv3kgjRFtckaS4kbsufZuLy6tRt2vZv1cY0
 urweyIg/iwaH9n6GGKrO9JI+5D4iNHyWO+hw/Kbo8ijn36ZZPAAenzb+XKzQK2686XfD
 U9HtRyId6PYhQaNwqq2rls11xRFKkoZbuA5eiS9kns0RYpI18j1aQFscpxgLUMMfz4vg
 cTVZhgdyOJk0UMmWgTbwbW78A22RodnkSlUpvxp2VzsbrK20Ih0R7Drm4Z0UlmuCC9ij
 kOSZVrvivVJM9Dn2wTIKqTZXFT9bRRA1YWD81bnQ7bO2fawIxZHmPdpbm0uD8xosEejS
 7/5g==
X-Gm-Message-State: AA+aEWbRg5FOdH7DvsalEAMNt6k3z5t9Jyb+y1Og5NjyM5YeQp7bEOtD
 9EacXL4m6dGEVeFITPe7CK3rTe/q
X-Google-Smtp-Source: AFSGD/UU3bNYFBKFvnLoD0Mc0ZqsqkwP5X3TZ6g7FI6b98WTxalGTiWnGwPzL4EG5/XA6tJmRiYBmw==
X-Received: by 2002:a1c:e90c:: with SMTP id q12mr1450507wmc.12.1544287831832; 
 Sat, 08 Dec 2018 08:50:31 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:50:31 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
Date: Sat,  8 Dec 2018 17:50:22 +0100
Message-Id: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_085043_913317_FEFBB6C9 
X-CRM114-Status: GOOD (  11.66  )
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
Meson6. This is preparation work for adding the Mali GPU which is
located on theses busses.

Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
region at 0xd0000000 is called APB2 or A9_APB and it has a different
size (256k) compared to Meson8 and Meson8b (2M).

Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
- Meson6: [0]
- Meson8: [1]
- Meson8b: [2]


Changes since v1 at [3]:
- re-send the patches but this time don't include the old patches
  which still had a typo in the patch description (ABP vs APB)


[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
[2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
[3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html


Martin Blumenstingl (3):
  ARM: dts: meson6: add the APB2 bus
  ARM: dts: meson8: add the APB bus
  ARM: dts: meson8b: add the APB bus

 arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
