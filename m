Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E99C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BFE2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fAkGCe+N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmz5BwRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BFE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WRKZLw8aL5BmVduMpnbjjNgGZ0idQbgEC5jTFMarWwU=; b=fAk
	GCe+NzQ0n745BmIU1yS1MKA+Z8mtCpVL7hESvK1P9UuD42pbZi4zivHTslzuaf4VBzVKES18+KDd+
	FychGh+zfi/h0n8z1gf7QQgD9wY4epCNluHH+nXYz0tGVONK5lssRi4dMjm4GClxh/xPx0UMwBLqM
	nLjum1GUB5jTzRTrR3x8OarGQkw8QjdUj60NVO45Xx0p6hRMCx3JeE49h/WXxKnqE0Bi4bgk+7I/T
	NMmeOMewvyjCHKNfs5WOR2UgYVqGInVkcj26evo1bAyYcZ+4ZMWx77Kn17zRsxe1OArRyzkertpnY
	HsgEYMOIVdQL9pdMHOopXZZlDo+bDew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVUvk-0001o2-HS; Sat, 08 Dec 2018 05:13:32 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVUvg-0001n1-QH
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 05:13:30 +0000
Received: by mail-oi1-x242.google.com with SMTP id t204so5107194oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 21:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=61Bb+nWCTjnAlYvzPgw6H01DWz5Odm+nab79rd34nOU=;
 b=dmz5BwRsh6u7gq+jHybhXvo+YcJ5jgbwLZV+IGukcUv+pw7T3lhM+yfEEO803UshUL
 BdVD2pnKlIN4HisXJ/XAauJ5PzZXUt1sZ3ufEJX2KVCSw2wyokT0oNGh5wOUm5G3V2Nv
 mJ+CZfMZ7Ma7HXtQzRNaBBvwlotoEg28hDa9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=61Bb+nWCTjnAlYvzPgw6H01DWz5Odm+nab79rd34nOU=;
 b=AuctBfU/AFTnXs8JZ5w6pA4iqaH+0XFKrFyFs/lS2mD2xTC6qXlHmoLwymCe/he2RK
 ZTcB/yJyKL+W8Vy0ho3ibWPtjItV92v3wagLHIXkyFJLLhTogCy4JDu4DmzeJCOouT/+
 QoDZvgh/kLOFSU4sI/BuMvFSLA2ez2IFJoDIMFhdrbH24xXiF1JutSSN2oNKfW/IQH7W
 J5VEKui0VW0Dxx/+RYTc5f6/Ykxtw1HwexVHQxQ3tTviuTIRHoUnBChczbzPBm1l9gbE
 XYYYSq5akMirkw/jLgrbuFsF2tHhrxhht71XUgpqZMmkQit7hA+slRZqY7cHPCv1RjF4
 7CCg==
X-Gm-Message-State: AA+aEWa6Or8Xm1lYM+e50DZ1jd16BnuB3ysS0qmU/OdOhRpsuOhz7tOa
 42Yw6liu1yjoBv4y9lBApPPnow==
X-Google-Smtp-Source: AFSGD/W8SgYgQt47bWwnFgxF3zzSaNHoY5GaW1YYvP4qrpTR7Jx8oE2G3BmDR23dw+NmvfE+CSJ1mA==
X-Received: by 2002:aca:36d5:: with SMTP id d204mr2980601oia.234.1544245996434; 
 Fri, 07 Dec 2018 21:13:16 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
 by smtp.gmail.com with ESMTPSA id r9sm3143749otq.81.2018.12.07.21.13.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 21:13:15 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.21 - Part 2
Date: Fri,  7 Dec 2018 23:13:13 -0600
Message-Id: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_211328_875114_774CBE20 
X-CRM114-Status: GOOD (  12.04  )
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
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 70827d9f6bc4f481fafe790dd6654ba568526768:

  arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21-2

for you to fetch changes up to 1504b91c819359b574b55c269c850352260b8d19:

  arm64: dts: msm8996: Use dwc3-qcom glue driver for USB (2018-12-07 14:10:56 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.21 Part 2

* Switch to use dwc3-qcom glue driver on MSM8996
* Fix issue with xo clk name on MSM8998
* Add cooling maps on MSM8916
* Add UART nodes on SDM845
* Add camera subsystem support on MSM8996 and MSM8916

----------------------------------------------------------------
Andy Gross (1):
      arm64: dts: qcom: msm8998: Fixup clock to use xo_board

Manu Gautam (1):
      arm64: dts: msm8996: Use dwc3-qcom glue driver for USB

Matthias Kaehlcke (1):
      arm64: dts: qcom: sdm845: Add UART nodes

Todor Tomov (6):
      arm64: dts: qcom: msm8916: Add IOMMU sub-node for VFE context bank
      arm64: dts: qcom: msm8916: Add CAMSS support
      arm64: dts: qcom: Add Camera Control Interface pinctrls
      arm64: dts: qcom: Add pinctrls for camera sensors
      arm64: dts: qcom: msm8996: Add VFE SMMU node
      arm64: dts: qcom: msm8996: Add CAMSS support

Viresh Kumar (1):
      arm64: dts: msm8916: Add all CPUs in cooling maps

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi   |  76 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |  97 +++++++++-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi   | 120 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 162 +++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi        |   3 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi         | 270 +++++++++++++++++++++++++++
 7 files changed, 725 insertions(+), 9 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
