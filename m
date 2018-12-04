Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D01BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC3A2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWes/wpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC3A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FYoUTDYHFb2ecfLDtv5m6cONd5VbJFBc3/avaG1G8I4=; b=UWes/wpzQwzOAD
	7GWwKAs9i43o7cCscFY3+J0KddPOvmHidBDezMDx3M3YeyNMC1JoOWfgx2Q9X6/DpPeHIPdzIi3id
	Itl0vdxXGMI21WqKCrZ1bGWgDl93PeJTbTQ6DqQ35LR+fUTuK4OHnNi3UkakJTHFjhKmk0xuPbNVm
	1iy+wfBqqZvtnzCCBB25d1UeLQLpic4PV1Qs1cS7um0VFKDbaHks81SuyQJDquI+zdNQcF8AzZwn8
	VexTZj0xm4kRYKw/rlq48i2sOFdESXMgtdr39ATYWeQowmFtD3CC3qrMakFzfuVTkuTzS5Wh8L6nS
	4tGSCDTDyPGNi3KhSU4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHCH-0000gp-HK; Tue, 04 Dec 2018 20:21:33 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHCD-0000fY-Uf; Tue, 04 Dec 2018 20:21:31 +0000
Received: by mail-ot1-f67.google.com with SMTP id t5so16500131otk.1;
 Tue, 04 Dec 2018 12:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iVm/Bng45TbwnUesazisFZl+JbdzKOynLd5fMDzgDJs=;
 b=Sxfo6f9mxe0/0ARBcFoUhaf4uZiIej2+i2+UUGWyvppTSebmPnIQ0z7BW31KEKMTHX
 mzmYCuX18ssgBXDK1Z6+Ms279zo5zjPkcaRaaQ+0VTDO/x6TgzeBGriH2Hrevc/5DYFZ
 vBw0uJeQ8PHj3mjGyqUTVffwigAX/p7BxM+l+z48meoVCz1HB+oM0ZF3QO2pwx++JLI0
 6Ol5DVpfEO3mM9+s/aSvwOd3I2h7UYQE6XZwIgr8QvyXr/bGFeDYZrzv65iX4FRcu0Be
 4jM4Ql1V+JNz2EzkKnyE3bKjCg30rZKs+h5bOliJop7aH6ECFjuIofl5urQxH0yWhyTd
 vPMw==
X-Gm-Message-State: AA+aEWYuKfKzCj8U97aB6qe5HZTsKlAJENY9mHEbmxuaodvuMjbo+ilr
 JZYTW8RPkVCk3Sr/6orsdQ==
X-Google-Smtp-Source: AFSGD/WsuHhiFbWEv4PGhvaLGFY0i+la+RNWC7nT3jasdeCW2isUp0Uu5wZU/2eOLi8ibOIoHFT8IQ==
X-Received: by 2002:a9d:3ee4:: with SMTP id b91mr10224638otc.79.1543954878616; 
 Tue, 04 Dec 2018 12:21:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z94sm8612057ota.58.2018.12.04.12.21.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 12:21:18 -0800 (PST)
Date: Tue, 4 Dec 2018 14:21:17 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 6/6] ARM: dts: rockchip: add BQ Edison 2 QC devicetree
Message-ID: <20181204202117.GA24452@bogus>
References: <20181113130559.31221-1-heiko@sntech.de>
 <20181113130559.31221-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181113130559.31221-7-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_122129_983264_C90D5161 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko.stuebner@bq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 13 Nov 2018 14:05:59 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The Edison 2 Quad-Core was a Tablet device released in 2013 by MundoReader
> using a rk3188 soc. Add a devicetree for it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  .../devicetree/bindings/arm/rockchip.txt      |   4 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/rk3188-bqedison2qc.dts      | 711 ++++++++++++++++++
>  3 files changed, 716 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3188-bqedison2qc.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
