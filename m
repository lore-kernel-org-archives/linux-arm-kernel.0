Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99433C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2EC20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9412K6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2EC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bny6mP6FRfaUu3bOWiBKjw+47xjPwPANLYJ+t13pNWY=; b=m9412K6Hgdvzd1
	VM+bz3GFfTfr5ghZSTIdat1lKsCXxEHsWvEmoQH5A4lFSOniWiHO9hOIkLimvdaoUQaHDiS2L64BK
	3KMHa9dnJ9l06gi0MyNA1kfmRIzdKqfPCCKuyLTYa3DcIT/8dReUpS8AqClf7zRfR46T2UPTcC0p4
	GCwcdESUUV82W/7ZdVTGQiVVK8ob3FJzmXXejq9gAcWioZUbdATBXsRSVDDYWQp2Svejj9wL4q2Lr
	j5b/XfGoOFZ97kuX1V4Q1DNllgBmLC2uztqShXST2ulOcKKZ0COE+t6H327IHQo9JQXYrZIWDEbEi
	1UM8bGW3n/gaIm4JRIUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkW1-0001N6-2J; Wed, 16 Jan 2019 12:41:53 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkVa-0000yp-Mi
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:41:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 32A24FB03;
 Wed, 16 Jan 2019 13:41:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YOd_pioiJ6e; Wed, 16 Jan 2019 13:41:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id BC9EF475EF; Wed, 16 Jan 2019 13:41:21 +0100 (CET)
Date: Wed, 16 Jan 2019 13:41:21 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mq: Add dsi_ipg_div
Message-ID: <20190116124121.GA30303@bogon.m.sigxcpu.org>
References: <20190115163823.GA32114@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115163823.GA32114@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_044127_212487_AE4C582F 
X-CRM114-Status: GOOD (  14.24  )
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

Hi,
On Tue, Jan 15, 2019 at 05:38:23PM +0100, Guido G=FCnther wrote:
> It's defined imx8mq-clock.h but wasn't assigned yet.

I've found these additional unassigned clocks (defined in
include/dt-bindings/clock/imx8mq-clock.h but not assigned in
drivers/clk/imx/clk-imx8mq.c):

IMX8MQ_CLK_A53_ROOT =

IMX8MQ_CLK_DRAM_ROOT
IMX8MQ_CLK_HEVC_ROOT
IMX8MQ_CLK_AVC_ROOT
IMX8MQ_CLK_VP9_ROOT
IMX8MQ_CLK_HEVC_INTER_ROOT
IMX8MQ_CLK_HDMI_ROOT
IMX8MQ_CLK_HDMI_PHY_ROOT
IMX8MQ_VIDEO2_PLL_OUT
IMX8MQ_CLK_M4_ROOT
IMX8MQ_CLK_M4_SRC
IMX8MQ_CLK_M4_CG
IMX8MQ_CLK_M4_DIV

I can look into adding these but just wanted to make sure they're not
sitting in a tree already.

Cheers,
 -- Guido

> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> ---
> I'm not sure I picked the intended clock type but it gives me the right
> clock rate.
> =

>  drivers/clk/imx/clk-imx8mq.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 398ab0bcd9de..6f082153714e 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -485,6 +485,7 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MQ_CLK_DSI_DBI] =3D imx8m_clk_composite("dsi_dbi", imx8mq_dsi_=
dbi_sels, base + 0xbc00);
>  	clks[IMX8MQ_CLK_DSI_ESC] =3D imx8m_clk_composite("dsi_esc", imx8mq_dsi_=
esc_sels, base + 0xbc80);
>  	clks[IMX8MQ_CLK_DSI_AHB] =3D imx8m_clk_composite("dsi_ahb", imx8mq_dsi_=
ahb_sels, base + 0x9200);
> +	clks[IMX8MQ_CLK_DSI_IPG_DIV] =3D imx_clk_divider2("dsi_ipg_div", "dsi_a=
hb", base + 0x9280, 0, 6);
>  	clks[IMX8MQ_CLK_CSI1_CORE] =3D imx8m_clk_composite("csi1_core", imx8mq_=
csi1_core_sels, base + 0xbd00);
>  	clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx8m_clk_composite("csi1_phy_ref", i=
mx8mq_csi1_phy_sels, base + 0xbd80);
>  	clks[IMX8MQ_CLK_CSI1_ESC] =3D imx8m_clk_composite("csi1_esc", imx8mq_cs=
i1_esc_sels, base + 0xbe00);
> -- =

> 2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
