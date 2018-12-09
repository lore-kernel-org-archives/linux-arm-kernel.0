Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A5C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VFmAE9/F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvv0DObT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nX0u5g2wlKIqBZhF8aDPq7Z4YvxfOElg3EU13ufKwqY=; b=VFmAE9/F7JlOoujem3+lcg3i9t
	poa7QcuLQW0DFDNbCAxaZ7ds5ZJlrwWFF1lw6fYvQctVhsYQkbuRItOHVKKIl427Puj/3nlwNY/mL
	gETz1QQl6oWTvyDHuwXSR7yycXss6RBJQi2piBBwCr7AZNd017UGJgIIC6ZjrYw4VM1liGJbo4Fyk
	W0DVLzjOptPhjV3YFvPDZhA033iG5FIO2n452hZnxh8+By5bsY0yBVeX58O6dFoCZOIe2loH6C9wZ
	PxEprvrkPQthRMNMV46UClzBOjuO/tEDmCD6KBzKN6gmrxbroBK6+NDzgwJFsVXfhcPYcL7SBZgDB
	PY4WNJMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVxam-0002xL-HA; Sun, 09 Dec 2018 11:49:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVxab-0002o3-As
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 11:49:38 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 105982086E;
 Sun,  9 Dec 2018 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544356162;
 bh=wIZt+jQYqUS6fUV1d8DgP5TSupV7p7p2ygQwl0dXTEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bvv0DObTdjnAiNNrObhg8N/zUEsJ20oK5aNmOV+JT6W+6wok3V6lyww+Qo5sVbyG0
 hproRJZPKO8JWyYdatj3Rmjb/Z+/sjnf5v+VNlW1zmn2O4HI5Db654N/YLDauoRhYV
 gPcWn5MnZn08XjPs613la/3cN+KIiu423cZcH+Pg=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 1/4] ARM: defconfig: Exynos for v4.21
Date: Sun,  9 Dec 2018 12:49:08 +0100
Message-Id: <20181209114911.25194-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_034937_395336_1631D5D4 
X-CRM114-Status: GOOD (  10.93  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.21

for you to fetch changes up to 24c8e4b85399b00f4ae96e7957b0eeaa374e9380:

  ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver (2018-12-07 20:18:47 +0100)

----------------------------------------------------------------
Samsung defconfig changes for v4.21

Enable drivers in exynos and multi_v7 defconfigs for MAX8952, MAX8998
(Samsung UniversalC210 board) and TC358764 (Arndale board).

----------------------------------------------------------------
Marek Szyprowski (5):
      ARM: exynos_defconfig: Add MAX8998 RTC and charger drivers
      ARM: exynos_defconfig: Add MAX8952 regulator driver
      ARM: exynos_defconfig: Add TOSHIBA TC358764 bridge driver
      ARM: multi_v7_defconfig: Add MAX8952 regulator driver
      ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver

 arch/arm/configs/exynos_defconfig   | 4 ++++
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 6 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
