Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A4C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5542222C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8qUUOmW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="05BL48sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5542222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oUE64asgLOsixGeRCxngdRBmfIgx5B5MuCFd+aFJ7HM=; b=V8qUUOmWba9Y8+
	JAoVBoV7qiFWNhiuolwj15J1WIVIEiIb8ZZR05mY1WjrdhhHpFUJBAGnDuDkt5wqpFFOgZ48Ixu1h
	6u8ctBlIgnsMSPKUEoh/kj1cbuqBEWL8E/cspZZcdV5TpqsMjnvr83LM++Wl4btYf1JrLOXZ83c6V
	nN54iKy98j9MM4yn8UhjlpZjGtt2gm4JMYV9EHr6jImcBFt8TOJ/j8pF1NjpMnQAq98Sw435Ius/7
	n07/vRs3BQUZLLfgFnj8jvX5WblixPi5O7i7idh9PpqsA9hE32UFrBWQCiQIKH2ffsQqA6DgPSmHb
	zxMX2XOUHaMiGOvbb33w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtc8F-0001YC-6b; Tue, 12 Feb 2019 17:46:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtc8B-0001X3-1u
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:46:05 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A81E020842;
 Tue, 12 Feb 2019 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549993562;
 bh=mCMJyo7VtrJCKbTL0coPi8tQwBGv5oshlEKt9XIzZf8=;
 h=From:To:Subject:Date:From;
 b=05BL48sgJ1Whf3TZzGbhrTfVI01E8eqvBDuI4+tfQ1kAfdc+4AG3067f8MpKywfgW
 LfcMOGTy+lwiTZlQs0swbDJltFjz+IKBnrhHz4/30bjqTJNRm4dakcK5Q33u1rFkN1
 g3jiVFUXKWJT2xWaj8tcCbmmiAtyFM1G87IyX3Ck=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM/dts/iio: exynos-adc: Use proper number of channels
 for Exynos4x12
Date: Tue, 12 Feb 2019 18:45:48 +0100
Message-Id: <20190212174550.4383-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_094603_118911_88998CBF 
X-CRM114-Status: UNSURE (   9.65  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The DTS patch depends on iio change.  I will take it through samsung-soc
for consecutive release, once iio/adc gets accepted.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  iio: adc: exynos-adc: Use proper number of channels for Exynos4x12
  ARM: dts: exynos: Use ADC for Exynos4x12 on Exyno4412

 .../bindings/iio/adc/samsung,exynos-adc.txt     |  4 +++-
 arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
 drivers/iio/adc/exynos_adc.c                    | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
