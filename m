Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE665C65BB3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6392086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I0nJ8rSI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gqjySLsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6392086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TjN3H8hJBinanVLonsujZu0igaR/5K6g9JEzwLC7M/E=; b=I0nJ8rSIUb5yz0
	RaDwMqblq11uUxZjUDBdQ7WCEXyPySO7Q+qfKiBzNq4VBGtOetvO+lL9Qe6tZTASnnrSWg8KY34q/
	jvdDWALjKYKGRc1CHUrkYWuG5Vn42cJIuc9jWBLyrduwnA23l72oZBd6vzj3TS5WXT/C1YCGcmNL/
	WXHUH2ro4dBKbSvD8QtvuXRSY1EOCVDakyHCX8XxdzDvQTsjaWLUjmZLBkKPgrVmDZJKFG4HIl6My
	otyK+FJqHLRgBJ5sq5gIj/fPSTMWYG99qQbD/EPsaV4ZJL4xt+JVlT1dNwxsAdKN2rkX9XBVabr7b
	2h0W7GW3yqy7fk3CG12A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK89-0000gY-72; Mon, 10 Dec 2018 11:53:45 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK85-0000eZ-DU
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:43 +0000
Received: by mail-wr1-x435.google.com with SMTP id j10so10165362wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CrjHwcuROIb2yaHjWhbPdQUeR2mzVfHSy4hu2P4P2YM=;
 b=gqjySLsFWbjDh5S/oJf9ihN5ukXUQ0uZminWG3GS+B4kBMIfeYK12YxQa44ofGoZtl
 J/NUqHB3sJ+Ht8TX7zOhKxTjij9w0j2lpsD9vMN9huZ+04MJWKIRg50rq8dFOc6fTAJV
 7YxMRDJgCEM3Ort9TtHOqF7hvfjHZA4M7bcd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CrjHwcuROIb2yaHjWhbPdQUeR2mzVfHSy4hu2P4P2YM=;
 b=thJj7hh5raJ+z0RB0zrStUMcR6iRiS34fpz7yZ7LT1uD5G16ACu2apY9W9kDOPqhwf
 c9ov9D+mwM1qyX5OwXXvIMXhaZVLncjVC9mJKMF867mGg/K3+QNcyASPm54m+pu/npbP
 8RwFXh83K7XkaCLiQdFcaDrq/FecKAUuqVar1caVigW1ATB6RSl2dBaOGWpjZGzXiwiO
 3b4hKiZCm172Ohzn2aWznLy12jHrUlqTnBLQiHVjIzSxVfTvGoVnCok+gaNfjZ0BsCyS
 SxbrDv6hhrOxpKzX2LY8QNY5fzFQm9+MEAXf5CQiG+jY5Sq4mxyjhTukKw/4NI6wTu7v
 coyA==
X-Gm-Message-State: AA+aEWZDDAchETK0HkzRI0A3yDsRtu4+Ucizj+DYagHUkD07nuEyAluJ
 /tZMnI/ShxpwplDBu/uzoWTBWA==
X-Google-Smtp-Source: AFSGD/Xg5dlEHx0sqv/GAzXC/PYVrTNVwS/ru98fByEDIf2fuH9Z+t8M5fNdnbA6dA0lKKcMqY7m2Q==
X-Received: by 2002:adf:8068:: with SMTP id 95mr9524972wrk.181.1544442808329; 
 Mon, 10 Dec 2018 03:53:28 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:27 -0800 (PST)
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
Subject: [PATCH v3 0/6] media/sun6i: Allwinner A64 CSI support
Date: Mon, 10 Dec 2018 17:22:40 +0530
Message-Id: <20181210115246.8188-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035341_457486_FE76E6BD 
X-CRM114-Status: GOOD (  10.64  )
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

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

Note: This series created on top of H3 changes [1]

[1] https://patchwork.kernel.org/cover/10705905/

Any inputs,
Jagan. 

Jagan Teki (6):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 compatible support
  media: sun6i: Set 300MHz mod clock for A64
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../allwinner/sun50i-a64-amarula-relic.dts    | 53 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  6 +++
 4 files changed, 85 insertions(+)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
