Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DE120873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qbzAbVcu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dYY7AyDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DE120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEma+SIUKyWeuxLB+LpTiFWdh7HRVoib7x7oKzLaSqE=; b=qbzAbVculTzptV
	fuMN87Se8AK84Ky1/IOYV0T4B68ENYHhU2ypLyuHKJxrEzEMTxZ2PcKXQDQH6e4AG0t8flInr0POy
	y0u18zi/iAXdXjCoAxTf8OF48n7D265AuOlPQoCuzkNURtIsaIi8keCbehbHVnBLmd2272fkPQ69g
	9o+KZ2+euKKdEVgsZna0l96rCeOi+uDw67MpRfC9yNLggO3N0GciQv1zZSm8FGPHyeZfv2xyhNZd9
	ph+gvObCjODweMfP5eyGP+2f3yK1568z+jqBRfAFNYo9HHvBOJfOZsr1E/hohC4z0YGpzrqZG4G9J
	6ygaj+9Kvjq73z8gGDHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj50A-0004Ef-9s; Mon, 14 Jan 2019 16:22:14 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj506-0004Dn-Es
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:22:12 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so10350430plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=9MNFaxqH3CflbZ5s7rpd0ZeUglDZvdpg5vhBirm0J7I=;
 b=dYY7AyDBhVtl5De8HJ67C5ln+wkPa5dMlPrHtdHMdagrxvhVy8Nj1DcH7dkV0hMvnA
 5idJFRZZJuxktoG/GXp7VrxaVsZ14uaJRhbCEAAZJIN/Kgaq0WHay9pJxMcLyjiOsvgT
 SjLqAdGSJAU84Mk/5SQZerbJE3mnpEoNyw3NJG/emOoKuB4/++gpg1T2F4BBXSWTPlSK
 kcR6tsdsGbvpVH4xwVcC49ByJ/dI/0ekcyi9+SjTV5PHxr70olNw/ZFqO++0EYW6+UH+
 yJe+Epf3onCwIFsj1lek0nQ5GySrh4fURgP5valnCp83D8I0QH1rcaV1KDf4O7UnK0ik
 3VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=9MNFaxqH3CflbZ5s7rpd0ZeUglDZvdpg5vhBirm0J7I=;
 b=sL22f25SXf6w4usZ2KLhl5xaB5/35m5//3Uwfl5iuW0O4Bjiu7HUnZNch7eZol5Jq8
 M7AYyBFuiIt4+8Mg3iAafLIZzcBHVIRbdqz2+QY4lhWnvrQeNuZ+0Q/HslDtoh8bg3Cj
 yNERz6hntisqr77slLUXX+DeFAFmN98a0eKauvlyrlSSgRXEPa1zz0segOkV/eho9kuO
 eAH+SeQaXzOBmfDw42lF5u1uGz9RvdWXwPQ9IS2YyE+i4z0aLc1jMq5BrJs9AZXnDTqm
 WxKBv0yOQD+ZjCsgNQdhfgq8+AQ1T4O9VP2ePq+ylDCIk/JlnOMWTfCW/wLeMT4e85Vq
 RWjg==
X-Gm-Message-State: AJcUukfazrTx2MrKQRxksV2Rk5gRiH/KKbzR9K1UgtlrhruID9Zw9UpR
 47lsiOZ32jJJ1t0ZC7X8L5H9Mw==
X-Google-Smtp-Source: ALg8bN7b2KXmWUuHduwsMpk0kpHnttA2FrmcLXWEuFvtF14vQPFByulI97ZKCgEgwzxI9in10JWp8A==
X-Received: by 2002:a17:902:c05:: with SMTP id
 5mr26349611pls.155.1547482929716; 
 Mon, 14 Jan 2019 08:22:09 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:55a3:6ea4:4b91:28a5])
 by smtp.googlemail.com with ESMTPSA id 196sm3864854pfc.77.2019.01.14.08.22.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:22:09 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PatchV2 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
In-Reply-To: <20190113153022.5040-2-linux.amoon@gmail.com>
References: <20190113153022.5040-1-linux.amoon@gmail.com>
 <20190113153022.5040-2-linux.amoon@gmail.com>
Date: Mon, 14 Jan 2019 08:22:08 -0800
Message-ID: <7hy37nky4v.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082210_515847_FB8334F9 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

Anand Moon <linux.amoon@gmail.com> writes:

> Add missing vin-supply node 5.0V regulator setting to power
> to usb ports, changes help fix the usb reset warning.
>
> [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
> Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
> - Split the patch into two part: new patch
> - Fix the commit message
> - Added Tested by Kevin Hilman

Queued as fixes for v5.0-rc (branch: v5.0/fixes) with Neil's reviewed-by tags.

Thanks for breaking up into two patches, and as Neil said, please add a
cover letter to multi-patch series in the future.

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
