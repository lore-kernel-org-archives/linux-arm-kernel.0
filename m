Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:19:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4467B21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifkdxkbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4467B21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKE5VU70TT1PzN2xKzQgi8w6XHravZSO6OsZbHUVDFc=; b=ifkdxkbSIes6js
	xpsO8oqL8Y0GfouK+SiRkMUcSkChYj6DIfyVZCgXoRf2QRX7tk4JB16kMTR2o7uqym+DTJpj9EP4t
	RT5ludHeZAH6lYjn75XFl2ss2euyBSMUMvwXyUq7UE1BNm1tuMkIMgzlGUO9fYwSSDqUKE2LkOHOK
	egsvnzJaIj5tuidmHZZylXKmlsZIvoUoWb3YR59N3PJN0k/zODCZZOJSZZZ7ytaXg7AbASueDjatp
	qTMLTEWnDIfZpXyGW/DJVM8DrurTKukcekExT39zuD9rssLrC9XF3HZjbZJd62OgaBmWQPSNfRxbE
	MvETZ6FmaaR9PmR8lXVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvg1S-0001E6-LX; Mon, 18 Feb 2019 10:19:38 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvg1P-0001Dl-LY; Mon, 18 Feb 2019 10:19:37 +0000
Received: by mail-qk1-f193.google.com with SMTP id o125so9653630qkf.3;
 Mon, 18 Feb 2019 02:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FuFwn397ir3mXbdPHzH2RizXYz96v+f5u+om4e9Skgw=;
 b=T3RMg0pRcdlVy1CLwb8K2YT1icJ6cH618UcOJEhc3PoO0NFrDrzIz2tayV9NeQmxNB
 XSNs/0e+QrdE7Sn/BorRitw/Ml5m39JuI20arXpda2JktQmfsntdMjXXbbtcVN7gCqW3
 WLl2vBoNugr1Bi/YTUtgZt9HX08YJGAwzEGQVQVJYziBQ8QTegmqJHxqYusBeH15RuKk
 6fnrNOL/ZFPsSpre9UdyhMcJglJO4TJzqyBbfsiuyDMmyFuHfI96W+y+LWNLWRiTz1N6
 awtNzebFMdnv72yEGFoIkEaBWk5TeERTho8qHByoRpxVamMSGEB4BKKuZcYQzF8cTRrT
 M1MQ==
X-Gm-Message-State: AHQUAua8xXhgHggmrrazCnK3gRGyz6p+ayLGVl/BXdCoGSTFcQcOe+wW
 qBmaXM9NUkmgsyhzWKLxrH5/6I3OFzIcLYu+zgw=
X-Google-Smtp-Source: AHgI3Ia+paP1aSaRzLYUk8W/X4Pm9fJhfcJFMpnx5VwTtGgQ6mSk4wVRn1vI4LmXLTAwyRviFP2AGeuGcLA9iFrMWpo=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr15336111qkf.107.1550485174755; 
 Mon, 18 Feb 2019 02:19:34 -0800 (PST)
MIME-Version: 1.0
References: <1972197.JU0Au1QvNm@phil>
In-Reply-To: <1972197.JU0Au1QvNm@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 11:19:18 +0100
Message-ID: <CAK8P3a3oBKmGk_3YyUgBELkGNMSUYQgTGtp89n5oBBd9ugJLiw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] Rockchip dts32 updates for 5.1 - round 2
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_021935_701740_AF9BF7B9 
X-CRM114-Status: UNSURE (   6.53  )
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

On Mon, Feb 18, 2019 at 1:18 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Arnd, Kevin Olof,
>
> please find below and in the reply a second round of Rockchip devicetree
> updates targetted at 5.1. Again nothing major just some more collected
> improvements. So if there is still time, please pull.

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
