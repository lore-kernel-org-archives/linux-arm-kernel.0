Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA1120883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/y88Wpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA1120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ngqs4RgfaFjmWaGuHpFcgJZrlvByq0zHUdFNWmOQo94=; b=h/y88WpplkrsPJ
	zTdzV7QQd2W/EX/2Z8+bFM1bzFDf4vSa/JfNiZ4HhFVFrjNPmPDoK6widnHGiNhGDVWuO+evhnnP1
	HcxVBPrp/quRqWVgjTd/IkCYlRhqskyJOm+fnV6RVkS3N4kJ4pTB9lsm6AeH/ryT6/NpHeDP2enin
	3AKQ9e79GmfIolAujZXYiZkrBRZ4FkNR7F7ENygm1InHL4CF8K7NsfqG75u+n2sMCWF976w+NuGPX
	aQPL0a02Wbxihe7zCa9lpIaW8L+Shws65E+j6amG9IO3XjiH7JK+j0/y4oFZFWW8VzuPtybSY/rtR
	b7xFI7qNGXDDczwvtB2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjWwt-0001w6-7s; Tue, 15 Jan 2019 22:12:43 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjWwo-0001ur-0o
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 22:12:40 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 504AC80478;
 Tue, 15 Jan 2019 23:12:34 +0100 (CET)
Date: Tue, 15 Jan 2019 23:12:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add support for PDA
 91-00156-A0 panel
Message-ID: <20190115221232.GA11283@ravnborg.org>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=AlPfrvoXxqGtgr3-n_gA:9
 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_141238_238810_B6F7FD2A 
X-CRM114-Status: GOOD (  19.10  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, thierry.reding@gmail.com, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Eugen.

Patch looks good, but a small improvement proposal.

On Mon, Jan 14, 2019 at 09:43:31AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9c69e73..61361ba 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2008,6 +2008,30 @@ static const struct panel_desc ortustech_com43h4m85ulc = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
>  };
>  
> +static const struct drm_display_mode pda_91_00156_a0_mode = {
> +	.clock = 33300,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 1,
> +	.hsync_end = 800 + 1 + 64,
> +	.htotal = 800 + 1 + 64 + 64,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 1,
> +	.vsync_end = 480 + 1 + 23,
> +	.vtotal = 480 + 1 + 23 + 22,
> +	.vrefresh = 60,
> +};
.flags are omitted, as it is for many panels in simple-panel.
drm_modes.h do not document any default, so we must assume default equals no flags.

I would expect two of these as a minimum:
DRM_MODE_FLAG_PHSYNC: horizontal sync is active high.
DRM_MODE_FLAG_NHSYNC: horizontal sync is active low.
DRM_MODE_FLAG_PVSYNC: vertical sync is active high.
DRM_MODE_FLAG_NVSYNC: vertical sync is active low.

But it obviously works for a lot of panel, so one
may say why bother with it.

> +
> +static const struct panel_desc pda_91_00156_a0  = {
> +	.modes = &pda_91_00156_a0_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 152,
> +		.height = 91,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +};
.bus_format is specified - good!

Consider if .bus_flags needs to be specified.
(More or less same argumentation like for .flags above).

I could not find any data-sheet on the panel,
so I could not check if it is OK that all delays are 0.

So to recap - things looks fine, but consider to be more explicit
in .flags, bus_flags, and check if it is OK that all timing parameters are 0.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
