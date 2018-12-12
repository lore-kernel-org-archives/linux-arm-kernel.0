Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228ED2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sgNIC8Xo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="olILnwti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228ED2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iayHYUhyfRATdgD9CzlfCrO7dtYTtNDC9R1GKLapsfs=; b=sgNIC8XohcbD54
	VfAK9d1c3DLuYfa0G2aFL7/4RjFARBaFDa4EAy6gwJJMKYdHoPEP+tK0XLx5Sd9mqCzpouebwDnMS
	jz7EvmslyA8/e2nZUA8eiFvFeEcyc9VU7kImpbXHU+Qa4bLbKFGsF8QuAlmmfNSqnBJo6yDUv/NNX
	uFjQeIWZUX6r683YusUfloQij5UB4pD4QPbc4WjS6Zu56s/mV3bm27vLQe0CFeDtrRxaDzljGh323
	iCmBynl+8a5NKS/hJrqP6Oo3sZVDoIvT8s6EEg26KcFe/zOJTMBhkx5a/8x301J69eudKJTiPnLCE
	AgamtVQXTLAdZAVwCGrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCph-0000Gr-IM; Wed, 12 Dec 2018 22:18:21 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCo3-0006r8-C3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:55 +0000
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so17715643lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bwP1nicwuZKsjMYpzwflT/kUMeqSpqvcgoPpmj5aZ78=;
 b=olILnwti3VlSInWp2LcxTQkC9p8I2iCDcArkbcE3ZO0LVP8uUPDhm81OGhsYpVAipR
 b7d9ZvN6R0JnKbVWxtbGXSIZbTBEsxGisKfmxJGd6NSUBZSN861c2IeRASDl7y7CuemT
 Bbv0hgRtMIqjKta2VKsVdRKok2Fo0KtT6tKaTjA9XLoW+PPx13iVZto3zVZ5HGYUGyK9
 Bi0Fo97r80FSXe1wnZzcA/1pkH/VTKKgVmkqXN5tl+AYLF2AvtIcq1e8vwvCbyLWmrZN
 JkTV24NVOEWuzp2PWVghL32fsgbqHAvHfH2qiLG8VSgh8MMJZ9pSTWG49xXecuJWUzzu
 TNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bwP1nicwuZKsjMYpzwflT/kUMeqSpqvcgoPpmj5aZ78=;
 b=kvQGg46Ik6WBH7mvtY+BN7zgwQN/y6AFDJpDvivJCCz7dhpZJhg79s2sPNU2new85/
 yEq4KWylEi3o1tPVg/h4ixg3gHpZ45HMa9/fo9HfS6MXYlo2dIXzmTrm3DxMinBN7sxq
 4VRRRQZ4aaPqqAmw2Rei6QDdRqRmX7J9BnmFdADi+Z6DNGig6jGEFIRJvZkDEc6nHQDJ
 TyMe5eMFEAS9r+023xZ2TqwPM1wA6R2JERqibr0Srf3onXCQymm+SSMxYzRogYm7s4PW
 LqxanRXStMERVWlWTOd4zdhorxzb6E0FLC0i/vtt6IcQbRVUxqcQSDYSooUgxla31oFX
 PDSQ==
X-Gm-Message-State: AA+aEWYABb2h82CskDUiivqewAFCBnp6imk1a9R6TZlLTz9RVh1TVaNY
 9tXVs9h5Nc+OzLy8rkTOxwfBQw==
X-Google-Smtp-Source: AFSGD/XFG4dRRVSi8NBvVOuxo9F3Y1Uax2xs1cngKBf8tWA57PnnS/492AsyWhkAZa/1tFz1ustJ8w==
X-Received: by 2002:a2e:5054:: with SMTP id
 v20-v6mr13171829ljd.45.1544652986859; 
 Wed, 12 Dec 2018 14:16:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p19-v6sm1913ljb.47.2018.12.12.14.16.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:25 -0800 (PST)
Date: Wed, 12 Dec 2018 13:47:06 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 1/4] ARM: defconfig: Exynos for v4.21
Message-ID: <20181212214706.tvxl7iojz5fvlemv@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141639_630191_EEA07D8D 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, arm@kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 12:49:08PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.21
> 
> for you to fetch changes up to 24c8e4b85399b00f4ae96e7957b0eeaa374e9380:
> 
>   ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver (2018-12-07 20:18:47 +0100)
> 
> ----------------------------------------------------------------
> Samsung defconfig changes for v4.21
> 
> Enable drivers in exynos and multi_v7 defconfigs for MAX8952, MAX8998
> (Samsung UniversalC210 board) and TC358764 (Arndale board).

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
