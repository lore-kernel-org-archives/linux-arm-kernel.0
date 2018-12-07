Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C86C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68BA20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FsLZo/xp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Jl7b/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68BA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dqu52oqKbLmdUD1bAI4+CVXzyOw3X5aCIxsX1ad4E7Q=; b=FsLZo/xp934aAl
	iwDrCPFcBiGdHmKQJQWA32kzlwu/PFYf0wA35ZtCeH4iebwyxwlrnLtJz+yaxz/E58LN8++2NdkYz
	6wITffzEhzlSezlFBZTksMbO42DbV6E3Vxc+bwZMjtl7mg5IlkMkrfiW6poaiS9oBkaeZhURZM7mW
	SB8h1S6uM1qOGIb8bAIDRfCu5WZAsTpCfthjBlJoQaDmjdcCgERzsPZ4JiU9gYkJ568TtgG4V+kn5
	tcNC2/lywvLThhZvbLXybfx0mLCnLT5sbGpLwCf2F0/qU76z/uBWKX/2qryTySVgiCSPzcN8exQOO
	o0t4sPTZTK0u4fwKy1UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGx5-0001G6-KD; Fri, 07 Dec 2018 14:17:59 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGwz-0000oD-AJ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:17:56 +0000
Received: by mail-ed1-x541.google.com with SMTP id j6so3815131edp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxjks3qK3tzT8Sw5bOdBM+D7KyIDwJPY0jj65Zz136c=;
 b=k1Jl7b/6iRCGhtiRaN916YF9dp6Ci1QIvgXqg2TaBYWg8XtpcoSstv0K25vyNKc20D
 5Z4tvzKAGaz/H5MBOcCMcO4saXceA8PGJlfoez3oQiWa91X3SJBG3uggNFiiGJTos8nV
 ZXW8FFOaGOoNKg0uQRtZVbGuS8P+2h7YiQRhcq9xIIPQ+93raRLwjR+DM6OsGBpev+FY
 68i1vJc0gak02w4rkQ9KWE1zaAPrizUu0KJn8+fe2ep6Qps7XRUulZF7iJJoCmkAAEEX
 nEtMlQXHQ0X+8rvjM94mv3x66fZyJRgOPOlAYVX8g+v6S3/YWmvtfepulB13xqi9f7Wg
 RgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxjks3qK3tzT8Sw5bOdBM+D7KyIDwJPY0jj65Zz136c=;
 b=h9Bn6B668fBWApm1+iOirP6AQuqnJ/a3oZs2tIsTszCNj4tBb5RIlYfOJOMUIsqrTw
 BcQPXZX7Q9OwcAMaibWvDio3vO6QzqHq2pmF2oZoJ+aEftaY7v3HzyOnEFceiKPONCMQ
 Ft//8oPcZUOI8/LtfG11NamA4pq0wA5fk5ReBAkzm3cwEREdXPDRO/AKOXDyvMKrd3zd
 OyrQOGCQyrLAy9nwKCwvHbES+r9jwwAcNiCdyYmd6Sk+dG3wyoWMQZlm735uOkhmWFyy
 gOdZc6aGSDYqwZHy8f6is3gEU6Xv2CPuceTXFjHfcns5jqQZ0tvnro2WQ4JENYQ17hoB
 5Qww==
X-Gm-Message-State: AA+aEWbDv31SdbM5hwbr7/xN8FgfFrBoI74sP6n8ALzwfckc3HKxeuLS
 hTe74MpXf3wpGd3cj4fNTkM=
X-Google-Smtp-Source: AFSGD/UYCzsXTSm75xUJK7EGrpCW8HOtZm8fVwCE3dLw8bVKxDhwntCwy7MQxe/fl3lqyyuitfFBRg==
X-Received: by 2002:a17:906:b893:: with SMTP id
 hb19-v6mr2042798ejb.76.1544192261355; 
 Fri, 07 Dec 2018 06:17:41 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id w10sm1020491eda.77.2018.12.07.06.17.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:40 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 1/6] dt-bindings: Changes for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:34 +0100
Message-Id: <20181207141739.9085-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061753_382242_B9E6543C 
X-CRM114-Status: GOOD (  11.74  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-dt-bindings

for you to fetch changes up to b4c7bf003cb57220af64b59e887581e74f0ce527:

  dt-bindings: tegra186-pmc: Add interrupt controller properties (2018-11-28 16:42:58 +0100)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Changes for v4.21-rc1

This contains a few cleanups of and additions to existing device tree
bindings, such as XUSB, EMC, PMC and thermal.

----------------------------------------------------------------
Dmitry Osipenko (3):
      dt: bindings: tegra20-emc: Document interrupt property
      dt: bindings: tegra20-emc: Document clock property
      dt: bindings: Move tegra20-emc binding to memory-controllers directory

Jon Hunter (1):
      dt-bindings: usb: xhci-tegra: Add power-domain details

Thierry Reding (2):
      dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
      dt-bindings: tegra186-pmc: Add interrupt controller properties

 .../devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt |  3 +++
 .../tegra => memory-controllers}/nvidia,tegra20-emc.txt   |  4 ++++
 .../bindings/thermal/nvidia,tegra186-bpmp-thermal.txt     |  3 ++-
 .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt      |  8 ++++++++
 include/dt-bindings/thermal/tegra194-bpmp-thermal.h       | 15 +++++++++++++++
 5 files changed, 32 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
