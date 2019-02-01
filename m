Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED752218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpvYuIFy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mogvw0en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED752218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIRl2mg3MLn7Ic52nJbRm/onATmSWyC+yR9Zu/MiJc4=; b=MpvYuIFyamcc1y
	+qsmzlFKJqxn5TXUTTNvP/KnE8ho68fDTwY0Yeeein+2ztaRizLFZ0XznrZhMRmOpAP3f6sQrpK4S
	OKRHh/unK8zE1aM3XkJrEJaqrKkTq5MyVvdf5pbp4qXwxA3ILi6J7sg1o2SiQ/243te3TRi0TcLTR
	T2Rm3ET0wDgBF53Oh8TQ6iYiWWrg9W8CaHNeGCgrJhOtgcB/n5VtiaZWAkoHOik9w453dmvSk6fZQ
	+IxPOKGQ3GRBUAfAMYwVi+rky1xswbjzFwcHLStLvufAlj69cbbHoYbkWTNezv8sbdL27oI5mdNXX
	OqYSShPADdRu+ot6jnog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZla-000741-2k; Fri, 01 Feb 2019 14:26:02 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZlV-00073T-Fr; Fri, 01 Feb 2019 14:25:59 +0000
Received: by mail-wm1-x342.google.com with SMTP id p6so6405380wmc.1;
 Fri, 01 Feb 2019 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xDTvjg/nXebcdXocsOOitS0hh02ek9EoczA/KSbNN2M=;
 b=mogvw0ensvu00i3tUUrhWfrSNC6zmfH1DWpCYrScFIWYO+KwLUURPAJiPzFkzJ5kkv
 3RyB+aWSWDyC5PqNQJ/JNnUcCJMCxb4P0uyS700yFNS5HGIE3BHUKoAxuCltYvfGFj4f
 +wiUGiwPjooDgvsiXCA7AkmZmPyqav5/gRheLGnnoWWnf9LT5vyV+Q+8Prrx4gSuaF1x
 bCD+PNFyCWUlewX128fZ89KfuEmHRo/mm4fTYzvwmPwiYQigls48m0UXS0NexRZH9L6F
 BcpGOQ2o2yjRT6DHptprZYH21exwjgPP8nW9bmB5cfDHa7B4qNCwxZ6g51J6V41SvNQU
 b+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xDTvjg/nXebcdXocsOOitS0hh02ek9EoczA/KSbNN2M=;
 b=fOSPn3ZgsnqY2XyWAQcyHDkygkHEZqAfCOAvcmXgeUUYNi4UNXKDS61E6ZIhWiWsHm
 Y0dajhvUO0bm4acY4niMWBvAwbPi/Z4veEP8ZcKNmzWXSKn6N3HCzMHl+4DFcJOBWyMO
 /4nX7C96Vw73m1MzWOE5itpBCTt4TVc2Yvt7ahYAF6nzIq0P5ydrerBA3bOdHXY2S/Y5
 DvMIfHbN7Zr0Xyf3T69o6Pgxn9tFljEaXTfUZZh/8ctLTuVUck2zWwLyYwUlYkmqyEKO
 OUcQwORhRBCDmPYqY3tyHOnapYHyfgKfx2/D1AUy3Md3l1PcG0WAWPxty2zIc3rCsddv
 XHsQ==
X-Gm-Message-State: AHQUAuafmP0lxJU8z0fRDOKSodMjbRm4FK7H7pHpkaLhi9yjnAwtGG50
 eZojfid8EBpOspEWSbgIA7UQOOsmuMBWlQHjyAU=
X-Google-Smtp-Source: AHgI3IaDj0CuGguYFccFtmyoqIYwTUhYEsCwJ9pXJlVkAz/9GZHcy9HS0LtdAroyG6FkzKfrcd6l1sznIKrW74WVO1s=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2740767wmu.52.1549031155288; 
 Fri, 01 Feb 2019 06:25:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:8b48:0:0:0:0:0 with HTTP;
 Fri, 1 Feb 2019 06:25:54 -0800 (PST)
