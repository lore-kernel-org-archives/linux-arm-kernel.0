Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D301C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B66C21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdNkkw6h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyLX2bHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B66C21A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbnNGDJMzTkvDVYh24CQ2jPGrf+u0tbNSsGngUnCjgg=; b=TdNkkw6hBqFW9B
	lqZhgbf08EKioG61dQgtfy489RI3hoTlH30Y+2wLhpPL3it/v0hsXMxwEGY3stRlvFS6Zn4nxpsJw
	mAVhqT31O9bnKH5WhpcXXCvAYwjvGZGAlDiRJ7j2eLZKZZnBgaQVwhhCJarkE6CxcLjAQGLoVu/9i
	fuFSw0+7cGJBdM1554XuZDls8GVhsW1WQNjkfXsxVBQC2l3qNl8gC1c6APGbzx7DpggVvQG1TT1+P
	7b+oJNBY5ZRR123kg+3ewDnGxyl8jWX27oPeEmn9UqJVcz/VrRxXe+GsN3zIQjytH3Oh6INpHGgCW
	D6pbXufYHAOKjo9klQ1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gud6D-0002YU-Us; Fri, 15 Feb 2019 13:00:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gud66-0001uM-Bp
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:00:11 +0000
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94D50222A1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550235604;
 bh=j9fPIohsDCJA+ww/gyaTWGE6yJNj4pXz1PTBvIzuBH8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GyLX2bHg5Bg+H2k15jTAHMWm0ByLyaJchTxznL1wUWf2dcETkXIV6F7jBWSOxw07h
 d/aG+1ngIzrsENOjophq+TJP8lJa653t97cjre0n2aIEqopzIUlYJ3Mrl8w3Q1U8cS
 3ulfzK05xAXOpVtnnOltv4EaIeP1k4lAKH5APt2A=
Received: by mail-lf1-f45.google.com with SMTP id u21so7142038lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:00:04 -0800 (PST)
X-Gm-Message-State: AHQUAuZHMZMyWOD5eZ9lUvJH0SKKW/xwBwWJdwkPDmcJcv9qP9Qm1r+a
 O/Byiju/owZj/6kq4QYHEjRAg4F5ACYw8MBqFFk=
X-Google-Smtp-Source: AHgI3IZSnLt725EfnAC4SoODraQlAkRJvTuOS+gNTCHMJFWkRlz+9qRLtSnETJN/BoMIUH8bebXRqdgisI40Y6jYMSw=
X-Received: by 2002:a19:d83:: with SMTP id 125mr5307555lfn.159.1550235599920; 
 Fri, 15 Feb 2019 04:59:59 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-1-m.szyprowski@samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
In-Reply-To: <20190215125229.30180-4-m.szyprowski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 15 Feb 2019 13:59:48 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdwvPX28WJ8DyXvygzHj_qS0-126cA1aCdL7ktObTPNKA@mail.gmail.com>
Message-ID: <CAJKOXPdwvPX28WJ8DyXvygzHj_qS0-126cA1aCdL7ktObTPNKA@mail.gmail.com>
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_050006_446671_77DDEE5B 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 13:52, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
> Architected Timers (arch_timer), because they both share some common
> hardware blocks (global system counter) and turning on MCT is needed
> to get ARM Architected Timer working properly. Increase MCT timer rating
> and hotplug priority over ARM Archictected timer driver to achieve that.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 4 ++--
>  include/linux/cpuhotplug.h       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
