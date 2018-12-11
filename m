Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88381C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587192084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ge3E1fj/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="eUMx3R2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587192084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3807mcSj3qZYEOHsdf1zOlExSzX+VRBrojJLYosY6bQ=; b=ge3E1fj/IO9Ybv
	Lh78h9TDuOr20p9j/41tDK9B81iEa19CIV1V1lpnqMiWFOtqhjesVcLH6uTwCYHOKAGV625TlEuJU
	hfzpNA0GRePepGY/izJgIGAOi3h+ywARBbYq0afYQp/RPcXfKrch3b1n/18sYJ2AGpz5f88VR7X1Z
	vEOdk9GuCNLrdtjusbmYjYCJSYdq+5GtSqdZf1sw4y0D4W/jKRAcJqysIOEyuhbrZ6M/HTz6njvzW
	0HQ3mdiGOu9w6LwL1GUa69TgB9Q2LEeIn/p5F/TnAZeWTqf6V5HEWQ0cz4qndltbFvb2djmaKAXvM
	S93QQCMUWxrURTWcvaGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWked-0004zn-RL; Tue, 11 Dec 2018 16:13:03 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWke1-0004KN-E4
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:29 +0000
Received: by mail-lj1-x243.google.com with SMTP id k19-v6so13430706lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g2w6Q2iGOj4S3khMvTq0cyTjOd5StSPaMb8itT/b1U0=;
 b=eUMx3R2FPpjTSwX0GlhoPQe3eJ+eBC2s7o6Q3eUuPtXEyjlDoXD/dPl4oZwE5mKJ2v
 NS0RY1pCXcEBGu8h6rcQAoVOtatUjX44j9sAEf57wv0fSr7rBT9QuEhqKyH+8BObNQXJ
 Jo0HRGNMhi+te47DVLMsGl8xYxYHUlanZCyPvtWuCNZp/76owTsut2M3GlzbahOX9NwG
 qfZYJD1XYnBW+tssre+oQanSVBaQ8vt25KmRiXfxk36+YESDkBS6R06R0PIX4AuUTrM5
 ccdNnj7ljw8nEFG4Y86bPk2xHD3c8fZ8VKWOpoNs3g5cXHYO8BJNS6kNa49EfDtTa65l
 PotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g2w6Q2iGOj4S3khMvTq0cyTjOd5StSPaMb8itT/b1U0=;
 b=PHgk8iENB520rjFga5a+GDPXK0xjfTmyertcwoOl/ReSHI9KterYYLj4So+vXzvLfC
 A+cMCEiPFBqCxu/tk3dt0YIhHOiTRQ0qFSYqMoNGX2CZIym4EtlHYSUNnbqpTm+tchKF
 KGGJNADW7cRa+P+Jjn073Y1XSFyeOoM0VFD6meIzH5ZmrbwRXyIKYyS4o7h3isJfHnkn
 7rBMyVot3PK9RRglis3+HEjaBaqDI0MBO3TFWn9NNlSctcbBsQAKpEDuPlmlggPUMnhb
 zTnFyHnzoua1nZxi8wgke4qt7fnNrdxg5FOlutFUFABp7ccxKEjSi54+bJ8381xg5xPo
 ZsVA==
X-Gm-Message-State: AA+aEWZUCthOGyLE5FPyLR/5ivKMiTatDV+QT0otTTA00K3vrbm55W7H
 WO/lNEla9ZaFyOD/sRv7hMRiqQ==
X-Google-Smtp-Source: AFSGD/WRGnnH0KU+w/VeJwT2IBa8X4Me6oMDfmDUchf/ThYAYK0sbjVYyScqMevgbVIebX3VrucqEQ==
X-Received: by 2002:a2e:568b:: with SMTP id
 k11-v6mr10547179lje.105.1544544733452; 
 Tue, 11 Dec 2018 08:12:13 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id o26sm2844272lfl.18.2018.12.11.08.12.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:12 -0800 (PST)
Date: Tue, 11 Dec 2018 07:49:59 -0800
From: Olof Johansson <olof@lixom.net>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [GIT PULL] pxa-dt for v4.21
Message-ID: <20181211154959.ajujauw2ddbjdgif@localhost>
References: <87r2exu3wm.fsf@belgarion.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r2exu3wm.fsf@belgarion.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081225_767174_7A08DA9C 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: arm@kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 08:50:17AM +0100, Robert Jarzmik wrote:
> Hi Arnd, Kevin, and Olof,
> 
> This is a pxa pull request for 4.21 device-tree. Please consider pulling.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-dt-4.21
> 
> for you to fetch changes up to ad8044f87c0b53ee45f5d367584eefb222a06883:
> 
>   ARM: dts: pxa3xx: Add Raumfeld DTS files (2018-12-03 22:51:01 +0100)
> 
> ----------------------------------------------------------------
> This device-tree pxa update brings :
>  - various fixes from Daniel (W=12 issues mainly)
>  - support for the first pxa3xx devicetree pxa board

Very nice to see this conversion, and yay for having upstream support
for one more set of consumer products!

In general it could have been nice to see a bit of an overview of what
the new boards are for (what kind of product, and why they're split up
on separate DTS files with relatively small differences).

Merged into next/dt.



-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
