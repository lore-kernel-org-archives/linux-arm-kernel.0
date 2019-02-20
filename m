Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F36C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:15:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C4F21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dJzfPvFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C4F21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=magewell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pRV/32y8SXJVqxL8Zaqg6fVmI5j22r10dntiG6B7u2A=; b=dJzfPvFKTAarK9
	E1lU+8FOD+G4q5N3Q7j8Rb490Lj4p47v+JSGxRgH4m+/sspC+1/w2ip5Skji25VvQ3YZ9ODoFgKVb
	l2hgEI4dWTVZmzbkBG3tbVeFWjZI+wfggjMZJDRvAL2p9bbUxItpu7FgL3ix2DPfYmPf9vGcRvXrT
	QDp9OgjwESVzCNayXDphOsNomZk+NEh3lV5NyUJ79PiM3bVCgYqRvM7uR0QnoldXXtmyFDrq8GT3A
	Nv7LVCMh9nrVQd5d1uJ7qnTiHasUWOyGyCjUIEPkSasDhy0IbqMZPxiCcAVqJHnYJGUS0l1MOG9YO
	xqKu3Elp5qRpU5e5BU1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwGU2-0007mi-N6; Wed, 20 Feb 2019 01:15:34 +0000
Received: from out20-206.mail.aliyun.com ([115.124.20.206])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwGTx-0007m8-N7; Wed, 20 Feb 2019 01:15:32 +0000
X-Alimail-AntiSpam: AC=AD; BC=0.9189658|0.09951378; BR=01201311R181b1; CH=blue;
 DM=CONTINUE|AD|true|0.103024-0.0858154-0.811161; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03312; MF=yong.deng@magewell.com; NM=1; PH=DS; RN=47; RT=47; SR=0;
 TI=SMTPD_---.E-jWb25_1550625314; 
Received: from John(mailfrom:yong.deng@magewell.com
 fp:SMTPD_---.E-jWb25_1550625314)
 by smtp.aliyun-inc.com(10.147.41.143);
 Wed, 20 Feb 2019 09:15:15 +0800
Date: Wed, 20 Feb 2019 09:15:14 +0800
From: Yong <yong.deng@magewell.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 06/14] media: platform: fix several typos
Message-Id: <20190220091514.04cc6347ef24647f6a009d49@magewell.com>
In-Reply-To: <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
 <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_171529_935428_D9C5D0BC 
X-CRM114-Status: UNSURE (   8.79  )
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
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Patrice Chotard <patrice.chotard@st.com>, Andrzej Hajda <a.hajda@samsung.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Chen-Yu Tsai <wens@csie.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-rockchip@lists.infradead.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kamil Debski <kamil@wypas.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-msm@vger.kernel.org,
 Houlong Wei <houlong.wei@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Benoit Parrot <bparrot@ti.com>,
 Jeongtae Park <jtp.park@samsung.com>, linux-mediatek@lists.infradead.org,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Hugues Fruchet <hugues.fruchet@st.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Jacob chen <jacob2.chen@rock-chips.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>,
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mauro,

On Mon, 18 Feb 2019 14:29:00 -0500
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Use codespell to fix lots of typos over frontends.
> 
> Manually verified to avoid false-positives.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/platform/Kconfig                     |  2 +-
>  drivers/media/platform/atmel/atmel-isi.c           |  4 ++--
>  drivers/media/platform/coda/coda-jpeg.c            |  2 +-
>  drivers/media/platform/davinci/isif.c              |  4 ++--
>  drivers/media/platform/davinci/vpbe.c              |  2 +-
>  drivers/media/platform/davinci/vpif.c              |  2 +-
>  drivers/media/platform/davinci/vpif_display.c      |  4 ++--
>  .../media/platform/exynos4-is/fimc-is-command.h    |  2 +-
>  drivers/media/platform/exynos4-is/fimc-is-param.h  |  2 +-
>  drivers/media/platform/exynos4-is/media-dev.h      |  2 +-
>  drivers/media/platform/exynos4-is/mipi-csis.c      |  4 ++--
>  drivers/media/platform/marvell-ccic/mmp-driver.c   |  4 ++--
>  drivers/media/platform/mtk-mdp/mtk_mdp_core.h      |  6 +++---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c |  2 +-
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  4 ++--
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  2 +-
>  .../media/platform/mtk-vcodec/vdec/vdec_h264_if.c  |  4 ++--
>  .../media/platform/mtk-vcodec/vdec/vdec_vp8_if.c   |  2 +-
>  drivers/media/platform/mtk-vcodec/vdec_drv_if.h    |  2 +-
>  drivers/media/platform/mtk-vcodec/vdec_vpu_if.h    |  2 +-
>  drivers/media/platform/omap/omap_vout.c            |  4 ++--
>  drivers/media/platform/omap/omap_voutdef.h         |  4 ++--
>  drivers/media/platform/omap3isp/isp.c              |  2 +-
>  drivers/media/platform/omap3isp/ispccdc.c          |  4 ++--
>  drivers/media/platform/omap3isp/ispcsi2.c          |  2 +-
>  drivers/media/platform/pxa_camera.c                |  2 +-
>  drivers/media/platform/qcom/venus/core.h           |  2 +-
>  drivers/media/platform/rcar-vin/rcar-dma.c         |  2 +-
>  drivers/media/platform/rcar-vin/rcar-v4l2.c        |  4 ++--
>  drivers/media/platform/rockchip/rga/rga-hw.c       |  6 +++---
>  drivers/media/platform/s3c-camif/camif-core.h      |  2 +-
>  drivers/media/platform/s5p-jpeg/jpeg-core.h        |  4 ++--
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |  2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |  2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c       |  2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c    |  2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    |  4 ++--
>  .../media/platform/sti/c8sectpfe/c8sectpfe-core.h  |  2 +-
>  drivers/media/platform/sti/delta/delta.h           |  2 +-
>  drivers/media/platform/sti/hva/hva-h264.c          |  2 +-
>  drivers/media/platform/stm32/stm32-dcmi.c          |  2 +-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  2 +-
>  drivers/media/platform/ti-vpe/vpdma.c              | 14 +++++++-------
>  drivers/media/platform/ti-vpe/vpe.c                |  2 +-
>  drivers/media/platform/vsp1/vsp1_brx.c             |  4 ++--
>  drivers/media/platform/xilinx/xilinx-vip.c         |  2 +-
>  46 files changed, 70 insertions(+), 70 deletions(-)

For drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h

Reviewed-by: Yong Deng <yong.deng@magewell.com>


Thanks,
Yong

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
