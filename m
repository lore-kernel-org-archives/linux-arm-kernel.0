Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C525C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA3021738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jtmo9XHW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwJ2YyDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA3021738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ye9bhOMAtHpeSx1QIxDBuib0+R+/j/vQtNlZFWxR7JE=; b=jtmo9XHW7eix2p
	boz99Uncn6A39LD/4+zzodWcAftDqjTiIZwy0OkiUW/3qNoSpul1+MPbN5zwZhsQLlC9WiQ7V6c1Y
	v3f2Gu5M7t6d0aZ7K8tlaQn7N9XsEIF6U+r47oiKXoa1o10d3DG04Pij+O/tHxyOiqyqpm754cTT/
	rDOhk02sFZNmMZGOARi4o09C6ReTnliX8t7i2ZTmK25tMal52UhevI/lElmBxGCehq5wMW2CXFfJZ
	h7rLLmXhU9Jgv/Kxm0JQHQiEU4RB1mM4DDw0+Tre41M9QnRAQtcUUxS1zDSXp+2p1yZZumWJ0/9UU
	Vy5H9djeW/0B6CRtfaaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8JV-0006Wl-Gx; Tue, 19 Feb 2019 16:32:09 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8JS-0006WH-8r; Tue, 19 Feb 2019 16:32:07 +0000
Received: by mail-ed1-x541.google.com with SMTP id 10so17264757eds.7;
 Tue, 19 Feb 2019 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p65SIlHWnNeq1Uz5ai1WSpweonn1btuKRTgphizpGmg=;
 b=mwJ2YyDH9o/sgBogdtt6kHoBXAR+QqUKonbQ3s9Z+YyhikoKjXaTBthEPNlJe6bSUe
 AkHptq0pn2/q8yyRQODb3S+HQzLPAFT4JuRFUmUy3q7QgCcXctR6w4vXNSUmVa9Th5hv
 ziAusMeJM85no2oxuNgQtxZ+PV9DZLI25m9SRbHQdaxLCxqB5HsKwWReFdupNokvgpRn
 pZNUpan9OLv7wKIADW/eDa8LoNlCHYQvaZMpX9ERkz6otK5FkqJl3iKvhVtBAgE6BKyo
 388ZPQsxWKgAZypes78LtsW/lz7wwZzZiqJNE1AnGtCpO9XEJSxJIktqHO2Yqa/WEsNT
 Be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p65SIlHWnNeq1Uz5ai1WSpweonn1btuKRTgphizpGmg=;
 b=SmLC0H2hyIA/bFG1GD2h0Zpf+sYSwGcgGjFwxgbV6puENA4Lspx5ks/Nxy8yFrfkLU
 BJIV0KOyHY9Wfyob9ywguWbxRXS66clmQjaIrZHDjTh+RW8+yPiSJ1RQoVu8iPOJEoQn
 oQDj4qfSPqi1etXhF/mCZKesMAp8I5sUbk6EFGSVxSls1m5IN/FQPM1O+9X1oRkffWJx
 snu4+7/3ESCghOSwyiE6obMiqhnpmYOvzgH9vYjbwqcs6R5GgOI19uMRaMSgMgxESa15
 rSDzRQ7k5LnFfcQ4oZqNF9foD+F04PQ//WDAllilyld6XZQdSdtABlrVhNZQsHj/idkU
 FWEA==
X-Gm-Message-State: AHQUAubuMGu/hbazJM/wpKvw+C9KZJxJ0M//Smtau9oT7W5OOaN/iApL
 i0+NzK3G16vXt5WhhjrE6dFnaChgO1aZfoOu+h4=
X-Google-Smtp-Source: AHgI3IY0z9TbkOJMfSwMiu6VDIfkfxVfzMlnD4hzgEnYL/59XouAUKVg/munn7xHSUNf7z2zileFN7MS8NTQHHYsQlY=
X-Received: by 2002:a17:906:7c49:: with SMTP id
 g9mr2703092ejp.31.1550593924538; 
 Tue, 19 Feb 2019 08:32:04 -0800 (PST)
MIME-Version: 1.0
References: <f235ba60b2b7e5fba09d3c6b0d5dbbd8a86ea9b9.1550518128.git.mchehab+samsung@kernel.org>
 <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
In-Reply-To: <362e90167292e8d0c03a8d0753cc26b89549d854.1550518128.git.mchehab+samsung@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 Feb 2019 16:31:37 +0000
Message-ID: <CA+V-a8sENpc5mHvRdZDuUJLFqxoyUvg_nhLVZPHma5BbvZBMSA@mail.gmail.com>
Subject: Re: [PATCH 06/14] media: platform: fix several typos
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_083206_343686_D7E5145F 
X-CRM114-Status: GOOD (  10.79  )
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
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
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
 Yong Deng <yong.deng@magewell.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hugues Fruchet <hugues.fruchet@st.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 LAK <linux-arm-kernel@lists.infradead.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Jacob chen <jacob2.chen@rock-chips.com>, linux-renesas-soc@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mauro,

On Mon, Feb 18, 2019 at 7:29 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
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
>

For drivers/media/platform/davinci/*

Reviewed-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
Prabhakar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
