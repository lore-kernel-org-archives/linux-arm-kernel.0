Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34130C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABFE20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qo74ahqV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lv+5OP2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABFE20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FClKikIm9xSxvaaZVtz3zt3IltVLv/L5lgeguWvFvmI=; b=qo74ahqVT5WSDz
	1F9EHF1NhRjxsN1fFh8XkofO7kndSFWXN9Qf+Z19zKEoD0PZSPX0dHeAHo6XCDN2FDNjYRT81RFEy
	piP74il4yMCIlMfVvA85ijqW5F7C4YHN5sJ1Zz22KMkmh2QqqVZA9ift6GJPBmFdn7RyEY5gCcaxT
	aQLQxQisqzKCkdX3ckj+7NzEwZlTFBOAh+5BJXZbSjmCaYDLdMg70XwRyMzrrRNIVKbMn7HgYK2m7
	r2Py6crkkRceOhAorSzezcH9X2Ys3kQJm4gRjISGDF4AUFI+BB4mOr/6uPb9q8kPVFat21g1WsnMw
	w3tYQ2fLcCNCOUnPVGmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd0c-0000qm-62; Fri, 18 Jan 2019 22:53:06 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0V-0000nY-55; Fri, 18 Jan 2019 22:53:00 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so5963751wmd.0;
 Fri, 18 Jan 2019 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F4OgxGBouj9H1sgDLjgOeDm9EfkYA6HJ3y2b9zUqO50=;
 b=Lv+5OP2Zn6L95zYunHpVA+hbORKFxY0RbW74keT5O4jKwQuNxvyy2VT9IkRjSpHRu/
 HTrqTvYXrRquj+QUACJnNMmSFPv9lnoRQJepAR+K7ImiiyHPZ/bfmJxJkjnGvw2sY1gq
 8CnmST5oncs2Y3SXgLj90nAfyyINJOAEhVlwzoNeW+QDaJZBddxUyKywqHNf/mg5KqCI
 30JO5qRl7o4B0Ga3vPnT6vCvd1K4VafWdjx9XEOcrVnxefvP0sCc+xx3rBZ685l0LlIr
 alf65+dYHFxOoqdZNeMIW+1JLtLarpTTatx2aaTqk1oiCDAlJ1lzW/jxKrMzO444tVKl
 NnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F4OgxGBouj9H1sgDLjgOeDm9EfkYA6HJ3y2b9zUqO50=;
 b=syQYh5L4zKXi/PGoq371WiuSANLuaiBDuk2jDBLUYoDtE93QMR6svkNfPv9GAI2E/l
 +FeZR5ZFIgodQUS6XVqPlHEgvvF2KFNJvznfd/BRZE5eRRw66AO7RaHtoOgTLJ/mX6gf
 U3sjnbskLd2IC3Z1xXb924HBD3zLd2AzBoI7jIXjXdgcTx6cjP1TlQ2GRtB9mfX4DZ8Z
 do4Xlh5Ga7Aheci+XVpMKTb9c59Eumt+boCEoPjCHEDXoyhe57mBRIKwzS0toI3LdL9N
 r/p8Ixkbpc3Q94IK7bZOSYF9z7wZdLzynWpD+4ZnKev82dVmLApnfFfTYwS15hmG8Dvl
 +SIA==
X-Gm-Message-State: AJcUukdHEwdXtlL+bz+FfSDrUUhPPecl9iQVZm3Few3+mvfn/4Op/fbO
 nwi6M+SFvBMo2BiZ6JTB0GcbNQRg
X-Google-Smtp-Source: ALg8bN5iWWADlpbsUlFtQ4Lxp4LgcsfA/mTD26nj9wF7x6bmvkHIbiXXTjvUozxbF54CgjnXAcKqqw==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr16876111wma.76.1547851976400; 
 Fri, 18 Jan 2019 14:52:56 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.52.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:52:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 0/7] ARM: dts: meson: chip temperature (hwmon) support
Date: Fri, 18 Jan 2019 23:52:20 +0100
Message-Id: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145259_224205_409D51C8 
X-CRM114-Status: UNSURE (   9.96  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that the Meson SAR ADC driver can get the chip temperature on
Meson8, Meson8b and Meson8m2 (see [0]) we can add the missing bits to
the .dts{,i} and enable iio-hwmon for all boards where this could be
tested successfully.

This was successfully tested on multiple boards:
- Meson8b Odroid-C1 (me)
- Meson8b EC-100 (me)
- Meson8m2 M8S (not upstream yet, me)
- Meson8m2 MXIII-Plus (an earlier version of this series, Oleg Ivanov)

compile-time dependencies:
- none
runtime dependencies:
- my other series "meson-saradc: temperature sensor support for
  Meson8b/Meson8m2" from [0]
- multi_v7_defconfig already enables CONFIG_SENSORS_IIO_HWMON, so
  there's no patch which selects that.


Changes since v1 at [1]:
- added patch 1 at the start of the series because patches #3 and #4
  require the HHI memory region to be a syscon, which is what patch
  #1 provides. Thanks for spotting this Kevin!


[0] https://patchwork.kernel.org/cover/10744059/
[1] https://patchwork.kernel.org/cover/10760963/


Martin Blumenstingl (7):
  ARM: dts: meson: switch the clock controller to the HHI register area
  ARM: dts: meson8m2: use the Meson8m2 specific SAR ADC compatible
  ARM: dts: meson8: add the temperature calibration data for the SAR ADC
  ARM: dts: meson8b: add the temperature calibration data for the SAR
    ADC
  ARM: dts: meson8b: ec100: add iio-hwmon for the chip temperature
  ARM: dts: meson8b: odroidc1: add iio-hwmon for the chip temperature
  ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the chip temperature

 arch/arm/boot/dts/meson.dtsi              |  7 +++++++
 arch/arm/boot/dts/meson8.dtsi             | 23 ++++++++++++++++-------
 arch/arm/boot/dts/meson8b-ec100.dts       |  5 +++++
 arch/arm/boot/dts/meson8b-odroidc1.dts    |  5 +++++
 arch/arm/boot/dts/meson8b.dtsi            | 23 ++++++++++++++++-------
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts |  5 +++++
 arch/arm/boot/dts/meson8m2.dtsi           |  4 ++++
 7 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
