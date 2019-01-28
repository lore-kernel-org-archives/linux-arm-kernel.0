Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF209C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:08:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A186214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H8Cll1FG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="obeWhXHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A186214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDET3QYXjMd0pq8BF2G0QPxnasxSgbuhNQap5rWv/Uk=; b=H8Cll1FGGnWJwx
	ncFhkbvHvyG6ZOXCf/9CmM0VT5CB6jKXq5ghiWn7HNEcGy+0xfzNoY4pQEWs7G0K+T2O6mQs2uKeC
	babBRTyh85eKc1wGDm67U1I3Vg+2fGudKyfsGZ+9boVz8C3P/uFXn0hP2kSdKSeANk24s9DA7ETfL
	aQCF/5NH0PJ+7F0d7uDJg0l8oCjR3FapGir/6Ho/sJy/d9YchL0m57ERSfW6eX7dQViz73BfUPMNu
	iKD9MzhyO+qpP7XmWr6iM2rdfANZ7WnCI4+wrakuFmE2ts9i8P3EjypxliHphoVD/FcXJ1P+XYBxb
	gpxMoW15IWJ57BrdBEPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5iO-0004qX-42; Mon, 28 Jan 2019 12:08:36 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5iJ-0004qD-RV
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:08:33 +0000
Received: by mail-io1-xd42.google.com with SMTP id c2so13212861iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O8G7/+s+BXF40bKoU5PnkKCGVKb+t8wN1jzE8T/A71o=;
 b=obeWhXHowyQVFg9X+WtG7U44DUnhCYG/tTaaKfejMUILLEVMnz0gRfDhTl3e1GfquG
 R5nQgJS/rHtxM+LzpvBWJDAe/EHh0hcFn7PpoXpBXBrui7RMcIaARZ8NqXe8BPOt+hF+
 bX35X/elhFkSKukIv5UJvoknaQfDfIukkj+7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O8G7/+s+BXF40bKoU5PnkKCGVKb+t8wN1jzE8T/A71o=;
 b=XDuR9itqRkqGDFeP8e0OoZoPJj4saPxOqqvfBXi70KDGjUbhy4O3lLGBVqhbAKq1SZ
 0gueqooYQjsO67HfPJW0xhqSZYPUqCVNgOaz4qgGR0aUmcYOZvYmhPpA3Avyyjm/CCvb
 Oa/G1TTcEk6nPJvnqk4nDbfWsjnkJEmMhojwF2Bol6hxjttv0qJ1YL3yd6H23v0wj5xI
 BOSDZBCKxiS8iRNGg7hgMuU1AYtwZw7iEPk6Ti8x9yQosUV98fPm8Ro5ygNnyKNsmYh3
 2fB2PkkjoX1z7P+bai0rLCoKhrZ2ZXdpycJwQaOzHuZOGswPWVgo42iai8A4apl3YL3h
 H5HA==
X-Gm-Message-State: AJcUukd/h46WFGJVsdfm1EStkmpVJVIo5ZML7dBd4xRenL2/c3gPD2of
 cQlo3BFSa9fwDlO+sdEhnz8flnJaoucmia23DzrqY2zG
X-Google-Smtp-Source: AHgI3Ia47tIrIn1uSCmkXH3dzIX8GvRGsh/yErSWtZR8685dIkEBrXtJIwJGI+9eecV8O1eokU0n4G/n1bo4SEe+7WA=
X-Received: by 2002:a6b:91d4:: with SMTP id
 t203mr12920307iod.267.1548677310358; 
 Mon, 28 Jan 2019 04:08:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <92e4e5f4c58c8c1a439e93614fdcd8bad6823358.1548236066.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <92e4e5f4c58c8c1a439e93614fdcd8bad6823358.1548236066.git-series.maxime.ripard@bootlin.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 28 Jan 2019 17:38:18 +0530
Message-ID: <CAMty3ZDONCxFgwmDun9Aw4jEo7n3PQqmZ-BDGBjiiRLNQfKbBw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/sun4i: dsi: Restrict DSI tcon clock divider
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_040832_353593_9C8A7242 
X-CRM114-Status: GOOD (  13.92  )
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

On Wed, Jan 23, 2019 at 9:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The current code allows the TCON clock divider to have a range between 4
> and 127 when feeding the DSI controller.
>
> The only display supported so far had a display clock rate that ended up
> using a divider of 4, but testing with other displays show that only 4
> seems to be functional.
>
> This also aligns with what Allwinner is doing in their BSP, so let's just
> hardcode that we want a divider of 4 when using the DSI output.

So, bad that existing dotclock is unable to produce the desired
divider logic. I have tried certain possibilities wrt changing the
clock rate in pll-mipi via min_rate, but it eventually not working
with all panels.

Yes, I have seen Allwinner BSP has logic to this dividers wrt SoC's.
for A33 it's default to 4 but for A64 it computed in other-way wrt
format and lanes.

Let me send the change wrt format and lanes, I'm hoping the same will
work with existing display or If you have any inputs please let me
know.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
