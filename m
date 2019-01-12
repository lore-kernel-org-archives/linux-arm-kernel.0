Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52724C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:07:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1C920854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOKmwCq3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RAYHxWet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1C920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8CXWtwJqSxcS1SSek3KScOhm0Qrzc+pGpVhB3BRqUYI=; b=fOKmwCq3hncfVV
	5+qWDPReoCDCQfpmIvFD/SbxpH2q3X9ol1BUpvrBxsOsfz1/KVaLkoY2hjmpJOsGzCfEvzbuepb5w
	BPIQfQEEQQu2I9ROIBLVRoCxIqCkW/QOZSK/5byPwqhYZGzsKfZVXAuhJQqq5j/t/+XvVzJku0x54
	4zhPrCuV1pAplfK3YaUThm1W8NtuoiNoQMYmKpXJmM2Mz+9yHDLTITqRYTCWkVjGN8aQIhYWnW83C
	YyHDClPhKWrCHeBrj+RyjkMtggPRfuFGUaah8N3gQuS8aXWNPZqJsggcaBdxiPWCb0RWIehMzmJbA
	GwwgCDpap7gjUgtomHpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ09-0007rK-5g; Sat, 12 Jan 2019 13:07:01 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ04-0007qJ-MT; Sat, 12 Jan 2019 13:06:58 +0000
Received: by mail-wr1-x444.google.com with SMTP id c14so18119727wrr.0;
 Sat, 12 Jan 2019 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0yElBncs23AUanHK/S6XP81KbLpit9k83je1ZsQOWB4=;
 b=RAYHxWetVwbvB3nD/ZqeejFk4qlC9DZt0edwQcrhyjGkIYeQEgEi3Djfh+34yXRaE9
 kyeaEP4c4iWC/eHjm+l8pLf4dkCzeUt9OUKxM/9C8dp8YFH7BXq7pdJ1MbnGeBqKu1yT
 XdU/mmkqoR4t9TPwH8mjPH1nYZpHfcO9g7n8sqiecMvX+AXT5b31nt8xgQqBb/S3F2Bz
 JP78v4AHOaQppOzTevHPTYxh8nSwcWr4t3wlTknq1sM0WSQ/uKxjc2u9TvWJEzGnPG3W
 sXjPqgoYatMb5VE+qnn3kaV5obszNm7Pkn1cELDS7zhCJLhFuzGLEtmW6C54Qca+fIok
 WvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0yElBncs23AUanHK/S6XP81KbLpit9k83je1ZsQOWB4=;
 b=mhXWQX21lFBPmyp+w2HwFq9N6VxZtFtYgpIvfp/1vSZ8GguAFJFoHlIDT/rrraRIKu
 i6m+71h/DvtWa2OdfCQ5jKv8hdpPpKoYdvKR65lQH/W0sJXURAvp8xfXkuDfjgfnHQot
 6klusxu0WOXJHGZAO0swXd8PJ7UTCe5iBu1NxaYBQpy5yrVZCMWI4/KqG7FEkQabFWM0
 Wej/hptwrbiu4aH3IDFXfrCXCmaxOUtBL6amxBmdrxKGHDd4hna0opCXKn17HUvrSSr8
 zk3kgU4fCRBXK/P19ud8YxopE65o4b+KqGlEqqD9S0dNATDb7+I+SdiXKbDao5BaG4u/
 yjig==
X-Gm-Message-State: AJcUukeu02B4jT4oWMlehbbVaN1asvMMW6Oxs6JozVyr5gRIEvwa4+Vv
 22cXVqt2ruVb1gw6RGdI63kw2dg+
X-Google-Smtp-Source: ALg8bN7ab3H9SHi3DxDdKznNO7evW0qWeAapHlW2LU7vVg0ZHrOD7EIsjO5JVkQj0gTjoXqtLqAmlQ==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr17684307wrj.118.1547298414625; 
 Sat, 12 Jan 2019 05:06:54 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.06.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:06:53 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 0/6] ARM: dts: meson: chip temperature (hwmon) support
Date: Sat, 12 Jan 2019 14:06:43 +0100
Message-Id: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050656_760894_9BEC4DE4 
X-CRM114-Status: UNSURE (   9.13  )
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


[0] https://patchwork.kernel.org/cover/10744059/


Martin Blumenstingl (6):
  ARM: dts: meson8m2: use the Meson8m2 specific SAR ADC compatible
  ARM: dts: meson8: add the temperature calibration data for the SAR ADC
  ARM: dts: meson8b: add the temperature calibration data for the SAR
    ADC
  ARM: dts: meson8b: ec100: add iio-hwmon for the chip temperature
  ARM: dts: meson8b: odroidc1: add iio-hwmon for the chip temperature
  ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the chip temperature

 arch/arm/boot/dts/meson8.dtsi             | 8 ++++++++
 arch/arm/boot/dts/meson8b-ec100.dts       | 5 +++++
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi            | 8 ++++++++
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 5 +++++
 arch/arm/boot/dts/meson8m2.dtsi           | 4 ++++
 6 files changed, 35 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
