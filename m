Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A65720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g0M/g93y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1DwXvp+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A65720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PhskMDug2+Z/Rh7s5zxGtN2lpxj59rmHRz0J/PS/PPU=; b=g0M/g93yoDE0cm
	tejSJOqY0BB3sfWuilCUY50m2Qc0F1L8bmt9UXH7W2FXhf5qzZTtUiSjd9SJ+0Cjv9GakJHCDoX+m
	FlF5uUAWwSM8ctuSDsJLeLEScdbLE09BJ+Q1UZfjexHkLbKZY+/WZUg/V6j4AHagFAJWtyzz9MsCh
	8+aPBfVXMICxatE6bgQkXBx7MSWdq9DoGME4MyA656UqqKjbrdGxlzLBwIw8n0Il0mytAvap8T6TJ
	lCjgpQS0yHJZELRQMt9IrS+z0MkBAD7smUDTm4gtDj2uo3jcwdukAkiiyOIQZamZJH5gi04M9iLoH
	RiTLvanCyN20+RvFt/2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD0i-0001fy-Ui; Wed, 12 Dec 2018 22:29:44 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCtX-0004i9-Pf
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:22:21 +0000
Received: by mail-lf1-x144.google.com with SMTP id i26so36054lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S1u9/dPHGbN65f6GRgARAT6WMDqJ+jtdF/KLdYm612k=;
 b=1DwXvp+TqG26BnKhcpdE8C37zRS6E8AmDqeqhzxoZJSJmNLfqK/10nBSh3y8Zimxrl
 zNP+japh9YbiZopALO2hqtc1e3JJ0uvnqB1S19BxNQcuPD6spRMTl2gzS//kDwoXt50G
 Ehbluj+wZe0ZhH2z6Bhpl3rvhUfAT1NCt3SvDmarcXjUQXASXKTR1Hq1iTmhchnna+yw
 SUoWY9O/B/jjfa0uCj4GyQP0x7DL6wqZN+M1soQ917hjrUtDASRW8tvXOQxpx0AQqR3j
 m1ywHhfBFlZTpWzjOfZseX3bSNmXPWjk7t7iYRnp3dkZ1uyRwEvKjEXNMzd0x18lrRCt
 FY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S1u9/dPHGbN65f6GRgARAT6WMDqJ+jtdF/KLdYm612k=;
 b=VmNUsk5hZOEMWdq0WROT84SGTpNLGBoYUEPLmjGM67tyF8v+m5nTZOkWJu7NC+vogf
 wnumVAdZfQFFkqaLHLeLIMoAbyVB3zlM1H+yxPcJvBkH3XwZ8H62DuAVvZvUMdD4I45M
 yUqwBrL8IWCJxS7t2TXxqJkY9pNmI0MYVCCX0rz9QXQZ0cVhHbZC/Jd940kywCvpOMu5
 XQ/3o3YvXp5IENsRNgg2KLuD0BUYjNvMO7/wdyC22ydmhOV0hhzzkbiYU41Wlaj++neU
 tGnfKockWJu2VKP6HtiF2Jmkh5RfJfv4E2xzfmlhjLiyXT0FmA98518u3R+h+hb64TV6
 RxuA==
X-Gm-Message-State: AA+aEWaUA2G7odhO2XLDvr2VNdo5wIXWlGTTu+963urgHGgMoDTLv+Gg
 PwZWEQRthYmWC2g7aaL41tY1Yw==
X-Google-Smtp-Source: AFSGD/WhzFH1GbKkAkTQwtGOmpQytUoYdAfjBohlXZS+TSuCRbC4TeaVFwM5aq2ZoUYJQWW1R49Qmw==
X-Received: by 2002:a19:c115:: with SMTP id r21mr12645548lff.144.1544653328132; 
 Wed, 12 Dec 2018 14:22:08 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f29sm4671lfa.46.2018.12.12.14.22.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:22:07 -0800 (PST)
Date: Wed, 12 Dec 2018 14:21:42 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL] Rockchip arm64 devicetree fix for 4.20
Message-ID: <20181212222142.6ndm54ti5co3yqah@localhost>
References: <5618815.AsiCPEelux@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5618815.AsiCPEelux@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_142219_834010_38FD6B31 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 09:28:34AM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> one more fix for some regulators on the rk3399 rockpro64
> turned up that may be nice to have in 4.20 still.
> 
> Please pull
> Heiko
> 
> The following changes since commit c1d91f86a1b4c9c05854d59c6a0abd5d0f75b849:
> 
>   arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou. (2018-11-13 15:02:07 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64fixes-2
> 
> for you to fetch changes up to 690e16bada6029694740d5501025faf483d14339:
> 
>   arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios (2018-12-06 13:46:16 +0100)
> 
> ----------------------------------------------------------------
> rockpro64 regulator fixes that cause stability issues

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
