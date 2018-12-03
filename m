Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F427C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA9320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="So0LeZbZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="D8HGrzy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA9320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=t7Pnl3efDHxBRouP39cCIPFQ44dOkBnh53XxbJbDwJw=; b=So0LeZbZMrIde+
	Hxi+gc7i0W625TUM8xRcOtn9q44vbhUnSLCM3ogL/7Qlr+TzxnfbLmX8dBx6ss601rCjxheO2/tul
	Bnq0jsFZgQOUBjGvUKiI/XNhJ+WHLum/RrOX27vlXVOj2rBWRDbK+VclthfaOjXWWFyxIMvYm0nKK
	EHb/h+61pEi/rRycQKKINsZdi7NzvBWbKXG5wrWUl/w1mD/zSivIyT2ENIOVT/lTEGbVZYYn/Y+Pd
	icgUtkxPAzwZAiszRFwHMc19hxwgraRzJ5ocUNeIsdF/69CYKmVV+eOMdrAigaDREY72Qx8YQ4tRj
	BelYyrhJ+9fSys8aAKXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl98-0001SX-K1; Mon, 03 Dec 2018 10:08:10 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl95-0001JU-3B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:08:08 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so11459722wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gylxsZ9fcYlwwbMYTHy/WVwKOtRSFqkbXsc3NH3T39A=;
 b=D8HGrzy7OYGWo08Qc+ECKpX1y2ejt5+HrIc/yd+Vbf49JlWm2ZtoOGx6cVj697YjZB
 ZJrcHmYFaBvGDFacfQ9PvGob03Zzvd+GFDzL/EnZ8oE6nKeKfBWveveUlZSZtvmkvRRo
 jqqsnsC9ocZh40KMwLM4IAvllIzfpIjKgl5CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gylxsZ9fcYlwwbMYTHy/WVwKOtRSFqkbXsc3NH3T39A=;
 b=sNcEKXBUnPsKo22QIGeO4vHlloqeHDkY63h1F612L87ok8O0FxZb7g3+7FHXoKnRZM
 NhbWoU8nEavR+/0tIU+4tYD4q4sYv8e63BnxDkxLdSan5MntD0HmM62N/pInNdZbNzfx
 HohBXFhcpe7xnAIUN9PYokaDiYFIT4Spz8d0Vs/krsmo0Lpk3MAH00h6EbXYIFoA07kZ
 IivbILT+gF1VKn4sq5YcedjNb8t0EEQYpjCPaUzR8KZNnbo6ibhp2TId5wolQhF2S4CB
 OhVDqf210me5B0hBY4zjDyX+Ltt3ZiTXq+8gnTplEzfvOuHzEg0e2+WgF1IRHas+Pf36
 Zp9w==
X-Gm-Message-State: AA+aEWaeK28O4IvMK0gSXbwkjOEnJaIoOjXXz+FEWEJM3kT0dcE5KJvO
 PYMokYEdQpRXqV68wfu/OUHLvQ==
X-Google-Smtp-Source: AFSGD/X/ftP2iitUfgcxC8dWoPI4Wirc8tHDe0MCInKQ/fAjCaSEPe51HLEf83+T1guceMN9DtEBIQ==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr14405877wrw.113.1543831675070; 
 Mon, 03 Dec 2018 02:07:55 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:07:54 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] media/sun6i: Allwinner A64 CSI support
Date: Mon,  3 Dec 2018 15:37:42 +0530
Message-Id: <20181203100747.16442-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020807_135296_462E643D 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series support CSI on Allwinner A64.

The CSI controller seems similar to that of in H3, so fallback
compatible is used to load the driver.

Unlike other SoC's A64 has set of GPIO Pin gropus SDA, SCK intead
of dedicated I2C controller, so this series used i2c-gpio bitbanging.

Right now the camera is able to detect, but capture images shows 
sequence of red, blue line. any suggestion please help.

Any inputs,
Jagan.

Jagan Teki (5):
  dt-bindings: media: sun6i: Add A64 CSI compatible (w/ H3 fallback)
  dt-bindings: media: sun6i: Add vcc-csi supply property
  media: sun6i: Add vcc-csi supply regulator
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node

 .../devicetree/bindings/media/sun6i-csi.txt   |  4 ++
 .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 +++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 15 ++++++
 4 files changed, 99 insertions(+)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
