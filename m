Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08136C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA25020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uiPK6bwm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpUGAYnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA25020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=owTsMNtgBxBFAn195TwlV48wkAkPzgc2YIROwq+JxEA=; b=uiPK6bwmZlzZ2C
	iI/TjHUmWffK7VP8fsQ9Grls2ua4tQDx5IAcqwp3ssIA3aHZjGMA2y1YR/0zjFwMRllP3DJZ2PwxT
	yC+AfPA4RuQ2L40HGeA+jBiZ/FScRdZ8CTElmqvFUJhRtOl2no9q1KknFupsT0a1NBTi70XOBmsnm
	M4WNqWXudwgOX1EoYE3WSnWUjp7l0gN2YCAec+k3Wvt5dcGa+ADLmrKE5XDJ4XFbH1FWLxXfbZkOt
	K6hTBID+zqtM83PbKwp4j9PRxmAquIq/7xSb1Nxoiw17vRpRuvBJlKneWpGUHcYstnlHlQVOVLvWG
	GbgIUZFJticV2PDoWCQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7nT-0002HZ-J8; Fri, 08 Feb 2019 15:10:31 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mi-0000FP-JY
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:48 +0000
Received: by mail-wr1-x433.google.com with SMTP id a16so3982124wrv.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N8wd1+Gy3f9veXKUB76yytIIre9xy27414Y9mw2m+VY=;
 b=CpUGAYnP0DBnzvRtNp4M2svfN/ksL6GYS21/I/21MS4Tm7xljFrh9kbDkWlXrAcHVu
 FfHYpeoRUg+CCGgbYN4k8VDguBXA/uRMyzet80sKHR2NHVvBAEnAiNYsBkAEBgIM6pLv
 Y/4a63bFRvI17VJS5ee3jdkqwOVPXQh7fGH2wunb531LoYSvKinhOSfo8zft3MNiT7ON
 PLTyUu0t+P2fwJhzqLdpNOJrZLMJp9uVL5S9ETh7NmXj1YDL0BxDIGuklZgxpvdx+p35
 ev0QvIzRs3piiOy0gCEPYjMitbs4TOyhEnxIIq55roJA1sq9X8gPVHnMtbggZd1fNAqZ
 6GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N8wd1+Gy3f9veXKUB76yytIIre9xy27414Y9mw2m+VY=;
 b=tD9VD+qrRyjXUOE5sCJTs4KnLQ7YpfRNWMxFCvHq4ZCu5VHOoJLtDcOsToMtXy+/N/
 GFvICzdnlSXR0MVhLYT9foR+AcTLWBV2V/Eo171NJqZ732L5hSDMiSSZnLyQsTTomlI9
 D4lUYn2eb/ewDfCPv9oy1eRBJhOUSy6hj3Irk2duTI264QW/oMZNDJrKPrQOW+23v8xS
 +xeqg3BAk1SY9QKp0PrXxg8OCQOQlzM1Q9H5TPgOAk0B0jQKeq3UqNyW0vODCk0fRkkT
 z1n5D7c+l10cqGXXRnKlMuWbs5jf6EiXE5VB1C+0rUqZ8I/Ahk6hoNPyxNL6GsJGIcE0
 AAFg==
X-Gm-Message-State: AHQUAuYr/XBhB1D2Uf5ch3TLLSbUtQ4Eks9EAv5DNIbL8cvWVmzb5kOO
 1VXZ+60V6VLdIBFy3rhEBy0=
X-Google-Smtp-Source: AHgI3IYzU0C+SOUqKALr0c6kqoNjqgTg0jfYoXR+gR9d0v8SNIEaOV/a+IWoq+XI6e9mtnQ7tX2/wQ==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr16538867wrq.204.1549638582009; 
 Fri, 08 Feb 2019 07:09:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id v6sm4641401wrd.88.2019.02.08.07.09.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:41 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 3/9] dt-bindings: tegra: Changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:29 +0100
Message-Id: <20190208150935.32108-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070944_864367_9AEB0E90 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-dt-bindings

for you to fetch changes up to c79a3ccb191809c356044564859c275fba8e5b0f:

  dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required properties (2019-02-06 14:27:52 +0100)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: tegra: Changes for v5.1-rc1

This contains device tree binding updates for CPU frequency scaling on
Tegra210, BPMP support on Tegra210 and support for NVIDIA Shield TV.

----------------------------------------------------------------
Joseph Lo (3):
      dt-bindings: clock: tegra124-dfll: add Tegra210 support
      dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from required properties
      dt-bindings: cpufreq: tegra124: remove cpu_lp clock from required properties

Mark Zhang (1):
      dt-bindings: tegra: Add Shield TV device tree binding documentation

Peter De Schrijver (1):
      dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM regulator

Thierry Reding (1):
      dt-bindings: firmware: tegra186-bpmp: Remove name property

Timo Alho (1):
      dt-bindings: firmware: Add bindings for Tegra210 BPMP

 Documentation/devicetree/bindings/arm/tegra.yaml   |  2 +
 .../bindings/clock/nvidia,tegra124-dfll.txt        | 83 +++++++++++++++++++++-
 .../bindings/cpufreq/nvidia,tegra124-cpufreq.txt   |  6 +-
 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  1 -
 .../bindings/firmware/nvidia,tegra210-bpmp.txt     | 35 +++++++++
 5 files changed, 118 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra210-bpmp.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
