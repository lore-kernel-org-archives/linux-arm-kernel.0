Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A575C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85C2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bI5qN/6w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cHT6eHFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EmhrRxVC2WJbwTHXPttfgwoJyLpSFP7c7ICProFGBdU=; b=bI5qN/6wqJe3xC
	TRbzSymTaP/Y56OwzityetfyOXpQiyOyuHnU0j/g3Cucd1AqYIlaYlMzX/93UtTJunJsAYYcgNWSS
	u3wff8Wg94amnjtMxKWOpvLtM0UU2Kq1P7o32jiMeVnXz+U0nFTQZEKgAnDr9J0y6Se03fTVVohEN
	hGgqlRt6Wep1GJ1sIxblDvmRdAky/mfwZVKDtjEW+l8GTIJbQmG8ivZExMIw/tqKf/nNcmUzWPVnv
	nXrfO5ctloaekg6ffldWRAaWm+dcFKVQAXLFkTPUqWKSyPCkFf+14IGIES5Ieb4uidGsFMLlzJP7l
	dfOI8DdGgNrYLqa6KWtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZxrC-00031V-6d; Thu, 20 Dec 2018 12:55:18 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxqu-0002eG-KP
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 12:55:03 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so1929045wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 04:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eTbaK90WQbfaV86T27wpc68Wcf5FjOqAAxWvucI8Kwc=;
 b=cHT6eHFTKRMSSmC421Kco6NQ1QX4vsq6K5+HUDiXg8z5znbqlXxDHiznjoZmYzhbJO
 e4+IYmMLcG/yiP4VG34PRvoLhv1+pjIG1AfJpxLElkp/YP5Vh/N/dS1nGEl3toDZwQiH
 0eK2r05nscjebi2TAOlq3F5csiKlPMCsYZAro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eTbaK90WQbfaV86T27wpc68Wcf5FjOqAAxWvucI8Kwc=;
 b=gnQWPNMciiId/iAzixrguQxHG3N40e/SqmVe41GsNNNf1ygUIVsLu3/R3H2AzYJg8N
 6v0+AfXBz6tfXSXrNJj7BV8IdPKx0/YjKR4Td/0J7eZMV4sCzmZ4mPeCCCr6X06iftSi
 Fb2J0vXknRQeuHb8YK23brRX1POGS1kWnZb6y2rJPoGnW4r31owVMKJpxBqdY63Bb7nX
 fgD9pAVNOO7uO65Hz4PEME4ed4RzNfPBN7GnDpoRnVTP8z8kIG8go/jltCJekFZ2Ng00
 sIgixYDjHs/liyfc8mcEfyVChMNivqB7b5DGUX/RMrAmORR7U+0f2wuyTvT2la25l/RD
 1rgA==
X-Gm-Message-State: AA+aEWaxIya6qCAUZ5ADPvWhaOfFdIfvsh9lBA4n6OIMk3S0zpteCe4X
 1QDzBwFSb0ExVPEdqIHZnoQVGw==
X-Google-Smtp-Source: AFSGD/XuheZcpZNUP84fKqUeymPOQ+YAc84cBD+JTnB3+xV6FvRUC1v6/b/HsdST6zhmycH6IQM4HA==
X-Received: by 2002:a1c:83c8:: with SMTP id
 f191mr11334134wmd.134.1545310488444; 
 Thu, 20 Dec 2018 04:54:48 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com.
 [213.198.163.240])
 by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:54:47 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v5 0/6] media/sun6i: Allwinner A64 CSI support 
Date: Thu, 20 Dec 2018 18:24:32 +0530
Message-Id: <20181220125438.11700-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_045500_668745_F4D82ED3 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series support CSI on Allwinner A64.

Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.

Changes for v5:
- Add mod_rate quirk for better handling clk_set code
Changes for v4:
- update the compatible string order
- add proper commit message
- included BPI-M64 patch
- skipped amarula-a64 patch
Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

Note:
- This series created on top of H3 changes [1]
- Tested on top of Maxim's ov5640 changes[2] along with
  the change I praposed wrt 15fps change on this patch[3]
- Here is the test log[4], for anyone's information.

[4] https://paste.ubuntu.com/p/pC9ZQKNzQf/
[3] https://patchwork.kernel.org/patch/10708931/
[2] https://patchwork.kernel.org/cover/10708911/
[1] https://patchwork.kernel.org/cover/10705905/

Jagan Teki (6):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add mod_rate quirk
  media: sun6i: Add A64 CSI block support
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 39 +++++++++--
 4 files changed, 124 insertions(+), 6 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
