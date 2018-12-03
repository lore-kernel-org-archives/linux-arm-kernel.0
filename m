Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC69C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9212064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aw4RHRVZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ee836F//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9212064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wFs1ER9VbZX+OylXIqkRRZbr8bOb3Sw9bXzx+cR6bJU=; b=aw4RHRVZom7V+p
	8jlLzKbUid+igWy3MnYA3AnmFgKa72DItp9RLZmB3dDCoKrIbyMlORNW7dPlyZaXzEMmeYy13WlX8
	8lX+piM5rD79CO564vOvCtpUw0OQHTHNxoqsNYGC5E/b1cXkjCBrjNd1uduk2aKSLqL2MiWhO5D3M
	kpoIK05q2QDRZD5QqAm5D+t6lNxSFCr0z4mCWiCCEwQ0Csh1hEFdZfuRqbe/PI2slT2YMuDhj43nS
	+sKIKJ7A27bGAJnmLMQyida9qcj1PsLftLw3kwIU+tCDKrKScXd6Fmw0brQsMOIeBGkkuc/SUesqx
	B8uLBCuJo6nXk8O5Mn9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvbn-0002z3-5d; Mon, 03 Dec 2018 21:18:27 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvak-0001lo-0S
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:26 +0000
Received: by mail-lj1-x243.google.com with SMTP id u6-v6so12821056ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8UVNYd6o3pSrZdgRGNRBnbPQMpC47UUUYZH1m63BDUE=;
 b=Ee836F//WErANRpv4lB8rH6xEl3sghb1An4xrTEi4jxmC+w1/5OWwXbV6E7JTdyo1U
 CehFefcpFZd47S9GM5fmdefI43bp/8Bmm6ak4V7ZDbwx0W3+1RZ7Q+NS/J2uwFyoY/mY
 203QfAEY8/6PX+SOJUbA5Fep2ta8O6YSBeIEbI+11QKVH+v6luQaBPKbVSD0YIt6zmSt
 aITchicRqNWuaVagi+olkpyp/cVMy7pem6QT6xEOz6Fa8EQcMdUQGq7FpDV5EMXyMv1j
 BGssf+xUzs6diJmyWPyyE38rcrDuHdnMDpHqzgrcqoNIASzNsrCLK9cGwxSv3ii+yx51
 zfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8UVNYd6o3pSrZdgRGNRBnbPQMpC47UUUYZH1m63BDUE=;
 b=B0YUkpyjjgRQAdR0SBRQghcJnjx+wwFa1FCoIInNwCbMmfizOgtJPdeggEN5ozV8qg
 oCfMlIHhoVCFqFC7LgY/+afbJHXcSLW2zQHSVo3C53+UB0fBjQ7Bs0uXHRPaNGs7Prjf
 YEFG7x1n56mvFsIXB7pz472fZv82VFLO+MXn6ANK3gxqLPdYO2NH4nI6Ps81ya7EDzwK
 ysWA6TNmpROJvwY8ia6I6TrIeQlnsockQOztRm/Y83CkAbSdMhS4uLYLOjAOs+w3smv+
 Rb+6LJuCG/uNh8M5kY2dG5DLV0v/1qJcldUDFWmEwPKWQP3vqgWLuzNGaXBgxG/ZJTcL
 /HaA==
X-Gm-Message-State: AA+aEWakPZqTiEIdqjzIHPQ0JCsYs7K0WEKYZN5NBqyAW5R4no/UO8Tz
 WbnMb3JxefgBQmb2vgGei5KxFw==
X-Google-Smtp-Source: AFSGD/V5kF/sKScZsgwBTpYklTmEKg0WBbVJLR/Jgvys7NFB4twJUMCqXuyrORUL5+2LZD9QC6VGMA==
X-Received: by 2002:a2e:1b47:: with SMTP id
 b68-v6mr9507929ljb.104.1543871836756; 
 Mon, 03 Dec 2018 13:17:16 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b25sm2580638lfa.96.2018.12.03.13.17.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:15 -0800 (PST)
Date: Mon, 3 Dec 2018 13:05:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 1/1] Broadcom devicetree fixes for 4.20
Message-ID: <20181203210528.5won3ooveghdw3pt@localhost>
References: <20181203204721.4434-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203204721.4434-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131722_494880_B6451068 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Matthias Lueschner <lueschem@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 Eric Anholt <eric@anholt.net>, arm@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 12:47:21PM -0800, Florian Fainelli wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/devicetree-fixes
> 
> for you to fetch changes up to e25b6783c7b1bb79103d4617336879423f86b05e:
> 
>   ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs (2018-12-03 11:51:26 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree fixes,
> please pull the following for 4.20:
> 
> - Stefan fixes the polariy of the Wi-Fi reset GPIOs signals which would
>   break on Raspberry Pi 3B and 3B+

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
