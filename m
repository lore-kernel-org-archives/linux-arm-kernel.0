Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA159C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B93620857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mXWnZIPR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Oh8Ry8TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B93620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KpAkt4Xi9TD5N38D5DuNpwBQ7yKuM26FaND4XowQhJ4=; b=mXWnZIPRWrZ0eI
	vhUIy+2iNB2KHtpMlpSRmhGLr5kAViYS+gyJjvhMS4vhQnu0duG/bgwMqBNFgwJrt9e+gSk4yuyHq
	Gr2knzb9+II8wdNTWxXQd+Nzzja22HQTzjChvZ6ziwkprLFtOuvICgtbn+HvSympaWMZHCOUMwuuU
	J7sDx9gtTgg7aTrslbSHJsGkc087CK6tgDPL545k/WSyQ8yTjRO+V/ifFV359Br0CHNs39g9aGGRD
	UV8uBdwTNLGopja1kKvd5ypyVKdV0U0y88THWgFAXCF7JQI80x+9qcLG3fXvMZIoR4CoGjih/44MF
	8wXHwg9SbMbRx1qcpcbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpwt6-0007gN-Ug; Sat, 02 Feb 2019 15:07:20 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpwsu-0007UB-CZ
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 15:07:10 +0000
Received: by mail-ed1-x544.google.com with SMTP id h15so7870401edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mUasgTENDWV61gJF2QhpIGyoYs8CsUi24WBGkfjbG6g=;
 b=Oh8Ry8TDO8bPTFRT2jFee3nw7ODm9LQA4lyJksYMLOv5TEUxwQP/rq2ywpdlSwFnhT
 s1iQZ1Y8bnbur12MD86c0k/KrajnexHQvfcdcKK7e7smFBd2b3uFwq0SsjowLan4zpob
 Cm406xpuv4m4nZPN3ehqX2+RValmTKuAajDQ1Tp8tIuXZCIJ7BIm0mPcBon34Q1VCDVT
 LzVJtBF+W5zp4WFuyHLVw8rNRhQYdmkLGMovUioACQb679svYZhMpZR/a6Zo0pSzMn4I
 MGtbTq4tKFizGpSLfAErtM9vCRjR/Y3TiyKO0fl+6D5+FBMSdmUhgQFeMXxOzJ7jrT4e
 ZRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mUasgTENDWV61gJF2QhpIGyoYs8CsUi24WBGkfjbG6g=;
 b=gooBaNJOhlJeU+ShfF36OJNrF46bLdqnLZsEJb55nt1QBtLiNVQLzwpz3E1kCFYs5R
 JmCBlNYdrIm8yH992I+vAeE93/UzZtoIQherBiXtOasw2AXXYugM/QS3FBYSeeyTX/GI
 8Rxvszb4AmOvpvgFCH457M5KYyGozwGlPESrQovInNy919r5PWIILC4dOn1S7998QLCq
 ODoBRDknEduieXPVeFGsKL2SjC5l3cJmvVMKSrBmp9YbwHRpq1kHKT47/NbcKLULB/A6
 STGX9jl/3xYZ8Ez9h9/V6MeLkBGK83Qw1IKTgvzAmZ8W3nIWacCkWFZs21YFSNxtDSSZ
 1mMQ==
X-Gm-Message-State: AJcUukeHSX88FAQ8NBZfOOkQTGMRnJfXtBhyTL8O1EJYGZu3HOBe6aUN
 CpRIPqhBN27vrKnG2uSccNUgmA==
X-Google-Smtp-Source: ALg8bN7c9MQ5m/BFC3lhfaxue0moptRSBwI/XL0Lpk6Uyorg3gmuEt/EyPbRMhbKhROzeXoBxXTQ1g==
X-Received: by 2002:a50:ae01:: with SMTP id c1mr44535326edd.12.1549120024445; 
 Sat, 02 Feb 2019 07:07:04 -0800 (PST)
Received: from xps.fosdem.net ([2001:67c:1810:f051:b8ff:4dac:8778:256f])
 by smtp.gmail.com with ESMTPSA id d15sm2753023edv.20.2019.02.02.07.06.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 07:07:03 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
Date: Sat,  2 Feb 2019 15:06:36 +0000
Message-Id: <20190202150638.13672-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_070708_428536_177FA385 
X-CRM114-Status: GOOD (  10.44  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a new node to enable the On-Chip OTP controller and add the new 
binding in the documentation.

Carlo Caione (2):
  arm64: dts: imx8mq: Add on-chip OTP controller node
  dt-bindings: imx-ocotp: Add i.MX8MQ compatible

 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi             | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
