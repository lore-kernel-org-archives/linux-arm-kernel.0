Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67695C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3493F218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BlmF+p5m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MvR42ypG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3493F218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0rBd2iZVhgHf+DJAiwmjvCMNftURIVnJC/a9dNO9Du0=; b=BlmF+p5mJzFUdA
	Yylz1/Z5eyXIDZn46Ky3M0gAUenej+F2ADv8AQXbrlQ8YLB2gNylB8xI6QPvUPIK2kXnb+mZusF2C
	Obx2OhCTAOUapVNuakRWXxuOCqJifNOpo0h1En94cmF/JvII1csEqttg3G91akdjH8702ifzd2qwX
	y4VAlKYrcDI2O0CzhtW4Qut/Z6dasO3NLzeoHcMa6WyyQASNRMKZwYA3DnLtb++/OYnVtaxzpQLQ4
	ezo1OFHcFrXqDtbc4pR544bhJBw0hBBqBf596DuICDTInQSkbVs1yew8T+sCW5kaQcZ0HeFhzI1jT
	dwOjlgxf+4TxjgFwSeGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdYi-0002DS-1U; Thu, 27 Dec 2018 21:51:16 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcdYQ-0001xH-IV; Thu, 27 Dec 2018 21:50:59 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so18450008wmd.2;
 Thu, 27 Dec 2018 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hGl6wDcv18nbdMCsHxKqHa15xVmZTDDMiXxC8PDTofU=;
 b=MvR42ypGbUXKRDB3dpUyyzgsNMVVpHcnsUhotUvvXBaCiHtCtWt9sCiC2BBzgX/mVm
 B7+5sCbZ6FUNmwk8sl2wFaJbxVl/BHK0Ox9HcVmO9C8X3NMp71ci6l75kQvq/K+Onc0V
 CWadsSwcfq8V6mLnJjvyOMp0bsT1dVnvPt76D1oKc6ih+4T/PQ6kiJZ7bpj9WdnRBCAu
 bREm7m1svtljiMwUng1ejHpvxhojCQkmLXaQhNdmHxEk/MHJAAS52uufDfDqLXn5491e
 hU6L6Wwh1x0BLkbIOo20rQ391akgKRg08U6YDhOxGpg5TTvvE9xYWkTzP5qbZtBs4lWl
 1yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hGl6wDcv18nbdMCsHxKqHa15xVmZTDDMiXxC8PDTofU=;
 b=e7YNs8RwwGnxKu2Dj+Uc8kCK4jkeViyZL6gZpdH4uA4MOWTEorqRD46v4q/eVG9q5z
 meTnWCqsPwRdXiBhMPuUz/ZJf8ppXOMw1dA7FjBEcdRDKy7/d6tiB8pul6xnkYlbwvoF
 3puGrlANP7bKXVRCx5nqg24+RJfte9OJL2KmsjSdGjCt+3fLZvGyKlkITi1FDnAELACe
 /RBCcjrb2JaNLxJf7umKSR8nPQfi0H7KTkluLEy6/VujFmA4qamd8rhbPhjg03bP3+Pt
 dkof2yrvn6sY3qD342e/qi7zQwT3cmM6cyj0umOPPcpeQzYOaxBSgHa7u5S1GyrNpAD2
 YMiA==
X-Gm-Message-State: AJcUukf2SgNqshM4nAKFgmwFGMmmK2QiTsbXAIK8acMPit6VLP/5DoJB
 dDzMVSylsLgoJoJ/x8pxcjADJyQz
X-Google-Smtp-Source: ALg8bN6ieOhYIq1Kis9m7na7acyY2+nvXugjt1uuR7Dii8uadNTOEZZDjJAx2UYcFua+8zlMFsGBdA==
X-Received: by 2002:a1c:8acd:: with SMTP id
 m196mr22837472wmd.120.1545947444131; 
 Thu, 27 Dec 2018 13:50:44 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD711B00071582302E30AD474.dip0.t-ipconnect.de.
 [2003:dc:d711:b000:7158:2302:e30a:d474])
 by smtp.googlemail.com with ESMTPSA id m4sm34538164wmi.3.2018.12.27.13.50.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 13:50:42 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
 pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 0/2] meson-saradc: temperature sensor support for
 Meson8b/Meson8m2
Date: Thu, 27 Dec 2018 22:50:18 +0100
Message-Id: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_135058_631393_495BFA86 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: balbes-150@yandex.ru,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for the temperature sensor on Meson8b and Meson8m2
(both are sharing the same logic).

These SoCs can use most of the existing infrastructure that we already
have for Meson8:
- parsing the TSC (calibration data) from an nvmem-cell
- the math to calculate millicelsius from the register values

What this series adds on top of the existing infrastructure:
- The TSC data is 5-bit wide instead of 4-bit. The upper-most bit has t
  be written into a register in the HHI area (which is outside the ADC
  register space). Thus this adds a new device tree property to pass the
  HHI syscon to the SAR ADC and we set up this register during SAR ADC
  driver initialization
- the multiplier and divider values (to convert the raw register value
  to celsius / millicelsius) are different compared to Meson8

This was successfully tested on multiple boards:
- Meson8b Odroid-C1 (me)
- Meson8b EC-100 (me)
- Meson8m2 M8S (not upstream yet, me)
- Meson8m2 MXIII-Plus (an earlier version of this series, Oleg Ivanov)


Martin Blumenstingl (2):
  dt-bindings: iio: adc: meson-saradc: update temperature sensor support
  iio: adc: meson-saradc: enable the temperature sensor two more SoCs

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  4 +++
 drivers/iio/adc/meson_saradc.c                | 33 +++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
