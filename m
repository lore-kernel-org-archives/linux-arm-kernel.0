Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CBCC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB3F2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDXb6Kcv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Bu7WzUGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB3F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9j+hVParQ9bcZ8bxjCo+wBpPffcymLb/xwwqC95IZGA=; b=mDXb6KcvABXkTK
	URctY3J4YIaoea3dRku03TmQMqY+eW0mmLXBpNFF/x41SwKIB1cbtA03CV497Pgrr7q6j25ZUY4uX
	SseEbyn/CnNNw9iK5M9tF4jwquhDbV6dWfDpBhnA19+idWe7IR4ZSB1LAh+k+9i2rBF/6OL8lPm2C
	2Yk8qU0oMuyM8M6UJT2WKgTtzXTmojWgjTmIy/O/jr+Nk7RKC2K24L69XVCNg3r5DNa/bS3dDdACY
	IfX07I4Z/kzcS3EoeJljA1pxQWI/WD5n353RyzbCOl7Hca+iaoN9xhE0JnsFqUn9f0i/lINpd4BJ1
	ZPSo9+0T/wB5xN7XKaCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCpy-0000by-HC; Wed, 12 Dec 2018 22:18:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoA-0006yX-J8
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:59 +0000
Received: by mail-lj1-x242.google.com with SMTP id v15-v6so17668381ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=I3okQA0l2QCTTaRQRI0Rw2zC78iYmiC0wcjkYfrVBZs=;
 b=Bu7WzUGKiD+FmGAC357pFU7mXYH97m6j3aWjIs/5zm5LP1dMcNvVNGCNRDvkTm7iVf
 JLsn7Dmc4mmwd6vJ6FUG5iq9ncKcGb4ZE4YyvWL7x+qBkzQSuApKk1PUH462Up4Ds9rx
 My1ENNaHR9pY5yE8O2V0RkjFZ26r1UMCnbSGd4lGpE1Ddt82h0QEdPtbdVwNrsaK98e1
 jhOZTXYcAJTJDNileKRnpccZJx2vQj08vuY91L49jXFHEduSfKMexjfqqfv5kUPuDgzO
 cU3HVkFxbmeRGQTmGEuJqRSKyOLcctjkaIOiT0YVPFw/jU/PnfllLuxMKv7xzF5Eagok
 AYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=I3okQA0l2QCTTaRQRI0Rw2zC78iYmiC0wcjkYfrVBZs=;
 b=P7efifh1Da6ZzOnPDoPq9496i6dt9EaRyazRyk0s6wi9nEc6C6xOBPSy7svWOxB6fU
 aEe8jsrhS6W0ftGanaBT/9VVzZ9W8FpQh+tJ2TO/+S78M28PE6YN+PYtZLSHba0GBTwP
 2vwGBMzpI3a9mRhwvClSlmNhOAqBsWdOCNIzJhp7uWL8VPeYi8BlL7ZZWQdpNZzL6zqC
 EUxYdQfDoOqf5uHfYXY07a69GQS1D3Wx/E84oNabhMysk57XTKjjNpAYFQRwxCSRdqUL
 PIlkiFVGhDoV7RkkLYrDxXtYhxajhOe72fSeKWPP5swbdaxRQjFCngZogsDBLFgRzmKt
 0wVw==
X-Gm-Message-State: AA+aEWaphv9mj0Ko051JLNC4YZCozZFwMwMlkhNlI3GRyWQTZP3eOWfL
 wIVApAKRfW5HilVk8dpBQjJ8Y2ibDmlY2w==
X-Google-Smtp-Source: AFSGD/UXzx1eIh1y6viAGTLo1Se6a4Qla7ygqOjr0LwZcr556txPHr1sh+tGySHsEMlpyJhgIXdhhw==
X-Received: by 2002:a2e:7f04:: with SMTP id
 a4-v6mr1663539ljd.156.1544652994351; 
 Wed, 12 Dec 2018 14:16:34 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d5sm1072lfi.65.2018.12.12.14.16.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:30 -0800 (PST)
Date: Wed, 12 Dec 2018 13:47:49 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 7/7] i.MX defconfig update for 4.21
Message-ID: <20181212214749.abc33sqlewgf4jbb@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-7-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-7-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141646_933371_7A9D82D0 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 03:46:38PM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.21
> 
> for you to fetch changes up to bb9c90ab4eddf83e1aa041498f65b8bf8be6802f:
> 
>   ARM: imx_v6_v7_defconfig: add imx7ulp support (2018-12-06 22:55:20 +0800)
> 
> ----------------------------------------------------------------
> i.MX defconfig update for 4.21:
>  - Enable build of i.MX7ULP SoC support.
>  - Enable Goodix touchscreen driver which is needed by ConnectCore 6UL
>    SBC Pro (ccimx6ulsbcpro) board support.
>  - Enable USB_ANNOUNCE_NEW_DEVICES to help USB issue debugging and
>    BT_BNEP to support network over bluetooth.
>  - Remove explicit ARM_UNWIND disabling as it's selected by ARM EABI
>    support.
>  - Enable DA9063 PMIC for emtrion i.MX6 boards support.
>  - Enable driver support for Pixel Pipeline (PXP) and DCP crypto block
>    which are found on i.MX6 and i.MX7 SoCs.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
