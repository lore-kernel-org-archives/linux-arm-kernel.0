Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F3FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:33:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8925E21B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dV4JLwYM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GdPRy1dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8925E21B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QKvuJyi+xFNf1rrnp99hvgBQamfZlya26jmXyswBfEI=; b=dV4JLwYMqBuqHS
	L3lqtOjauHUAX5epJL4h+PSX8TuREV5Gl7BtQePKvz/ycCkTvdMbk1RIubS9Z2bspiJnuDbW658l1
	CZXwdtMRqFY+oBoeH/B9p/1DwHVKvCR34qDumhBukJUs5Vfa9ZC3AxRJBJZrDLA5aD7LSBVDT1HXb
	Bh4+JX7tlWhwtK6BZoq1gM0i4c/Mbeex/789N8pYUvrcawqci641bKbQ9PGBnVpX+HaV4IrmeAIiS
	9e0qSDfwmetESiwi1GdbPMXlbF9iBqKJbqdj8OJQujb9EGGz/Yf3s639CNMsXca2OES78LnNDUYs/
	HHdm/806TO4oKwd/d8Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVN6-00045x-73; Tue, 12 Feb 2019 10:33:00 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVN3-00045X-Ax
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:32:59 +0000
Received: by mail-it1-x144.google.com with SMTP id c9so6308765itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uVfVPkHESSQI0nz5hCRCWBliPzgZit92UhHa85UMyqE=;
 b=GdPRy1dn5Yk0gwngvgj+ifyeHwTYgK7XOCZ1Klr8pbU0wEDxhDqIQlnJCwJfLAIoB2
 JuzyKq7sFERz2Gnv4yZTJsOv/FVhlZbSIsMVx3zUhyKUxONOotehhqVCJvhIf7ui5A3r
 h841Jjg05OtlQ/hh+QtAdS9t2bbK1pAqc++I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uVfVPkHESSQI0nz5hCRCWBliPzgZit92UhHa85UMyqE=;
 b=XY05qXF15SBGIy2ss1nMuPIjFcozAvNxDhGAeTLoNNHwRPYv+dNsJzai6eOb98agAo
 P91skRhmi0E9YuoZRvLfpkTQM3eP1+zZAlYIgYOPAbEj47KVYzRRHpvW1D+HSz+W/eDw
 UmqNUQTvoXAquWUOXG8Yvg3RvnaxWhCDPuyJRI5qRk8cWIC+PATCWDV8aV2O7EI1jVPR
 e2YljQzPma83V6SRR+s7yqvOauWOa6WcHwXgoeDTNg3mlBwu/yCy0+jNZlRAP/7BFqGA
 8g/+mAIO7kmicjSZdJaWRPkSICXhNljwaURj4NoE6okKYNU7PPiUPBbgmn6hD21qdnIH
 aiug==
X-Gm-Message-State: AHQUAuZQf2EqK7LmGu/Y7k/BULKA6Z3qRi2kFKYHb0+2LwQMpddrG33z
 yoTxk96awFyyowHK34N22x4KHc+wUJvVniqp0kyT6g==
X-Google-Smtp-Source: AHgI3IY7btmgO3Ss6HDhFPKST0OebfjcPqaYLH6lNDDxho84XscuW1Iy/DRWiKrc+tByoVcyEsO8mm57c2Oun+Aiwg8=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr1719199ios.267.1549967575730; 
 Tue, 12 Feb 2019 02:32:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 12 Feb 2019 16:02:43 +0530
Message-ID: <CAMty3ZC39YFaNtPWoNq-fV5tpnJ_0_0WSG728kUXw4ZZp-Csew@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023257_538881_7318DC52 
X-CRM114-Status: GOOD (  19.67  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Mon, Feb 11, 2019 at 8:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a series implementing the burst mode support for DSI.
>
> It's been tested on an A33 board with the panel supported on the last
> patch, which should remove all quirks due to a different SoC from the
> equation.
>
> Let me know what you think,

I have similar burst changes[1] (from 01/23 to 09/23) which are now
v7, since these were generic changes and been in ML since from last 6
months. request you to pick or work on top.

> Maxime
>
> Changes from v3:
>   - Fixed error in Ronbo panel error path
>
> Changes from v2:
>   - Change the start delay calculation according to the legacy driver in
>     Allwinner's BSP
>   - Fixed the edge calculation to add the same parentheses around the
>     factors
>   - Added a bunch of fixes to timings
>   - Added a patch to make hblk computation more accurate, and added a
>     comment
>   - Renamed the panel to Ronbo and fixed a bunch of things
>   - Added the Reviewed-By
>
> Konstantin Sudakov (2):
>   drm/sun4i: dsi: Add burst support
>   drm/panel: Add Ronbo RB070D30 panel
>
> Maxime Ripard (6):
>   drm/sun4i: dsi: Restrict DSI tcon clock divider
>   drm/sun4i: dsi: Change the start delay calculation
>   drm/sun4i: dsi: Enforce boundaries on the start delay
>   drm/sun4i: dsi: Fix front vs back porch calculation

Same patches are been for a while in ML[2], hope you can consider to pick.

>   drm/sun4i: dsi: Fix DRQ calculation
>   drm/sun4i: dsi: Rework a bit the hblk calculation
>
>  drivers/gpu/drm/panel/Kconfig                |   9 +-
>  drivers/gpu/drm/panel/Makefile               |   1 +-
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 262 ++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c           |   4 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       | 183 ++++++++++----
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h       |   2 +-
>  6 files changed, 419 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c

[2] https://patchwork.kernel.org/patch/10793123/
     https://patchwork.kernel.org/patch/10793125/
     https://patchwork.kernel.org/patch/10680309/
[1] https://patchwork.kernel.org/cover/10792981/

Jagan.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
