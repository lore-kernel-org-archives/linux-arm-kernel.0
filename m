Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCAFC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D58B222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoWSH4up";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1yZNOTCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58B222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4VGh79+kzXluNqVlko2QA2R/GmBDlQcUhB29XHI8PCw=; b=AoWSH4upx0LfLp
	++Zzjz92wHIwK7NK5uL4Bt/LXHA7cc2jbdvo0k7mj19s5PMv9+zUZ7Hf+rJfbB4M0RuLUWbvAm9Qn
	+EdUhEt09fdlz7pxEBzI+pFEut5kXKje5Puxop+Sr7axbwFq2IF4RBbEek8Ylwux5nRwjIQXqFoBH
	S/M9uVBVuMUCdDyWRiFlszUs0RVjTR1MfdScKdDWOmD6lmQmyKixCgnahAEMx5QVCnD3EEroY4W+Q
	fU7SwdVygYk7zJdDSQ6dYRULv/Ed/3WjB+P6IEhKRV3R7YunVcLgVOqwNRfVca9o2u/T5TkebEpYZ
	+cn+5KkJtuXYcohorQLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtq5z-0006AY-FU; Wed, 13 Feb 2019 08:40:43 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtq5s-000653-TS
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:40:40 +0000
Received: by mail-wr1-x442.google.com with SMTP id i12so1518005wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=6uT2+UA6yn0rcHTMvIP/MBTxOkvBxyWG8VSGdzDRTFQ=;
 b=1yZNOTCKutPPE55+mNpGBKozypxhrvkadz1kxAXp9OiIBLTHXqQlq1/rtzTuQShGlS
 14ZPEMO8DsNsp8phdPu1ZauDmXUy8i8oDvXcvXWp4p4A/4lKOyverx0xQs9Vogdvxw+o
 WUeqouG2DVEYi0tCVESrwU5CZIrRoxbiB7SW6Adzs5EPcAKpv1Dn+ZQuboXj5tu5QHRJ
 hWktBayTuQSfHwyobrvpR+uHZCn3PmoltNaiqGXLxSDDpSs6c3+58xTUPmhS9Rx8mk2+
 zL33koEbsbp8AwK5x6vF8xvBFvZlvVk3wGSpDQ5u7y1DzpHxhRBEHEhlMTLquDHkhlRc
 gqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=6uT2+UA6yn0rcHTMvIP/MBTxOkvBxyWG8VSGdzDRTFQ=;
 b=T63uA5thG/btunYDsVOK2jYjo4z+K7Y3Ph5ewP0LUHcZz+3nrSsBTcti2ssEXbrLmn
 PMTb3ALGCpmwjNEafb2nduaaN5PDQ99g7aTDWC2qiy8Z7JCpzDipVvkg7Uvwp0f0eZKp
 qVW+Dz2mhxtjHMkCrqnbw1A6UfHpAWoEyDyYzhq0x+Id6mC48S3Tz4oGUD26fFVnlYxa
 2K2Mhu7FZwYBAcBXVfsaReOqziH4KP3iUd6HHdjwe9SrYlbZCNzUf9P57ZSv8EBnafMi
 LBJc+DQETPo3BQMBMAdS/T3psuRNxXNZj2w0bVnykAWuLUJ1t0cwb3zcUnO+FNIbXWbq
 6cmw==
X-Gm-Message-State: AHQUAuZEaDVp3oZhCdy0FsWvVzzYyuvdAhFI0R7Lzu0plJN7jRvGAqUR
 rQdMzb2bUaprUEtzISGZg3CTHjh+q3k=
X-Google-Smtp-Source: AHgI3Ianfn8sdNuun1GX3VCGyVRzPbztB3flDFRP8+4dH/HK+XuUTwll1RCxyNKW2y9cuM3yi+I5Rw==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr6110872wro.300.1550047235224; 
 Wed, 13 Feb 2019 00:40:35 -0800 (PST)
Received: from boomer.baylibre.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id o18sm29858337wrg.40.2019.02.13.00.40.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 13 Feb 2019 00:40:34 -0800 (PST)
Message-ID: <fc50a3a7f1efc8d2f6054a944848897ed8baf536.camel@baylibre.com>
Subject: Re: [RESEND PATCH v2 0/2] clk: meson8b: fix typo "ABP" -> "APB"
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 robh+dt@kernel.org,  devicetree@vger.kernel.org
Date: Wed, 13 Feb 2019 09:40:33 +0100
In-Reply-To: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
References: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_004036_971035_C2F3632D 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: sboyd@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2019-02-10 at 23:26 +0100, Martin Blumenstingl wrote:
> It turns out that I'm not good at spelling "APB". Unfortunately an ABP
> (instead of APB) typo snug into two clocks in v5.0.
> 
> Currently there are no users of that clock yet, so fix it now
> before it's too late (meaning before it's used by <something>).
> 
> I decided to go the "normal" route where we can have separate
> branches for the dt-bindings and the drivers in the clk-meson
> repo. This means:
> - new (typo-free) clock #define
> - change the clock controller to use the new #define
> - (next development cycle) drop the old #define
> 
> resend - changes since v2 at [1]:
> - include the device-tree maintainers / mailing list
> 
> Changes since v1 at [0]:
> - split into a dt-bindings and clock controller driver patch
> 
> 
> [0] https://patchwork.kernel.org/cover/10742001/
> [1] https://patchwork.kernel.org/cover/10772199/
> 
> 
> Martin Blumenstingl (2):
>   dt-bindings: clock: meson8b: add APB clock definition
>   clk: meson: meson8b: fix the naming of the APB clocks
> 
>  drivers/clk/meson/meson8b.c              | 26 ++++++++++++------------
>  drivers/clk/meson/meson8b.h              |  2 +-
>  include/dt-bindings/clock/meson8b-clkc.h |  1 +
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 

Acked-by: Jerome Brunet <jbrunet@baylibre.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
