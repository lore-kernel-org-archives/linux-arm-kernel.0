Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2539C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8053D2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmHM6mue";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="g2aP/yDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HWzx86P4ID6fWUcSpSFwzYqUsFLfKjw9WpdoKDrgPcw=; b=jmHM6mueeWFb9d
	+6o8XaUwURiRzGBfZsa1FLtLWecFCGwcWqtwkn9A5NW3c1fx0qRBsdz3kk5/y9siE22pvoFcxv0Ii
	HP1RDV7HXr/PzAD74G767UIu8DT83uCuZImPg5R5aLH0YjAbfMWHdqwGC3JUlB51eJtJu9wwP1Gna
	NmfzDM2dCP7FLyHID2blDEJosMAcy9jiNGOOxQEOXiO5uGgMQ5p1agVBYpDxm5sj1dKq0T2lkNvnY
	rqlv/6Hyrwx/XeOOX8EASBkfrzKcWeGlc6ii8nZuIcbqkRKhlptf56YECT/6yCXrEAa7yeVlPMY/e
	JJpgbAXbAHX3Qzal+0kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCqz-0001mZ-B4; Wed, 12 Dec 2018 22:19:41 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoL-0007AU-Nk
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:02 +0000
Received: by mail-lf1-f66.google.com with SMTP id p6so21931lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bASMhwiyokVz/fi6N+75gKfzo4cHbZX4Zx5aJ9zqcfk=;
 b=g2aP/yDvEY57dtITU5IgcMeNH+HjwqrVbeQWGp5Ft92pxL6TOLvIqGx54URcT3D9pM
 7O+mVvIhRXIgByJYaOPDbMEdgBzlmG//KhdQttL6MLxhxVG/vNMMCgB8Dje6uiIL7J6H
 Z7lQ71zDpyObPWyQfdaHSYNoLtyAg+I8cdCwmXpgg5F2M2Wp8tXSpdZpLy8IJ9Cn90xp
 Gghn8kQJmzkEQwJeazh+VB6tYP21wXhHmt7bJw1HbS67Epq5XUdcQs0NOXstTbDC2T2P
 1XL7L6iQmhxOiDEsA7YKmGjk6grZ+z4F8pbyABiRGZMEPtqdJ4vwoXUuDRQfB0MZyKbM
 VN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bASMhwiyokVz/fi6N+75gKfzo4cHbZX4Zx5aJ9zqcfk=;
 b=tRh5eofaGmfeERW/zRYsECpZCjwEKGupZ5gWxiwXLchS5Wu7g9fctduyMp4OOnoTy+
 XSrBemE7CWDvqIctkO7SaXtiPrjxVN2kXFhyP7R7/0WWbSJLBMHnVMh1FfOWc/pCo+IB
 4zi4MYoIMOA1L0Ie/PhF3GkUI5OQJb9l/6FdtzW8MeRD1+zK7DZxmy0NZbrId0oW1xeq
 TkdOTXps+ReAEr9L8sR9ifXtWGsWTtfxLi/dWpqjius20fB0ZkZHE0w5kuo40l3dK9e1
 4TNXBlbU03vh62dEJ7DZD/jJb1v3JhpCEhDWNqCugDL4erYZ0LPSq4uTvJxK2ntxlZqK
 XKlA==
X-Gm-Message-State: AA+aEWZ5enL0jJEvYtPODmVWhTAtMKPxY1UEW8Y38PCSpHh0CVhLLmHF
 BG+7vcWKJor/eUM5pMrAfKtFM2UW9nRzHw==
X-Google-Smtp-Source: AFSGD/VcHVQcjDHgZv0R6CwBFFv2rtKMJipBNNd74n+Tl6KgpWjeePb9PsQihcIyj2ty88ZxoWBfqw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr5266044lfe.68.1544653005255; 
 Wed, 12 Dec 2018 14:16:45 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 65sm1975lfp.55.2018.12.12.14.16.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:44 -0800 (PST)
Date: Wed, 12 Dec 2018 13:51:39 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner core changes for 4.21
Message-ID: <20181212215139.6or7g45t7opcojcx@localhost>
References: <20181207142553.rr6yzhddwz5epdud@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207142553.rr6yzhddwz5epdud@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141657_927270_98FF8456 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:25:53PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-core-for-4.21
> 
> for you to fetch changes up to dabfc8364ca76c8f8a24e8b5efc348869ac35d79:
> 
>   dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt (2018-12-05 11:58:41 +0100)
> 
> ----------------------------------------------------------------
> Allwinner core changes for 4.21
> 
> A few patches to enable a new Allwinner SoC based on an armv5 CPU.


Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
