Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BCC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYaoC+Eq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vCybS1R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BCC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W124U8E7fNSAoyFIcKbBJrxSe55dC5fA2dNtsgnkgys=; b=GYaoC+EqqZV/Dw
	Udd7ms1bztmAm4uFrlrBeuMq08E9BcRHGnxfztGGCfCtBonGJsSFJ2rbLLeRfPMdntw9YGZ9h+URn
	GCJQx+qt3LFjZ1hV+loFItlxKhyu27FBKsvtdeaVw1DdF026JjZ0zz3EHCqeNGCAYw8P+PD3MHWWs
	bVTWEuNbLstj/MxuMcofn0RMudjDEMKZ0siIOWxkCoPS3FMbeGpLPrQ1qPcprT+P0Ek5IVvwNEuAv
	qetp2biIQqytCAFBsp6sQsB0vo2qyhX8RiLUfzthR52P6QPusqR0dcyiGofFOs3zctfSC/C7Zl/zC
	P4bkkklircu9AHwHH35g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvd2-0004PT-C1; Mon, 03 Dec 2018 21:19:44 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvbG-0002ES-3T
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:19:04 +0000
Received: by mail-lj1-x241.google.com with SMTP id v15-v6so12789760ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZFTzYmfw6S+2BRFQq/TH83ulz9jljLux7IcR/0e89RY=;
 b=vCybS1R5RUvE9GIM8KFxFAVPaKlwIUB9Hi7EXbBV24Eoj+0wwdq2U6UNDh2D9Mw9J6
 29iCsOxfwgvRQZx2aNZ0Y8h8bpzr/yoAv+BcmtNkUrSJwM34/amEso1ml2AOtw0Vj4DA
 /bbaF8/+HxUgChELDtnkbhCyxGY/sTGjOyhlsNSRM42I0QWyP7n6YbJU/8tV1VeLru/R
 Q7BBoCnlUn7kL/FMa438Fnk7osuTevnGCEiDjFxywLBmWL/5+FZzZxOhQUzmcMDUyHl4
 W55lAhuflS1br816zBzGeD5nyt3WJXpxecVHg/UeXN6wtbi9Yg8A1WC5tPQ25tCGabeG
 EG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZFTzYmfw6S+2BRFQq/TH83ulz9jljLux7IcR/0e89RY=;
 b=KsLC45lw2TVUuMVcPPAtS7+2GYYrEz/AZ79jTeUky2MpqQVCtJG3+ZHT3tzprpDpIl
 m9zrouS+nsRsV1NbVW9dGCTxkn7JJUILqMs2JTmshn4n0QhMe2cauyXUHv09R8jzn73W
 ot5xy9sQQ3TB79SrEkNin7kO1UaOC/MRm2IawAJNL22heMjFmTy7dMhjQ7MI4t9jrLi6
 3CLt8rDQxQmFiebNwARgtjj8Z1wLmSjb1XYD6wdM5yUSatgqwCGNeQy/MYHS2TTNJ1xE
 tWNFC8N+M4f4J7vstXIS30tNUjmfR60tLW61E0v5IW0KWBxMEmWCssbZXVbFBXlrfX3k
 kWMQ==
X-Gm-Message-State: AA+aEWZ7AJ0h2wCgRwEQjLxCIzb5f8C6oJmw+hul5ECkVubkpv2Bp9hN
 WRGzkIyFid4Z6u94nKB6QWNqTw==
X-Google-Smtp-Source: AFSGD/V7O1xDOmh2DJXrQEhrHKdfWK/6jeKE9PFgijW+JiRxoGXNDQo4JZLccjSrUOTsoiwdqrnY+g==
X-Received: by 2002:a2e:8007:: with SMTP id
 j7-v6mr11487146ljg.22.1543871857436; 
 Mon, 03 Dec 2018 13:17:37 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id g15sm2549436lfb.1.2018.12.03.13.17.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:36 -0800 (PST)
Date: Mon, 3 Dec 2018 13:09:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 4/4] Broadcom soc changes for 4.21
Message-ID: <20181203210928.imtd632ctjamrqj2@localhost>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
 <20181201203942.13376-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181201203942.13376-4-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131754_939378_0DB93828 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, arnd@arndb.de, khilman@kernel.org,
 Eric Anholt <eric@anholt.net>, arm@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Justin Chen <justinpopo6@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 12:39:42PM -0800, Florian Fainelli wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/soc
> 
> for you to fetch changes up to 12e0888de8d3bab92d219379d4226c7f9c306a91:
> 
>   Merge tag 'tags/bcm2835-soc-next-2018-11-27' into soc/next (2018-11-27 13:24:50 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs machine files updates
> for 4.21, please pull the following:
> 
> - Stefan switches relevant BCM283x files under arch/arm/mach-bcm to the
>   SPDX license identifiers
> 
> - Justin adds an entry in the Broadcom STB debug LL stub for 7255
> 
> - Florian enables reset controller support for BCM63xx SoCs

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
