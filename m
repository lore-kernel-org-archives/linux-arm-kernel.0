Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48209C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3F52075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUwNTIIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F52075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyHR64kvpWxsdfnuGVyHTgTOfinM40VhKZRyp4+6ibg=; b=iUwNTIIqLOuPRS
	pyyPzPw9quaKlp5bU8BnSlHLhGDMse1JT3DVyUHCEGQVDsKng20baN7/KZMB0CEFMCSdphjeDjSIy
	/ObgKPj9wqCiC0FjMSfNVjHahhh1bkmwYUHUSUMhTyvAKGo6HwBrRxF5mgTQibaYYdzsxkTt7QIQx
	8Q/ntFu23kN0jocY4RjMzzzVFBcd4yrryzQTjmDokbCVLQuqaDH2i6OUQdlbP97AUnKzKjCskhLRo
	x8nmZ/dCODBuc2fz3VSO9nSWqpExSFcCiXbOlmF2kuppli3MuboGX5oBkQq1doWWe+kfeqEAJNtju
	CnZC1eTKOWT8A1y1SWWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucph-0002YQ-8D; Fri, 15 Feb 2019 12:43:09 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucpd-0002Y6-JD; Fri, 15 Feb 2019 12:43:06 +0000
Received: by mail-qt1-f196.google.com with SMTP id p25so10382613qtb.3;
 Fri, 15 Feb 2019 04:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9RBHE15GAigpjcLoP099lel5xiRRsuo6ZpzJe01YIFA=;
 b=mT2L8mFHj19Uy7MyVI/kzoekjE1AcxSSg/8ZFSDP+DzPZuMmE/tZCmXWgQ2nRlvhko
 cuesHkfqRGi5KEoD8mkYbqGIafrMpp7Jkdbe1NJKCXlJGy79cSyYX1N20WTlKcbNzUle
 HtQa7z5+qth6oJDODIqhPoa7D5CFJR63n27Dd6HDXGk+BLrDAciNrVIVzrHa5Qcnxii6
 0wwfZ+X2G7cbcAC8UkliNfRoiGLzhnzkinF2Q791MEPODBJV9HL2u/CokyOmOcnsqhMe
 u7R7Km/ynfcW05KgUh8ASfaV0BQ1whqp8x4niZW/gcgJLfN+LqY1AProJP5tA3tdVJyM
 vPUw==
X-Gm-Message-State: AHQUAuYfA32DcvIStYJLUkvkGmSKmcZa9vlJaxkZSBoinu+Cr3fJRvl9
 qT5vHz0PTZGn4kzRDhYhkrtRLANYmo7OVU6ONcQ=
X-Google-Smtp-Source: AHgI3IbaZoTSWsb6YI9uQjF5vidQFcck888J0i4wq18EzWloa6dU9/5HyM3N0lFmWONthaKWAcsbmdrbp0+3m2/kYA8=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7222633qtl.343.1550234584733; 
 Fri, 15 Feb 2019 04:43:04 -0800 (PST)
MIME-Version: 1.0
References: <7484850.KS8GUYnfXV@phil> <23121360.LiWTZRSn6P@phil>
In-Reply-To: <23121360.LiWTZRSn6P@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 13:42:48 +0100
Message-ID: <CAK8P3a0Oa4B_r3mAu6udmJPyKBnOwswTwOGsOuX0ruhfexqbxg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 5.0
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_044305_627360_43CD0B5A 
X-CRM114-Status: UNSURE (   7.52  )
X-CRM114-Notice: Please train this message.
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 12:14 PM Heiko Stuebner <heiko@sntech.de> wrote:
> ----------------------------------------------------------------
> Fix for new dtc graph warnings and a regulator fix for rock64.
>
> ----------------------------------------------------------------
> Dmitry Voytik (1):
>       arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64
>

Pulled into arm/fixes, thanks!

Note: since we always have only a single fixes branch, sending the
32-bit and 64-bit fixes together would be slightly easier.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
