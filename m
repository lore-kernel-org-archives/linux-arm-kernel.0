Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:28:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA52920838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+LKG0w/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nDUQnmSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA52920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RQ+KALj6tblZAJLLV5aCozALG4utFfvxP9TkoTYp6Mc=; b=W+LKG0w/rLQQnH
	thRwFAA6MbT/P/zgW+MhSzWVV+2+zZ/QapyFw3jhjOgLGrKbfioNkdiY0yz0GheFQEHix4e+9U7aM
	7wk/FXaMDzrivSB8M79sHzCPjjKSOzVer+fcQbugdneVzxOt2O3jrNYSYUNfN6V4ywc8DjAf6xo7U
	IG8F0SXINWvjF/bhSZd/9t3jRbonLxB0pf3H6AgF3t4k8rP44iFkR6tz48ZA/3Re1CpdizBd/RDFk
	JRnx21xzwCtgF8I0csme0hfqkXoZpvVb7cV+H3trkUyJS3JYtKScoNUe0kL1LKq8TvWsnUwJm4NuS
	iTdzyq0src4VjgojBa4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggLaS-0007vg-NC; Mon, 07 Jan 2019 03:28:24 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggLaP-0007u4-Tj
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 03:28:23 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c32c7430001>; Sun, 06 Jan 2019 19:28:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 06 Jan 2019 19:28:15 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 06 Jan 2019 19:28:15 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:15 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 03:28:15 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c32c74e0000>; Sun, 06 Jan 2019 19:28:14 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH 0/6] Add CPUidle support for Tegra210
Date: Mon, 7 Jan 2019 11:28:04 +0800
Message-ID: <20190107032810.13522-1-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546831683; bh=N03FYwW6XP9aefCfvgw6wcd6UWDxSU5D1YXpkvgnAQU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
 Content-Type;
 b=nDUQnmSA6FFZ55rrWq6FqooopmYgE7Xhu3dsbtRnjexon8XRBHek0NXNhjPX76MMR
 BA5eL45i4ORRLm5HeNTmWNjjuhM55Z/Gi8+CXtlp+CC8dQhHNEDovdKP+cmYgIZYwW
 6qi2PFb26gxvVkE5EmlEoVacgJvgNiwnQtW21rC9JLtHenA4S6ejNpqZueY/yHi9E1
 GGTS4Cp7YpOWolh7UxuKzg0iV91PJNo1V/Vs0X6pCQPilTSF+BsATxLqTMVWf1JneS
 cf3D576GbPNz/xEmybgwe5Xl+3KTs43gMPDZ9osPt+8rRgyL3DhR5926twNAAb9vbq
 Ajg+p9EiRR/Vw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_192822_027449_37BE4D25 
X-CRM114-Status: UNSURE (   8.52  )
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

Joseph Lo (6):
  dt-bindings: timer: add Tegra210 timer
  clocksource: tegra: add Tegra210 timer driver
  arm64: dts: tegra210: fix timer node
  arm64: dts: tegra210: add CPU idle states properties
  arm64: dts: tegra210-p2180: Enable CPU idle support
  arm64: dts: tegra210-smaug: Enable CPU idle support

 .../bindings/timer/nvidia,tegra210-timer.txt  |  25 ++
 .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   6 +
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  29 ++-
 drivers/clocksource/Kconfig                   |   3 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra210.c          | 240 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 305 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 create mode 100644 drivers/clocksource/timer-tegra210.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
