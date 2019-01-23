Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E3D21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZg01cdI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXpAL9bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E3D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RVNImbtEHeTrQJZXtQghSB4WmWpDgiL9v4qy4XpiJkQ=; b=FZg01cdIBb6Mz9
	6svsOrw3/pm0dXr0qGmDMBKZT/4KaPl9SfjVUVwEflxKM2g7VCgO2P3HkFMrQ9zuS7TZJfqg5HA3r
	MoefyeosfTtxKZSTRufew3zHWf3oiK80inaLVJh73+vfARTCG6ljVJoHDxoXXpryP6Jb/fjDxAMt/
	6s3Tr0x5sxhiBJeboeqoUMQTLyNUbwalhEh3OrJrTWW4l75y0idbqUicHZGoMV5TB7YhLWcXxPLUB
	ghNYg7zqHVsW1P6X6/3LWQfgabTVkOS0oKN7tjGsKPHQbC9Cu+WQilm6mwtCNqQk7Cv7jD/SpxUhi
	wZNiN13xlOnkddbEmhWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDZm-0000kL-Cg; Wed, 23 Jan 2019 08:07:58 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDZg-0000k3-Bh
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:07:53 +0000
Received: by mail-lf1-x141.google.com with SMTP id f5so861200lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 00:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=x+fy0KZTfwD2YUDdncfaWMG8mQRvsv8SmEiXoYF5EVQ=;
 b=CXpAL9bxaV1N2jWUpuYm7uGT6n/fXhJM5PB0n+mgiux1/0OwuhUTuFIPAZlj4Kkijn
 9Z+iLiqLLrcrM18wlJPBDmQJf7gjZGgR3RdQwdKcYUISaA94nMdsh0w0p2CuG2La1vhm
 fYCe0ssdq0Tsd1IKzN9ca6JfgmxHopnPNH4HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=x+fy0KZTfwD2YUDdncfaWMG8mQRvsv8SmEiXoYF5EVQ=;
 b=bk28poQ9RzC/jTS1EUMepbjVx0fv99jgV0OAgpvbgzHAG+7FKb8PbimxZhxM+37dpD
 z5dHUFbpeFM9XJqW2HJWKZb9B9e9OPx94bSI1RrB/oBAVbtgiL1LQgOrTE/l0bUT+s1A
 NseqsJv2hMXnd1ivn22cp7tnCcx0QydXdhVzxglh9tRhKl/EgqkYWx/IQ/4uJUp263TS
 BPA7pmTC21CB4arMNIV4v8qSwlqY0vn4qN3C7Ar01Fd7IP3E5Nu5N1s98Z+RUV1ZvifJ
 5OFovunZyo1qJws6gx5ws5teU/Z+EZOELijSj1bdVfwZO2PojUcjkWDiP8Kw/PHy7zCg
 yIQA==
X-Gm-Message-State: AJcUukeStP3z5rfp61Sb02O8HWcKzhstWbvmjGKT9wlDrxteaT2q2KCZ
 zHy6mcaG3GnmnZPbZbPlVp7Yzd0cTeo+J7O53AgNZw==
X-Google-Smtp-Source: ALg8bN41gjmNpgv4wJTvswxGFq6iMhiScVIxyIVnENVr630oHWMCaGamMcCjldASpylIP+8qws+lY8X6SoCSh52EzCM=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr1040328lfc.27.1548230870316; 
 Wed, 23 Jan 2019 00:07:50 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jan 2019 09:07:39 +0100
Message-ID: <CACRpkdZFy-uXZAokk-_jOBmGJOjNu=1Ux8HSPCPM3R+hctOs5w@mail.gmail.com>
Subject: [GIT PULL] defconfig changes for Integrator DRM
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_000752_585642_396EE45B 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SOC folks,

these are the defconfig changes needed to transtion the Integrator
to using DRM instead of the old fbdev driver.

Please pull it in for v5.1!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-defconfig-v5.1

for you to fetch changes up to cf176872583adb3a5f8b4f7f2c3496ddcf69fde6:

  ARM: defconfig: integrator: Enable DRM (2019-01-23 08:59:55 +0100)

----------------------------------------------------------------
This updates the Integrator defconfig and switches
the machine to use DRM.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: defconfig: integrator: Update defconfig
      ARM: defconfig: integrator: Enable DRM

 arch/arm/configs/integrator_defconfig | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
