Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51643C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2218A222C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1TPzD+B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r12BhEqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2218A222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Nszj6L/1fqRjMBC118DrL4yUa+OyqLoPBUR7iD2MQwM=; b=j1TPzD+BJQHrGE
	roWBOMKRuQ6DIATolWt7F8HvxM6D8UxwfTsVOE5JQpVHCOeMUS7O5b4lZEMrN8cMhTzNH5lxpek1V
	IX/QwrCgMALIjUR5lXb9M2ZQpfoQQ9x8mYqlW2m3W//glcEDEzfudMEcoVEAzwrC/Wqg1UgCtch3Z
	ulml7PkgAmTOOoa+Zy551fKpKr4N4wknc710y5c86gxoso6lb7bINvaEpgJ71EU2TQshf3iMn7QhO
	2NwBmsv/cYzUb0CbdIKaajUk4Ur67FZ6W4N76YoAGCzAr07G7ZOiKB3hjs4XVpv79g3/mQzMxtZ2U
	UO2Usp6VC3AlR5P0EHjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcD2-0006hS-DE; Tue, 12 Feb 2019 17:51:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcCy-0006h2-Ta
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:51:02 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72BA420842;
 Tue, 12 Feb 2019 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549993860;
 bh=Y9Q0OxZhuzcTIEW9s/8KTeqGtmmlVTtjf2PpH/LOqnY=;
 h=From:To:Subject:Date:From;
 b=r12BhEqKl/QWhUrqlqyXZGGxy5N9T0hfqus0VxArxehSmfIwRPSqO5z8U+Ig70Mm8
 7aFDfi3XJPHyoLes+FFw2qFcJRTPI51gjjRK6GL7eGZfjWllOfPIpvFzM+aHu1T+Mg
 zV3yzgAvNdKD6LGlaJEBf3A8V2aJJ3ivpesWUYK8=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/4] clk/ARM: exynos: Add ADC to Exynos5410 (Odroid XU)
Date: Tue, 12 Feb 2019 18:50:48 +0100
Message-Id: <20190212175052.6310-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_095101_015494_7F013A7E 
X-CRM114-Status: GOOD (  10.95  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The DTS patch depends on bindings header with clock ID.  I will take it
through samsung-soc for consecutive release.


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  dt-bindings: clock: exynos: Put CLK_UART3 in order
  dt-bindings: clock: exynos: Add ADC clock ID to Exynos5410
  clk: samsung: exynos5410: Add gate clock for ADC
  ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU

 arch/arm/boot/dts/exynos5410-odroidxu.dts |  5 +++++
 arch/arm/boot/dts/exynos5410.dtsi         |  6 ++++++
 arch/arm/boot/dts/exynos5420.dtsi         | 18 ++++++------------
 arch/arm/boot/dts/exynos54xx.dtsi         |  9 +++++++++
 drivers/clk/samsung/clk-exynos5410.c      |  1 +
 include/dt-bindings/clock/exynos5410.h    |  3 ++-
 6 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
