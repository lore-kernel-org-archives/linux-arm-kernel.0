Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B1BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2552720867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hcIVB1Q6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1iDIb8DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2552720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OakVG0MaTR0dhY6bqMFNzTt8lgUQ+GWROEx2DwQvviQ=; b=hcIVB1Q6rsIvvm
	BwhNeDVPi7BHwk3HXljsJceHkb2+Gz0RfkGbu3IHFidzMpT0XvUioUdw/Yfdo/PJLh0BL9rz10LCK
	pEVDtMl92xv/RnDWcpHJkIlxkHZlYP+2KJbfQJUkJyHpUNhM2M2v741SBlfY9Hqm1aJGZHreKOfqW
	hmEAGAstVtHA+h1x6BpKxDOFlNEkqaK/zSWieRcg2/1C6Rn6RMsE6k5S+CICoB4Vu0RpYdjAWlT+w
	GQA02Y8KJFWS9VyiuwKdAu20YGu6hZ0f4Eqarj287BA6bm1E8sRWr9LMqcuqdfPlS7SKt82055lTd
	b/23cbMox8UXpqG6IRhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsiV-00072L-RW; Sat, 01 Dec 2018 00:01:03 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsf0-0002RN-MP
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:51 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so5349737lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dhyFZxjm+qrU3kTFxwVNuC9ciy5QCHeSf2aApRloaKE=;
 b=1iDIb8DVJSx2VjupcwxK0GZb802ShEHPzT5AKJJhe7JjXLoT5ev0VZhd5qNJZv6Ypl
 CH97hkJzmQ8bK/t3thGAV9a7lJyIsasJ/6WqKU/9JYOXdoyDom0q1QqFwR1mhAf/iDQ/
 EM0zjf0rtrR09R/C/T/XP6jSzEnI3W8xwSxCrZRbI7ITvGvtPEFiNOaprxVcQgukM0Ht
 WoWNhO9Kt7U7iuG8R1LyDYtNpUwQv8dLubJQGPmlfi3iL7Y2slO5uKAkoxFo7DEVbd7P
 0ojC+4VMahZMgUhmSaeG3pAPYtRplFPjF3hYG+h8HGeu4HjGml6KIm1mCk+wIAe6o/LO
 DqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dhyFZxjm+qrU3kTFxwVNuC9ciy5QCHeSf2aApRloaKE=;
 b=IEviY4WG7qPbSgNbn7vk3362llV6B+TtgVUTx5SxmDLRE9HV8EQKDjUMYwpoUM2IMc
 z4vZfQlyyCl410n1caVBygmi2XazvSJ7KXAuJawDVderbJM54syp/Di0OlamA+BNavi2
 K5H4K9lDUUbeO5b9qGe+NKHbsKnf8dxww86Mu+Y+HCh1jJ6h+EyzPhdhAJCTiwjlNNxU
 PuRRQyDgeSW5ctkDyOMl21avCYWyZxuxy9FZkgISJfH6r5csOqmCsgBBe3K4AKXFSLMH
 8GjsZj9GD73///fI5RX4IFq0pESrOlb1ZRji/hdXesvconqfGs22x8Mh9vl47bPoCQPJ
 KP8g==
X-Gm-Message-State: AA+aEWb+6T+iFCgvpBOjQwQzwwea80reOBFL+w1z0jx2TyEHiBCDan5B
 YAJCw2cdSDmycM5atJ8kzQ6i3A==
X-Google-Smtp-Source: AFSGD/WValPcBdgoCflTY1N6N8hYK3VKt7tT1WaIcyMbkpcOSEb68JnVd8XsBlwzLb8204ucVaBajg==
X-Received: by 2002:a19:d70f:: with SMTP id o15mr4891031lfg.134.1543622235062; 
 Fri, 30 Nov 2018 15:57:15 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b22sm1040464lfg.32.2018.11.30.15.57.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:14 -0800 (PST)
Date: Fri, 30 Nov 2018 15:42:05 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
Message-ID: <20181130234205.nejqtrsvwtocpq2t@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-20-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-20-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155727_070660_A8617E13 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> Use a proper PHY driver, instead of hooks to a board support package.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Pavel Machek <pavel@ucw.cz>

These should have an ack from the USB PHY maintainer before we apply them.
I don't see him cc:d on these patches though (Felipe)?


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
