Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80283C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:43:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4754821B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AbfXlwse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4754821B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t542XoZsi4sTSuJ6LQ+kHC2Fzmbm6obOHReJlYAc8Fk=; b=AbfXlwsexQ6GZF
	oiojgCD0AX2vw+RBEZPcQ6hKfR8b6vs+DPVix89ADks3QAbkFrX5GJCQCq1TGEle/wXPhsG30a2dA
	yIxEnbbF7Vcwueu0YlTXirQ7/+KL+H6xsg/sxlg5YS+P6I2KK3Me7Eoz2KXsqTZIcq7dNACCQ9T7Z
	Kgjikx67Lg78oIkGdmcpB/KLXY3n9viG9QwrlUeH7If1FdGIEzsTV1MzWqyyOwmFd0uCDTjtt049z
	vPNYVRxExbpuimR3aTuNkKVVUlTd4gUpDKV5HKi9Bau3weRSJBljkFP1bGTOZ5/a7FGGBuu+VAKmU
	rGtM6zQ23mkGifRMm/Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6oM-0006RE-Rq; Sat, 16 Feb 2019 20:43:46 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6oI-0006QG-Ad
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 20:43:44 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 8008D2002F;
 Sat, 16 Feb 2019 21:43:28 +0100 (CET)
Date: Sat, 16 Feb 2019 21:43:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 08/11] drm/panel: simple: Add BOE HB140WX1-501 panel
 support
Message-ID: <20190216204327.GB22791@ravnborg.org>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-9-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-9-anarsoul@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
 a=srsRNLFDxCY3JKSV8BkA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_124342_717821_122C9006 
X-CRM114-Status: GOOD (  23.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vasily.

On Thu, Feb 14, 2019 at 09:09:54PM -0800, Vasily Khoruzhick via dri-devel wrote:
> This commit adds support for the BOE HB140WX1-501 14" WXGA TFT LCD
> panel.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../display/panel/boe,hb140wx1-501.txt        |  7 +++++
>  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> new file mode 100644
> index 000000000000..fc6f085eb8d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
> @@ -0,0 +1,7 @@
> +BOE HB140WX1-501 14" WXGA (1366x768) TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,hb140wx1-501"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

boe must be added to vendor-prefixes.txt
(It is not present in the file I checked, but I may have been added later)


It is usual practice to split the patch in a dt-bindings: patch and a driver patch.
And for the dt-bindings patch follow the submission rules laid out
in Documentation/devicetree/bindings/submitting-patches.txt

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9c69e739a524..9a4c9dd02c6c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -828,6 +828,29 @@ static const struct panel_desc bananapi_s070wv20_ct16 = {
>  	},
>  };
>  
> +static const struct drm_display_mode boe_hb140wx1_mode = {
> +	.clock = 72300,
> +	.hdisplay = 1366,
> +	.hsync_start = 1366 + 48,
> +	.hsync_end = 1366 + 48 + 32,
> +	.htotal = 1366 + 48 + 32 + 80,
> +	.vdisplay = 768,
> +	.vsync_start = 768 + 3,
> +	.vsync_end = 768 + 3 + 6,
> +	.vtotal = 768 + 3 + 6 + 13,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,

+1 for specifying .flags.

> +};
> +
> +static const struct panel_desc boe_hb140wx1 = {
> +	.modes = &boe_hb140wx1_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 310,
> +		.height = 170,
> +	},
> +};
No .bus_format and no .bus_flags specified.
Are they not used by this panel or are you lucky and the default works?


> +
>  static const struct drm_display_mode boe_hv070wsa_mode = {
>  	.clock = 42105,
>  	.hdisplay = 1024,
> @@ -2541,6 +2564,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "bananapi,s070wv20-ct16",
>  		.data = &bananapi_s070wv20_ct16,
> +	}, {
> +		.compatible = "boe,hb140wx1-501",
> +		.data = &boe_hb140wx1
It is common practice to end the line with a "," so one do not need to modify
this line if an extra line is required.


With the comments addressed you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
