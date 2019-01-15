Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BBBC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FD1208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LKx3rwuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1NnsyYHIvnS8D3eKbe7KQhj+/BgxCD3+sAWFqiYiO9s=; b=LKx3rwuD5V98Pz
	CUQasoJYybxL4KHOVkY96KeAfvSdbZyxlfdZGfNilYqGpBtezELIoGccGZ4Rndu14bwMTWLuPtw75
	45Ezodec7YB5HgtgrhmzGJ/hX01ZNFj3F9+im59nYNjggiR+/MBI7ocTsNok21HvXNKlXw9bimK9E
	vKSY7ZYkZqKEIF+687AQIQ/xJeChw6IOOIqlDMnM7wTC+XMJrF1cxNevAj6eskLGJpuD0HyBNmmU+
	X+IgYdP/3KLKA8o27z5EZVTsoNmB4tB8cgRAFkUA8YdjNeI7LrHIhZ496PuYfh+Wxx4II/5ZlioIY
	aBMCFkUjlZOBLsAHAalw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRjU-0006jG-5L; Tue, 15 Jan 2019 16:38:32 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRjQ-0006i1-J1
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:38:30 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id D5422FB04;
 Tue, 15 Jan 2019 17:38:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WesFIwBP-esX; Tue, 15 Jan 2019 17:38:24 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 051AB47354; Tue, 15 Jan 2019 17:38:23 +0100 (CET)
Date: Tue, 15 Jan 2019 17:38:23 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: imx8mq: Add dsi_ipg_div
Message-ID: <20190115163823.GA32114@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_083828_780587_A3B09702 
X-CRM114-Status: UNSURE (   8.75  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It's defined imx8mq-clock.h but wasn't assigned yet.

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
I'm not sure I picked the intended clock type but it gives me the right
clock rate.

 drivers/clk/imx/clk-imx8mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 398ab0bcd9de..6f082153714e 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -485,6 +485,7 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_CLK_DSI_DBI] =3D imx8m_clk_composite("dsi_dbi", imx8mq_dsi_db=
i_sels, base + 0xbc00);
 	clks[IMX8MQ_CLK_DSI_ESC] =3D imx8m_clk_composite("dsi_esc", imx8mq_dsi_es=
c_sels, base + 0xbc80);
 	clks[IMX8MQ_CLK_DSI_AHB] =3D imx8m_clk_composite("dsi_ahb", imx8mq_dsi_ah=
b_sels, base + 0x9200);
+	clks[IMX8MQ_CLK_DSI_IPG_DIV] =3D imx_clk_divider2("dsi_ipg_div", "dsi_ahb=
", base + 0x9280, 0, 6);
 	clks[IMX8MQ_CLK_CSI1_CORE] =3D imx8m_clk_composite("csi1_core", imx8mq_cs=
i1_core_sels, base + 0xbd00);
 	clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx8m_clk_composite("csi1_phy_ref", imx=
8mq_csi1_phy_sels, base + 0xbd80);
 	clks[IMX8MQ_CLK_CSI1_ESC] =3D imx8m_clk_composite("csi1_esc", imx8mq_csi1=
_esc_sels, base + 0xbe00);
-- =

2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