In-Reply-To: <20181229133318.18128-5-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-5-jbx6244@gmail.com>
From: Johan Jonker <jbx6244@gmail.com>
Date: Fri, 1 Feb 2019 15:25:54 +0100
Message-ID: <CA+z=w3UKrDODY964WOtq-FQhuFJWg4C2jKXn0=3QT45gJ3UG_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm: rockchip: introduce rk3066 hdmi
To: heiko@sntech.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_062557_557044_E07C2763 
X-CRM114-Status: GOOD (  22.01  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Beside the binding for "rockchip,rk3066-vop" this patch series
also has a new binding for "rockchip,rk3066-hdmi".
Can Rob Herring advise here? Including the document describing the binding.

This patch still has the original license text included.
Can the copyright holder (or Sandy) approve the replacement of the GPL text
by a SPDX License Identifier for GPL-2.0?

Is Heiko's test setup for rk3066 already functional?

Thanks

2018-12-29 14:33 GMT+01:00, Johan Jonker <jbx6244@gmail.com>:

> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -0,0 +1,928 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

> +static inline u8 rk3066_hdmi_get_power_mode(struct rk3066_hdmi *hdmi)
> +{
> +	return hdmi_readb(hdmi, HDMI_SYS_CTRL) & HDMI_SYS_POWER_MODE_MASK;
> +}
> +
> +static void rk3066_hdmi_set_power_mode(struct rk3066_hdmi *hdmi, int mode)
> +{
> +	u8 current_mode, next_mode;
> +	u8 i = 0;
> +

The function rk3066_hdmi_get_power_mode can also returns 0 with VIO
power domain disabled.
That would lead to an endless loop. Just replaced 0 with
HDMI_SYS_POWER_MODE_A to prevent a crash.
Please advise if this function is OK with you?

> +	current_mode = rk3066_hdmi_get_power_mode(hdmi);
> +
> +	dev_dbg(hdmi->dev, "mode         :%d\n", mode);
> +	dev_dbg(hdmi->dev, "current_mode :%d\n", current_mode);
> +
> +	if (current_mode == mode)
> +		return;
> +
> +	do {
> +		if (current_mode > mode)
> +			next_mode = current_mode / 2;
> +		else {
> +			if (current_mode < HDMI_SYS_POWER_MODE_A)
> +				next_mode = HDMI_SYS_POWER_MODE_A;
> +			else
> +				next_mode = current_mode * 2;
> +		}
> +
> +		dev_dbg(hdmi->dev, "%d: next_mode :%d\n", i, next_mode);
> +
> +		if (next_mode != HDMI_SYS_POWER_MODE_D) {
> +			hdmi_modb(hdmi, HDMI_SYS_CTRL,
> +				  HDMI_SYS_POWER_MODE_MASK, next_mode);
> +		} else {
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLL_RESET_MASK);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D |
> +				    HDMI_SYS_PLLB_RESET);
> +			usleep_range(90, 100);
> +			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
> +				    HDMI_SYS_POWER_MODE_D);
> +		}
> +		current_mode = next_mode;
> +		i = i + 1;
> +	} while ((next_mode != mode) && (i < 5));

> +static const struct drm_display_mode edid_cea_modes[] = {
> +	/* 4 - 1280x720@60Hz 16:9 */
> +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
> +		   1430, 1650, 0, 720, 725, 730, 750, 0,
> +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> +};
> +
> +static int rk3066_hdmi_connector_get_modes(struct drm_connector
> *connector)
> +{
> +	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
> +	struct drm_display_mode *mode = NULL;
> +	struct edid *edid;
> +	int ret = 0;
> +
> +	if (!hdmi->ddc)
> +		return 0;
> +
> +	hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +	edid = drm_get_edid(connector, hdmi->ddc);
> +	if (edid) {
> +		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> +
> +		dev_info(hdmi->dev, "monitor type : %s : %dx%d cm\n",
> +			(hdmi->hdmi_data.sink_is_hdmi ? "HDMI" : "DVI"),
> +			edid->width_cm, edid->height_cm);
> +
> +		drm_connector_update_edid_property(connector, edid);
> +		ret = drm_add_edid_modes(connector, edid);
> +		kfree(edid);
> +	}
> +

The DRM framework doesn't provide a function to make a CEA mode. DVI-D
needs a mode set here.
Adding more modes needs an extra for loop. For now one mode is enough.
Just leave it that way.? Please advise.

> +	if ((ret == 0) || (hdmi->hdmi_data.sink_is_hdmi == false)) {
> +		hdmi->hdmi_data.sink_is_hdmi = false;
> +
> +		mode = drm_mode_duplicate(hdmi->drm_dev, &edid_cea_modes[0]);
> +		if (!mode)
> +			return ret;
> +		mode->type |= DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_probed_add(connector, mode);
> +		ret++;
> +
> +		dev_info(hdmi->dev, "no CEA mode found, use default\n");
> +	}
> +
> +	return ret;
> +}

> +struct platform_driver rk3066_hdmi_driver = {
> +	.probe  = rk3066_hdmi_probe,
> +	.remove = rk3066_hdmi_remove,
> +	.driver = {
> +		.name = "rockchip-rk3066hdmi",
> +		.of_match_table = rk3066_hdmi_dt_ids,
> +	},
> +};


> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> new file mode 100644
> index 000000000..f4c2e2081
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
> @@ -0,0 +1,235 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
