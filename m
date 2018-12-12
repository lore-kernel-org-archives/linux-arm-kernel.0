Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F969C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597A720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ChqTg6Wn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pvPsR2ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597A720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CT+VvOeDG2wUwYyZq/NhL5uWRE+hqx+0LYLLAAsb3l8=; b=ChqTg6Wn8HAVjN
	YwwloL6UHZ6r2fG47u+f/tjq8nNaORgOJa4WFracPxZtCbue++NH69CJqUMkntSbvyNx/2JwN86LD
	c9hu75ie+O3hANx2PoNhbV1MMh7MlTMHHLiF6BPOpFQQspL01f+UafP3Vbser/IFDJVIl1XSUDPiJ
	wXC/S51xukK64/ZCy0Bo8lUVGKi9oJQ67H5O5vY2HOF73+mpBgB3ZdoOE80lcBMXCt2Sb8eIIURUt
	0kslVB+fGRJbXe4WfRqxMf+0hVciGv6wwqSTyaA43bDZNf6Rnzagv01hK8KeAQtT56xORr1sjUDH9
	deovpfoRFXG9aJ7PI1Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBuc-0001pc-Fh; Wed, 12 Dec 2018 21:19:22 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqo-0005tE-HH
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:31 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so14673044lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vkZkrqIAi1/srhCBdVtehHcELojivhWWIOrcDOki4Uw=;
 b=pvPsR2ih4lcSyqDJrgF1aBBOcZU/91KdWvigVvbOZMr7KNcId29rI0cC5ZgJXTBGNK
 dBHeof8vVlB+FgzbT3Jz+zSguAzULPIxZzPLgb2XCdjkOIpTMJfzWfOy5p0NTX0Jtlp8
 AgjNRyr9rVsxdcTjNesJqCEmnEN0RJbw34Z+tIOGa/8QbcWC9QgSZk34QjvedFr/Kgkc
 JlcQvM4nj4zt0EConmKJtEQw/Q9LRx+mDwQ6hpE4GSgvpGSOT/krYqXSlBBmCB5kV+aV
 lEEYfH/P3h3uWS9NwmApLyWj5CuMnlAQDg/U7GA5nVXByYsrB1aXLj17euUifP67yFZD
 hp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vkZkrqIAi1/srhCBdVtehHcELojivhWWIOrcDOki4Uw=;
 b=H4B2Xhru/qsxpFbadY+aAw5mU7J2YxHh1mS9X8irgVfLQb6czDxKc+taUoRm4ovlPZ
 m/2otW+sINmkjMTjwIRbGlks2942Wk+PdzncIe5R16y/e1iRLavMGMwEcxXls8xdIH4e
 0V368GOvQKkvY8ZlZ7+H+ZZVCtbGVyRFeoooD1grxIzeAOHe5KYeSJd/qTxpLSuiYlW4
 6y+IyvRwZaA+oJL5B5HohYU968/dRuU9Bmig267maIkBUSwRIF7V7EECax7WMznaBrnu
 36AEbRhV2acY8iJmaNKWzHJuHQ17Ey72rv0oO4vN2DdfYWqfCMXPnKpF6zMhtBXW7O3L
 f8/A==
X-Gm-Message-State: AA+aEWbhWkpfYxRSL1A/oSBUrN5hzbri1UoxtiX4NWcw5a+vmjnvp/rh
 Q63MUqsRA8BgvbEdcpthYlydWg==
X-Google-Smtp-Source: AFSGD/VBRN+YwZL/8uMZ8CVLMOQPITg7vfy6qTGyTfixosPmCwp7vEuG91oCfOLLAqxtD8GErcRVKg==
X-Received: by 2002:a19:2906:: with SMTP id p6mr12295600lfp.17.1544649314749; 
 Wed, 12 Dec 2018 13:15:14 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x16sm3318674lff.26.2018.12.12.13.15.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:13 -0800 (PST)
Date: Wed, 12 Dec 2018 13:05:53 -0800
From: Olof Johansson <olof@lixom.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181212210553.jk4uznjimi37fd7p@localhost>
References: <20181211171112.GA30925@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211171112.GA30925@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131526_950113_3C20A185 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 06:11:12PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is the DT pull request for 4.21. The clock DT binding switch has
> been in -next for a while and doesn't seem to have any issue.
> 
> This is based on the 4.20 fixes branch that you alredy pulled.
> 
> The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> 
>   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt
> 
> for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:
> 
>   ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.21
> 
>  - Switch most platforms to the new clock binding
>  - Small improvement for Axentia nattis

Merged, but how does this affect downstream users who have out-of-tree DTS
files that include the SoC dtsi? Seems like lots of stuff would break.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
