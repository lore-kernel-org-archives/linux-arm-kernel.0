Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4842C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA54206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ULoqpqqp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rWRyte2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA54206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EJMKK4VnAHD1qgR3FnIvyaeUct0ek2i3z9ZRpzDuN2Q=; b=ULoqpqqpbFy6Jz
	Gx2Uwm/YfHEgb68f02b25xBFpyZ7xQkAuLGNHd9wdt8jgWjMLedV7IFDi8aHMFXLjgPqMO0s9upJ5
	djRzscPeidSufgbLXQAbGY1epM8JfFrtwAvNAVp8oQLud4klEP43xVUtRn4QqdMdwUNTBpMo7wUJs
	WbeQ1ndi/I20LWuM57fZHIlrrhOTewUrFSsNBay3qT5Lgaqc7rFVKw+cYkvCKqVrEgIqj8VMg/gxW
	9Y7BmEThrYIAi27y7mUqjTMLjhDbblGl8k8phA5xwDPwCXrV9t3jCbZf+3SqCvV5gm4nKJ8g7kK76
	WSF6xiMdQz75CwVPwhCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHfQ-0005Qg-2Z; Tue, 04 Dec 2018 20:51:40 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHfL-0005Ok-7U
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:51:37 +0000
Received: by mail-wm1-x344.google.com with SMTP id c126so10726652wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=8idMI1QWpQw1XXwvnboo4kdX5q3L87C3fJ+m2KpY/Rs=;
 b=rWRyte2r1Qy3etrxaEIS0iZibhZTIp6hXFq50TOxQ7B3sDy/sAWBFObcOKsWSy3Qgq
 A/nPzQh8bHbvDxuTLv1q+JJE3lk+H5LMnFdsC/enC888fPE0AiSCIDk5XuPNH857nToG
 nYtDNPRpthIuMEouWrcPouF9Y4UNlJRbR16zYJA41quohR32i0goqBZSgOg5rZPSGyb2
 8vrTBXmJ/k7PxbMAnuKR47UIIzYN8v+pcktfLCJVhRwLO9Q0GX+q2mXvIyazjgqLcJQH
 6kow7YtrBhc5HecVwERRZvVuigTq2RwjHODUXUCDJy2uN0iuRApL/30icPr/Acejh5AA
 ZI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=8idMI1QWpQw1XXwvnboo4kdX5q3L87C3fJ+m2KpY/Rs=;
 b=f+ONpBVVNHIVFQokZ1VcLJCvdBAZkh1O49PR2arjNDpA96SxNNY7u0OtkAYuFwosf5
 tmsENPqMNMqlUfCya3WnY3ct4JxiloSSTD3gEcerGYsghoc62arZfHGbgifh+Vj29UXD
 0k5TFk0zDSgLQU6yRdmDYXGeEc1lFAYb6mkeGCpPMSR/ti1D/jHApky04+8CEy3kpsFN
 Y408SzDxMxzmJB0oU4c3v+e+Jm+SbaETeZ1OKuk3YE4puDefBvUe5DKLCXZfEORawui8
 I45M8nqSpA5LqyYNLLx/C+1E+wVN3Lu5Y3l+bU1ItPrYNaEp8wJeyS7n14L7lT1ZtYl6
 i7QQ==
X-Gm-Message-State: AA+aEWYVUdG/1BEaI8ZOHHmSmlfV3y9QwSR75PfnRzJbj1rRqlVAFCqt
 5H5UhVDYxkOmEFD9TX2/OVY+Aw==
X-Google-Smtp-Source: AFSGD/UtriuerlV8/vlSemH7u2suPxSWnq0Fri8zbBYp2xxipjox7SVrm0QMDeMcOPWQiuq1k67taw==
X-Received: by 2002:a1c:a6d7:: with SMTP id
 p206mr13065960wme.143.1543956683733; 
 Tue, 04 Dec 2018 12:51:23 -0800 (PST)
Received: from xps ([104.207.76.94])
 by smtp.gmail.com with ESMTPSA id o64sm3797643wmo.47.2018.12.04.12.51.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 12:51:22 -0800 (PST)
Message-ID: <e152a2b038aa3e3e37e031eff5585008f4637ded.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Carlo Caione <ccaione@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 ingrassia@epigenesys.com
Date: Tue, 04 Dec 2018 20:51:21 +0000
In-Reply-To: <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_125135_315003_5C52B7F4 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-04 at 20:59 +0100, Martin Blumenstingl wrote:
> adding Emiliano because he experienced high packet loss on Odroid-C1
> without "eee-broken-1000t"

Yes, it would be nice to have confirmation. I tested this using an AXG
board with iperf3 both in TX/RX.

> I find it strange though that Amlogic's buildroot kernel (even the
> latest buildroot_openlinux_kernel_4.9_fbdev_20180706) uses:
>   interrupts = <0 8 1>
> which translates to:
>   interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>
> 
> does the datasheet give a hint that this IRQ should be level
> triggered
> or did you find out by trial and error?

The datasheet says nothing about that. Looking at the GMAC registers
you can get some clues but we confirmed that with long lasting tests.

> > Carlo Caione (2):
> >   arm64: dts: meson: Fix IRQ trigger type for macirq
> >   arm64: dts: meson: Remove eee-broken-1000t quirk
> > 
> >  arch/arm/boot/dts/meson.dtsi                        | 2 +-
> >  arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
> these two should be in separate patches with "ARM: dts: " as prefix

Right, they slipped in after I had already written the commit message.

Kevin, Neil, let me push a V2 so that I can fix the commit messages.

> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
> >  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
> >  7 files changed, 3 insertions(+), 7 deletions(-)
> > 
> > --
> > 2.19.1

Cheers,

--
Carlo Caione


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
