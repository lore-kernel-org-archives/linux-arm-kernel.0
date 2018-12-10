Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67930C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342C72081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tZaSdOa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342C72081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=S/5NnZ5IEoFyapxrWkMBxwVWj54NdfA50+fcsv9QYmg=; b=tZaSdOa30e1Tby2GzprK4Bm4Gw
	UORj9z3qo30+Z3c3uu0s72U+sMa2jgIt3iH9ziFmTl/U+IQGizoKyyTk2pXQrAwTnzFqzTukRl9HK
	4yXuQVQuhFN30iHVIOA56qSPqfGIicvXHqtgSdQcuKpaD5N2mk8kyBk9GOtzHLy3ECcO+I6CaoTLr
	saLWsI1IQE1QQRtU9r0+nbPmT5SgnXbyCW3BhguMc+eSKvWsl4wSBUa3eCm0q9srbIqX2Y3+JwBaY
	OIlHJMV56qHaBCKtIS8Ak4TqFxt3B5iS4Nw++kie5krv5p+2sy5qZC9lJPKahIR/QyWMjjtAaPsF0
	7BAkE5mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGJG-0004kr-5P; Mon, 10 Dec 2018 07:48:58 +0000
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGIR-0003no-M2
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:48:11 +0000
Received: by mail-pf1-f181.google.com with SMTP id q1so4986355pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qiMOpb4pYmwrf3y5Bj3UQ9yacjQBOZgn6CxrG3UtJGY=;
 b=Q8NN+o3Q8USO9cWbVtmVPfUY/9gWYGr/X/Wx+y1aH/PACO9IBII5UR6ANWEBt5TH/l
 hjAqjdWOcALFlemEsQpeadTZuQ6J34D6OaN0k2O/OV+29E9FbaQpYmLaEuFgiluFfXR0
 bVUF9Ga8dC9RuZmYpenimvabQ40Fx05lYMpIGuxaW4VywmlMJrL5syVQd+yL45Yqmjpd
 IIz9pCPpP67VjmsplNkLS0lVytWXg0M5KwXcX+k2vZ8M03zwxAqCHNP5B1ulyAg8KtVi
 v5RMXk9xmm+K7kDGXxtvNxj0HvnuGbwGl20BHEoiDsz8/QW4YwOiUjLBsQZThmdRFCNl
 boow==
X-Gm-Message-State: AA+aEWYEqBnlj5J2nwtWFVXI9DxRqiWk3b6V9uaI1EaVJ+1lk9+ef5od
 53oUQtNZEs57tpep/bOytyMH1Q==
X-Google-Smtp-Source: AFSGD/VmIHrRStzJuOQwN20kpfUfxJ93htanx4ZUjzVIL+3ZEZqgu1wiTu81wNZ+fsRhcY+Vkeiq+g==
X-Received: by 2002:a63:e950:: with SMTP id q16mr10000634pgj.138.1544428076774; 
 Sun, 09 Dec 2018 23:47:56 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:55 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 5/7] i.MX7ULP device tree for 4.21
Date: Mon, 10 Dec 2018 15:46:36 +0800
Message-Id: <20181210074638.27873-5-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234808_207414_66AAE671 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The series depends on Stephen's clk-imx7ulp branch, which is stable and
pulled in here to resolve the dependency on new clock defines.  Please
consider to pull, thanks.

Shawn


The following changes since commit b1260067ac3dd5dcd40bcbcb2cc116a9f8b5016b:

  clk: imx: add imx7ulp clk driver (2018-12-03 11:31:36 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx7ulp-dt-4.21

for you to fetch changes up to a73900b826ce6faded48ee3e41aa890fbeba4068:

  ARM: dts: imx: add imx7ulp evk support (2018-12-10 11:24:54 +0800)

----------------------------------------------------------------
i.MX7ULP device tree for 4.21:
 - It includes the initial device tree for i.MX7ULP SoC and EVK board
   support.

----------------------------------------------------------------
A.s. Dong (4):
      dt-bindings: fsl: add compatible for imx7ulp evk
      dt-bindings: fsl: add imx7ulp pm related components bindings
      ARM: dts: imx: add common imx7ulp dtsi support
      ARM: dts: imx: add imx7ulp evk support

 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      |  23 ++
 Documentation/devicetree/bindings/arm/fsl.txt      |   8 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  77 +++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 346 +++++++++++++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
