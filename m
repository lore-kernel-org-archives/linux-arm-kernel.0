Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1889C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887BB208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iapV0ASI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6d2vWC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887BB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=I1lqI9VBnZczHn23QAOh9QFHwIZa508T9PLYLAwh9T0=; b=iap
	V0ASIy8oBIXs5qo1HTpdPoQRIt+Mv8AbKI5BdpUyTQD5VFoEOk2vHFNZWKl+Q9+0+DA7tZTcvzqx2
	ySx8HeeS6mYiMM51KI4Pqp7fVPgddlPtSC4AJoEH0nLPWf0sZ+/0NQ5DgMuvPkqw2nlIWe4IoOMa4
	KJ1xhlx1xh57kuW8Rpcr5Q+oyk0Wu7BZajvwxofp5QzaS5nPmgugna4ykrejJWuISFHEC3xlIaJok
	dY7aYiYC+pXWAWDFQgfhk4dhmzb7iRizT8qO9ImuXswExeEpNN70SpNTHpi92ybrKhQL/bEGHAC0h
	HdAGZBT3/PCJNjz5MFAmqK3u54EkUGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu3u-0004z2-C7; Mon, 03 Dec 2018 19:39:22 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTu3q-0004xh-Pd
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:39:20 +0000
Received: by mail-oi1-x232.google.com with SMTP id b141so12018396oii.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=rzZ4Z4g1iHRPQPhD0xL6IPj3S6QAk7xPJjkU/WFj4eY=;
 b=R6d2vWC+IjRZrsNQTQXsfwNRX8kv8QLQuUc1hnguTCyTgZAl5S0R2p941V8f1EYY+S
 mjkbQdu1/rVGSXJwzuSlm3RMHdQdoWkZMGkTE389sd7z2g3z3WI8lVaW5hWBSsDCnFMK
 gLOP5vh9I0eHPgfZBLkVJ9r84q9oMqzILeQcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rzZ4Z4g1iHRPQPhD0xL6IPj3S6QAk7xPJjkU/WFj4eY=;
 b=PJs3c2IP20A38gXnekRk61MtXaDStpkt8jHRKe0b6ScjOWszxKejerdXjRzjjhbxxO
 CJBOrEkfStBDLVC7TtoBHNy13ptGj35WmjnAtF8lm3ee8b3AfU75HXuizw1iRmh7Grxq
 L6M1PJ4Fhm6Juay8JEKg++2n1PnLeYQMQiGvGYaxosolU4WEJucJkBBtqJUOxcvN6TPJ
 fhTPkG6yN9X7NqQ1Bk6EQE19fArs498s5JoSpcUly7i+pdMmthzD/Mt4XEXwugGZwU7G
 H9YNV+UoA4PSy8c7OxvtBrF+A8Fpd0zQJFO+pUsIq/QH8AfCZLOgFQ6eI/jfuv7E4TaP
 gzfg==
X-Gm-Message-State: AA+aEWYs4EjMBVG2BOO2u/D1KZm8WFxXjKMo3zX/iJ4psP35/HDRip4g
 Vxtd2PFvjGGXxXEdAHhJ2A8FJg==
X-Google-Smtp-Source: AFSGD/UOYYYAfP+i6lYzlUaflNn3MH3OmgMEQWnSyEQZoNSstrT9/DsNH9o8Dwho0IVxi/8HgCRUNg==
X-Received: by 2002:aca:47c6:: with SMTP id
 u189mr11027765oia.250.1543865945859; 
 Mon, 03 Dec 2018 11:39:05 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:60aa:6557:7f4e:5d7d])
 by smtp.gmail.com with ESMTPSA id 30sm6756458ots.52.2018.12.03.11.39.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:39:05 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.21
Date: Mon,  3 Dec 2018 13:39:01 -0600
Message-Id: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113918_833570_9459C1E8 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.21

for you to fetch changes up to b0bd6f1c03b4670f3e4b2a328e47adb9f2f1684e:

  arm64: defconfig: Enable GCC and PINCTRL for MSM8998 (2018-11-30 15:12:46 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.21

* Enable Qualcomm QCS404 platform options
* Enable Qualcomm MSM8998 clock and pinctrl
* Enable Qualcomm SDM845 options
* Add remoteproc related configs

----------------------------------------------------------------
Bjorn Andersson (4):
      arm64: defconfig: Enable QCS404 configs
      arm64: defconfig: Enable some qcom remoteproc configs
      arm64: defconfig: Enable core Qualcomm SDM845 options
      arm64: defconfig: Enable GCC and PINCTRL for MSM8998

 arch/arm64/configs/defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
