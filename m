Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2AEC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F6D214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bmWZQP7J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KWmHf7di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F6D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1ZlNAIVZndE0XDoMj2N2tBMkiTL2gnEahQJSw03jDwg=; b=bmWZQP7JuKCTsl
	u5KXsrw/fCsihZprr5UlBSan1s3YhDZyARPl8OCUYDx14lQrKXQk+MtVgL3Q0nU9w9JnXqLbBYqDK
	GIcBVYM0d4FgB4k6NJ3aFp6vyjKeBcTvKNhgowZM58ciKhLd2UDJXfnMNhCki2zt6NfPRmROhrjsd
	Met9CEU2Z04aSa3LGRsUNNxZagy/Alh9odH1PMSgfWM0V75sAyc0Prszz9REbzr99DZksnL0hVMID
	dcR/y45eWTxKduhNfDr70grtulzSGTU2hcp0dpegsyA5M/OPnGeidjZy5ToB6PaUfXsvFSxYNcXJH
	T6mqd3XgfTVP60zczbnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPh4-00066Y-HE; Tue, 29 Jan 2019 09:28:34 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPgx-00062p-Ny
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:30 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501cbc0000>; Tue, 29 Jan 2019 01:28:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:28:27 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:27 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:26 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:26 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cb90000>; Tue, 29 Jan 2019 01:28:26 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 0/6] Add CPUidle support for Tegra210
Date: Tue, 29 Jan 2019 17:28:17 +0800
Message-ID: <20190129092823.24983-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754108; bh=4bxqocVEC1IvgeNKVhUz2/6eRGPOIhwizO66pE/ZGBk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=KWmHf7diz66ko8XBRAGIA8VSEgiSJ4dNgoziUh9Xcp6ClhDNkx3zujjj7o49wPuLP
 bB402yaPorAE/Uko/spNdky/A3Ar0drxT3p7aj5b86pAfVuHe+n3NB3WMCfGVF+i18
 2VFbsJlW8S77a3NTJVZQ+/QxNTOWzvWYeq8pniNrTSm/ZWcOoMWNsKqypbK2TVcU9G
 WthpeiEj1y1OziVGvM7gpS0T+MSJEb/UjGktYY4RxyQn0YBJaeW0cMFcN4kY5os25s
 5MrEKQvorIyfWDPqCa+E57h45thYMR3MgQ9LXEnktSu+y6hdY0sMjynZXauiLBay63
 CHJVCW7h6HOZQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012827_954685_2D926AC8 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds CPUidle support for Tegra210, which supports
power-down state (C7) for CPU cores. And due to arch timer cannot work
across CPU core power-down and power on reset signal event. We introduce
Tegra210 timer driver to work as clock event device. So it can be the
wake-up source of CPU cores when they idled in the power-down state.

Fixed in V3:
 * use timer-of API for Tegra210 timer driver

Fixed in V2:
 * list all the timer IRQs in the binding doc and dts file
 * add error clean-up code in timer driver
 * add entry-latency-us and exit-latency-us properties for idle-states
   DT node

Joseph Lo (6):
  dt-bindings: timer: add Tegra210 timer
  clocksource: tegra: add Tegra210 timer driver
  arm64: dts: tegra210: fix timer node
  arm64: dts: tegra210: add CPU idle states properties
  arm64: dts: tegra210-p2180: Enable CPU idle support
  arm64: dts: tegra210-smaug: Enable CPU idle support

 .../bindings/timer/nvidia,tegra210-timer.txt  |  36 +++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  33 ++-
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra210.c          | 246 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 335 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 create mode 100644 drivers/clocksource/timer-tegra210.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
