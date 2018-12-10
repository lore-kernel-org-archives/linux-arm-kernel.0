Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69286C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:13:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D5A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VFrCTFTR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Mfk0dZEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D5A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tteRt6SwOiEs9d+tF1BM0xT9eO1YUh03NXh0U8yv1M4=; b=VFrCTFTRxmmrVA
	dXEwuo0VG9VB5NKNCIXqdj/iUWFfidgUeecakrB8ne07SuXRpD81OdLenRq2PyP/ZfycD+HQS2q9x
	xJEDEDnjHEfM32YqbE24C6DThp0uxiitS8QrXm27I4bItqT/Fl/q24/zLYjzar7+q6NjzSMLuQnWd
	RSdWYnI6XREF0bG6TbR5HZKt2Ez8yGHVu0b1CdCjupgYN33olKnBuI0PQwOdHhqvVpFSQUwPKgVmX
	iWTec125LEPSDxOztUXoQBkWs7aeeokuU0nTVcBFLuqJn+5i4uKpEC2Fyp6Q4QR+ZNSBuomU3gf2F
	hk7Y+EROFHNph+AsQoWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOBB-0005IB-Rs; Mon, 10 Dec 2018 16:13:09 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOB4-0005Gx-8Y
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:13:07 +0000
Received: by mail-ot1-x343.google.com with SMTP id n8so10900448otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IuoUbHVId+o3TXIuU0XZsMaDLUZPwXd+63MtyP5nl+c=;
 b=Mfk0dZEkqx3BMVqMjDgaWD7shFMbfopUvDhD1kZp4BGlJ4oblqaAxSGP2BIHOwctVW
 OP2Rx92mSuBpsjhLXJtg94+VEdoUPhotj09fFFJ0w3LP0EAr2W+XeW3jv3qRGxEyZ8r8
 VPLJ3Xvaknf6JuupWU5hJV3q00NsV1k9IuWG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuoUbHVId+o3TXIuU0XZsMaDLUZPwXd+63MtyP5nl+c=;
 b=iB0IWtSucAXxcS6V8M0EMnd2qfMRCuNBmZki44BrjiUiE1k8tEZ/l7vgdLmugRb1B4
 iEutaUxuQg84aWVHxn6PD8BGWibK0ceKWsX5pmG2f2N53hwA1EXNKkICfGwZkQFVeJdx
 qbbmoED6QvQSbAobpH1LkJ+qb7c/tQDcmyicwSuarESaXKpZ57d1vJK4OURgVmArPbte
 d80utVs0/ymqf/folPWJPqV0YpzNBgFLjc20mX202LW4wVEwnZTFDGx3l+hWFJzEzU1e
 Qz5+E2elLSwEj5rEvLawH7q/8FleCRO4Sq38Nj+Tkux/S4xYzzT5HvfH9HfzEiosBy6E
 v3/A==
X-Gm-Message-State: AA+aEWaL381mF7GL1+lMT3LSJjM0tKVghhycWPsSMy4qwiMXi8Z105Ix
 RxW8XARqOhOXWztRckGFyEThJI+EflsJPxYCgD5oXQ==
X-Google-Smtp-Source: AFSGD/WwkmxlWvJIbhB1K/JynkQfAnLv8L2s6VUMTxMFufto5o1G9mDH6V5HyVx2NuR3Tw17uI5zXCSAqDS7OLKzlB0=
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr9192259otf.121.1544458370931; 
 Mon, 10 Dec 2018 08:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
In-Reply-To: <20181116163916.29621-12-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 10 Dec 2018 21:42:38 +0530
Message-ID: <CAMty3ZBNJ07v7jWq9s8KyvitGaJ5e_igPoP=9X9wN=PAyfOU0A@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081302_331523_A9C6C92F 
X-CRM114-Status: GOOD (  17.48  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-amarula@amarulasolutions.com,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, TL Lim <tllim@pine64.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thierry and David,

On Fri, Nov 16, 2018 at 10:10 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
>
> Add panel driver for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
>  4 files changed, 302 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dac08d0b3cb..40c8bfc974f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4620,6 +4620,12 @@ T:       git git://anongit.freedesktop.org/drm/drm-misc
>  S:     Maintained
>  F:     drivers/gpu/drm/tve200/
>
> +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> +M:     Jagan Teki <jagan@amarulasolutions.com>
> +S:     Maintained
> +F:     drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +F:     Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +
>  DRM DRIVER FOR ILITEK ILI9225 PANELS
>  M:     David Lechner <david@lechnology.com>
>  S:     Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d0d4e60f5153..bc70896fe43c 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
>           that it can be automatically turned off when the panel goes into a
>           low power state.
>
> +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> +       tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y if you want to enable support for panels based on the
> +         Feiyang FY07024DI26A30-D MIPI-DSI interface.
> +

Any comments on this?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
