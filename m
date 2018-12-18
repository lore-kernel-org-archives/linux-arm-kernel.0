Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D476C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E9321873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0vrgYMC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vtPE5pMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9321873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hqpckiQ39jnZ7Wj/v5mIkIucU0blkRTpHu55ZTwAebg=; b=K0vrgYMC8sb3wwjBNdWqUhQ2b2
	9nQpmeDyCzANc89KNC1S2Gk8KyoCS67XGA5XBPVphn/0RwApps4Wax4XdXBOR0t2tMnwaaUOUMRY9
	EhqKiSlVijnQ5AaVm7cCVvSzpzu3C8DuP7ww50IIhPkc+JKtFzBqHMETx+7Wo0Isk0rHIhlBXzuoj
	rf3YcF19P3dMYhkKXctXz5FEGpbs5beF4r+XmiMkt1ajJJscPOmX1/KzWi90CCxnd2GAb8xXBtYpY
	ehCaNMUjbV9FBaZHMpOChj8Ons0odMX6uT30WsjthOM+n3R/BFayD6HqrzDi2g3V7/NyEsjzAPfQe
	4pLE/r+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLhK-0005nJ-Dq; Tue, 18 Dec 2018 20:10:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLh8-0005eo-Ld
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:10:24 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10786218AC;
 Tue, 18 Dec 2018 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545163813;
 bh=a1bfEZsI4yWUP/xuJWMQJY1H78hazjgTE7mf64t6iYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vtPE5pMMk5GvfdLIhH9oGgQ1WjDbzW1Bu1COTU2WtVE1r2O0B5+4fL956D9gbyL3F
 7YQwBdvNr5bKkO/btrkXRNdiKq7+Fm63rXHqT8VVU3Dj5Gz/xvV3igzNL5VUa1MD7R
 Sy7h6AcavMG99sg+Ch7mPfVm/p1j++bLinJBjyik=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.21
Date: Tue, 18 Dec 2018 21:10:03 +0100
Message-Id: <20181218201003.12806-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
References: <20181218201003.12806-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_121022_727145_83A4052F 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 9deffb5ee78e41e2a5d6c448874a24caec6467d0:

  arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21-2

for you to fetch changes up to 74ebbdda7cecf789661c208faccbeef10a7f05da:

  arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards (2018-12-17 20:23:32 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.21, part 2

Add IMEM clock controller (for Security SubSystem) and Bluetooth chip to
Exynos5433 TM2(e) boards.

----------------------------------------------------------------
Kamil Konieczny (1):
      arm64: dts: exynos: Add IMEM clock controller to Exynos5433

Marek Szyprowski (1):
      arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
