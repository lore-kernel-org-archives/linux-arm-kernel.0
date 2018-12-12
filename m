Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D033AC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936522086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZdKlMsce";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="r4plSYHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936522086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JH+KcCf9DTJx70IxuM1YL/369eYzhA13Mephar75lB8=; b=ZdKlMsceuZD81+
	7gzkVWo7mSuxK3ru4IgNvzWy2pv+4wqqWSZGRH6jAKTpAUpwF1Swllp9vVvlwuvZRhdmmVJYAIh0a
	qUM+VaCWNO9mZu2utEvMubNrPzaVcNnOtPXncXZqWF6V/Amy9hzE8X8sJIoed/lEdvpcPgPXUclyx
	ch2S6YpbSrmaX0T1GHzkk/ZY1dBlRwmIbsgWTKk/o9058FsK1hZnF9zLx1FpNZwNXQ4bveKR/BZ+8
	0HqszajSaQxpxYLtsPwrNMerEYEnM4Is/UYM5qAkFpM7ZxPm3PQTkxjTt/N1vq7F61eqr58Jj4Py/
	sPmNKiWQ7sq1Z9mi9TMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCo0-0006xj-D9; Wed, 12 Dec 2018 22:16:36 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnK-00067t-Fs
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:15:56 +0000
Received: by mail-lf1-x135.google.com with SMTP id v5so14787390lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jPKkKyBoR+FEiNpr5OAO7oOX0B93pGAiEh2J3kuznO4=;
 b=r4plSYHKmwWF8oSY429+ykK6sA5mtfrx6t7Z0qhbTGj2iPVwpv3oRiZEnV/3d/Rpr7
 c1BFmNVeyELWQLiYf9Dz2YLLkJX/1D8Dyxxq7jVdNTjMRWBxB6gwUnsfsQnq5FAXnUpF
 qyP1/RREpr0ioSC2A36Ou4krFrJc4kQxeQun1alKuZo4HUxhyrEjDcz+ju9sRjVYTKFy
 HhkZZCZ1JjWIJXk/Gm58wn6CwKl8bM9aZiUzBySZWqkokz5gM3O6F8nc0pH1bEg+3moa
 X//C2/vTNYMr73hGPmzsnhgnpPaKpgy0sSrXyFeFdOIwt2/k4LOIxU2WQ1XCxe+qznfO
 jqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jPKkKyBoR+FEiNpr5OAO7oOX0B93pGAiEh2J3kuznO4=;
 b=T35903tGXaOk+CtT7N+wcKdCVyNzuamCL01R4vAfuZSz6dP3OlaWukf8cY6xwBPSOd
 XOVPjppCqRDpjK7QZHNsN+7tWnm6UmN5LygCNXDBaUZI1+cqJAbKgBN1rD+lARP5nbqq
 cK+6STVsiJ4ij79a4sVNTZIipUqJdamDlZuCccQVxCdQkjJLs6uNEO1jXM56aBUnE8xu
 pHHydyTU2tsiEWHNCetGEgDMO+/anEJhCA0jo08+qVTbdKJqbsOuPciMwDhbxB4gKTUy
 UiuMlsad7x0DLpy2j1w4VFYXDLdY2MrJ4FDU6DJVGS299G+I+9zFEAsep+clhCUxCmmq
 AI5w==
X-Gm-Message-State: AA+aEWY6yUR0WxPYzyeGafzGTq7chyExvJUlqwfMjoCb1PqjbwB4/nb0
 8QZuKQBkr43/Ilr2NbKg4sjk81JNwv8Dhg==
X-Google-Smtp-Source: AFSGD/XKw+MTATOwx+SX77bY8Sfj12ut1HDTNsoU+0ZEuSnU0CWwUoBvHqNOVlpYJdS34VBTkCOwZA==
X-Received: by 2002:a19:c801:: with SMTP id y1mr12190162lff.53.1544652942530; 
 Wed, 12 Dec 2018 14:15:42 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r4sm1081lfe.60.2018.12.12.14.15.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:40 -0800 (PST)
Date: Wed, 12 Dec 2018 13:31:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner drivers changes for 4.21
Message-ID: <20181212213155.tm2fakt4qa754iae@localhost>
References: <20181207143015.qemj5ny36hyv2kug@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207143015.qemj5ny36hyv2kug@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141554_534354_AA231670 
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:30:15PM +0100, Maxime Ripard wrote:
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.21
> 
> for you to fetch changes up to d44d37cb27df5501de0693fb03803e244653713c:
> 
>   dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1 (2018-12-05 12:03:47 +0100)
> 
> ----------------------------------------------------------------
> Allwinner drivers changes for 4.21
> 
> Those patches are all about our SRAM driver, to enable new SoCs: the
> F1c100s, the H5 and the A64 C1 SRAM, that is used by the video decoding
> engine.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
