Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B568C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E6621B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EDUWWi3S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HtJqKpbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E6621B68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kQiqL4Xq3wJqLDAS4IiGEozOS2J0t9Cwce1hRw3Zus4=; b=EDUWWi3SCpqjDX
	HK05Sy6tD2fO+vaMsV930ewWKgNrli/q0ugFYY/2Svo7votqNn6qAvY1LBvE2PG+sDglgu01QZ2Eg
	QZjYmBESHBfnBTSpeY5l9hV0gAS8IAc7HBnP+NWGIdzMms3ZRqyqh67ZynGxdaJ362MfoqWLLqIBQ
	HdOQt40VG9qRqfsGi5xFpgy8R9aoQsX1VL6NMy/XHdxZaNkfFJTcwcF81+/pXurZYjEOnPoTL4apW
	/h2DxVwzlrSh1zUjyPAO1Bo4ClaCd5mBY9K8UhhR7N94G/3rRf59iriOVNF5Ad/q9M3uwqNpSGwtI
	0w/hQZvoegfQnrr+HjbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMeB-00019X-8J; Thu, 14 Feb 2019 19:26:11 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMe6-00018u-AW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id n22so3589846pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aOWbOJz+q7a7Braxa6vSetV3DpRgUUln38aLV0BLFss=;
 b=HtJqKpbYpg8zKfhZ+PlLnTp/nVesVjTYGFOfafcc8PKPURO/GpUgkl01uMeHQIToDk
 ySlNaTOET+J7KmWBw29ZXEsZSmaE8rJBTwdUeTOhB34kJ/bRp9vwxxtNxwZsyJG54Ur1
 NkRXtan25VfunuZmxfAzgnipZTUUBk0VDIXkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aOWbOJz+q7a7Braxa6vSetV3DpRgUUln38aLV0BLFss=;
 b=J4BEz8z3YEV17UAz6Y3WrJJiKyZD+bTcdkocLWwOXAc9icy91/qP4HbuJzS+sEXVTn
 1p6k/1HrRh8gYLV8ELbbb8QyrqzJnYhANlNgjov8Fb89VYGo7NHhI/+hsNKC6DPCAGJG
 PLSuexd7jeHdibX/EvwzA9thjuFYXPTnQGZ8yfi0bswy5pZaJuoJh/MuWq8HIUEeNk7k
 /qGMiOHFRL3jEUB3eE6dplSnhnWFqG9VdS9EapVD+O819KHsMrhptqE0HaG81OG40riP
 0Z1PJec22zeUNojOdmoLh13y2mhjCisNgbWh400WoCVRrSPC0dGbLEQHg5h3/N5Hr66Y
 DmOg==
X-Gm-Message-State: AHQUAuZi/TB3Ww9RDwG1bmPyRSvQvvOYcmEaFNOaNJfUyF2m3hiy3mtX
 Nx8IctNu1WBAB8gH/sqbhWMRXw==
X-Google-Smtp-Source: AHgI3IYAFdoACBkxxZtv4EqVv6H5LD9pY1Nr6f8iwpffWOJ3mPN4W0siuDeuZwFJ2BQx1weh11akrA==
X-Received: by 2002:a62:864c:: with SMTP id x73mr5752695pfd.49.1550172365429; 
 Thu, 14 Feb 2019 11:26:05 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:04 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 0/8] drm/sun4i: sun6i_mipi_dsi: Random fixes
Date: Fri, 15 Feb 2019 00:55:36 +0530
Message-Id: <20190214192544.7314-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112606_842739_5C73A729 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These fixes are encounter in Allwinner MIPI-DSI driver while adding new
SoC support and ofcourse all these are generic with respect to controller.  

All these changes are grabbed from previous versions[1] and grouped it in
a proper order so-that it can help to review and merge easy.

Changes for v8:
- rebase on master
- rework on commit messages
- rework video start delay
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use existing driver code construct for hblk computation
- create separate function for vblk computation 
- cleanup commit messages
- rebase on master
- fixed checkpatch warnings/errors

[1] https://patchwork.kernel.org/cover/10680247/
[2] https://patchwork.kernel.org/cover/10680247/

Any inputs?
Jagan.

Jagan Teki (8):
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 ++++++++++++++++++++------
 1 file changed, 52 insertions(+), 13 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
