Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B91208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wb+Dria3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5HgdvRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B91208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FPrvRIzEvRz5X8TEFBauruPpwI8sQSbqbWqRekGSias=; b=Wb+Dria35Vq/QzX1krNSq+cfNU
	u4qD9cdnegHPcfEAu4JU41hJxrBas/zVY3w1ugl1FEp0+TomuJJBohBufRZKjmTSbQMbybO+R+6oG
	CUAYjjzTkw1MZEJ5Pj22XVvH9snOidhbyu+YdVRvtL013FIPVZOK8jZx9G8MQH1LLfF3ia0DVaUdt
	wwKpXIBnha6Kkp3vMF0TG3g2eiR/0hSqqxiZCgBaJZHY8sOfsleQ/5QM1/03e/qcRGQ/QWd2njo9v
	XGXfkOemGYL3VL3WJzNlCmpvKmDWeXSR97TmE9+xzkmdRTDQt0b1hKRCz/n1OYq6lSnCa1uzASyOv
	W1cgSPLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu4M-0005U1-8u; Mon, 03 Dec 2018 19:39:50 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTu3u-0004xs-Na
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:39:26 +0000
Received: by mail-oi1-x244.google.com with SMTP id a77so12031419oii.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q0uTXcZC7CgGiF1z+ovGMxQ4WshXHCU0lPOOgvBHLS8=;
 b=f5HgdvRmkq/e8B4jAjg/KiKg4lYQXfos1Mhy+1mqB12T5wt7UjKCKSMlRjV6NJKw2o
 vg9KTWzjuFPZkesGakRLnMjaq9eKGHZA/TNKN8oywZUWldXTg0bcIk/uAJm0AGOMmbU4
 LqgX0+oOtR6XbP7uc26A+N6OJb6C5HMz20ib4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q0uTXcZC7CgGiF1z+ovGMxQ4WshXHCU0lPOOgvBHLS8=;
 b=TYkFlc5B4z3IUira4IgAKVZx1jLID0z14nCm4F8lfIQxbMzGf/Op9Tq/eu5lFsUNUi
 SO+E+rHJlz1t47Yn4alLybhxkOuUe7WS1g+pPAGvagJXZnehewWUBRBsqD5iqN1R+NTn
 YPTqq6+f7gR/yGdfl1MqarmC3FD3yM6qKlHytNz/1JAzIofsmbj+EgMqopulmb3ricwb
 rPWdPb4euKyBrLSJDODR8cOvrElhTEEPBnbW5IVWpwrAWEHnTmyuS+xzntbN9J/3cfqx
 de6MW9xgdhFZqbb7Z0liKf6P/Z/A04BhkEgYvWlpgVPrE7zkPq+iHhs7WWISkG1WlYSk
 yV0Q==
X-Gm-Message-State: AA+aEWaQEzdhWHIUcdjo77oaYLmai+C5awgLPE09RG2oGJsCAw+Cm/nR
 xC6DJZJYaY0INp60PixnfZxWiw==
X-Google-Smtp-Source: AFSGD/U8tc87YBfVwFW4SsyfbmMWs6bT3c8wmJKuZO++ag18KSKYUBs6iWHNpUp22kAk/2bcB9JKwQ==
X-Received: by 2002:aca:a648:: with SMTP id p69mr10306397oie.205.1543865950829; 
 Mon, 03 Dec 2018 11:39:10 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:60aa:6557:7f4e:5d7d])
 by smtp.gmail.com with ESMTPSA id j33sm11170309ota.32.2018.12.03.11.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:39:10 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.21
Date: Mon,  3 Dec 2018 13:39:04 -0600
Message-Id: <1543865944-3591-4-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113923_006479_A0A4A6D5 
X-CRM114-Status: GOOD (  15.19  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.21

for you to fetch changes up to 972910948fb6f555e83f37bc6172f51984d738a9:

  ARM: dts: qcom: Remove Arrow SD600 eval board (2018-11-28 17:36:41 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.21

* Add entry for Qualcomm TSENS thermal drivers
* Update msm8974 thermal entries
* Fix msm8974 Hammerhead magnetometer gpios
* Add SoC specific compatibles for SDHC nodes
* Remove Arrow SD600 eval board

----------------------------------------------------------------
Amit Kucheria (3):
      MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
      ARM: dts: msm8974: thermal: split address space into two
      ARM: dts: msm8974: thermal: Add "qcom,sensors" property

Andy Gross (1):
      ARM: dts: qcom: Remove Arrow SD600 eval board

Brian Masney (1):
      ARM: dts: qcom: msm8974-hammerhead: correct gpios property on magnetometer

Douglas Anderson (1):
      ARM: dts: qcom: Add SoC-specific string for sdhci-msm-v4 nodes

 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/Makefile                         |   1 -
 .../dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi    |  53 ---
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 415 ---------------------
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   4 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   3 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  12 +-
 7 files changed, 17 insertions(+), 478 deletions(-)
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
