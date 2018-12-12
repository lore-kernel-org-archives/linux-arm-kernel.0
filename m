Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D860C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4DF20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z/xGoH/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bu5FzdDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4DF20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J9GoJYi3HSkEZrHez5zT3oYj4iqI+9F2Av+NuoJUivA=; b=Z/xGoH/hZh+KZF
	fY55g7XWwYAq6jY9VnSn1iQY/Jqo1ywMjiC/tvpAb3f3x6ZTWDi1/JzDU4GKMALdmhjJUI9ktW25g
	OJSC3JHvHQCOzlBIdZNEB4XLQXVToPRS5fCRu0NCTtRzX7pZ/SvNb/viLGMF0m2Y+tudg5SZ+18t9
	WbrbpWG0oD7DQ4QE2nXLIK/JYtBi1AJS7NzbrnlYxWD9pqFJgTJQYNuY+gBIspkZ96nEeh1nPEBcx
	v8VyApcFs8UCBByUychIQEsA5+5D30BuHYmDvFUkK/FIyCfK5W55qykjcXusDGUGPzJr0xM3PKbCz
	04mIjV7qmm8ZN3a2+SGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBsD-000830-7s; Wed, 12 Dec 2018 21:16:53 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqY-000518-HF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:13 +0000
Received: by mail-lf1-x142.google.com with SMTP id e26so14665909lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rpKDabZEYA1xkraWnHAhVESg906S5Ut+ICNpN5N8AGY=;
 b=bu5FzdDT9WXdu6YMgeg8EEvN31dju3UrvNYau6WR/CINHGo+mZzNGMqtY4GfL/gtzQ
 GZfdbJl1Q1y+1H8v9/RZ1iuJQJ03CUuJjtNhAmdge5VbcLlGsrLzNDx0vs0rX57on09/
 BUnVucrN9baRjMroF+FF90yIOrQP07N7DwbAZREE36qmcp57GLszLhA2gvCaYczbl1yt
 2BgMhHenSFnSM0/9bezqSeqyizNmHDId+lvGfItiULjqvQOX2j/3mBcY6c1Vj9gBY5gR
 x9C9FvEZsP8j6zdAojq6Atdq22cHR9VXl3nmrUykoX3gGysrZMtGoCeUraEbg4fXdu1E
 nVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rpKDabZEYA1xkraWnHAhVESg906S5Ut+ICNpN5N8AGY=;
 b=MWliHz8RV2ts32YOAVoW6ytukOqWQ5w7vStJ7EUqxRo0bnMBlsUGMYXr+2JVPWHdYC
 mMd36//dK+oEiZ6PLb245HlH7nlMYQEixm9Ym8aKqMguYd6SjLBEBlh8XZm1ojLzPd4R
 7i0RaTZ1gt1DRyt6sUuDYEIUzdAVDNeGtnVPwsHbr5Zz7vZHtKTOlNmmgL/gcyhVjr4x
 BY0hDYkAZvv6eVXPoK1O6JrsfQjVao0L2Ma0Fg9TRZ784HfGoiLLnzrT1AmgHCBqx347
 qGHYXFXGEXNSLbBjvvfF8A8/YQP2s6tu+cQwoQODH2ajnxXcc9zzrdPdSKRc3cv0Xyrc
 XfpQ==
X-Gm-Message-State: AA+aEWZmIJ+DPZt69HW1R8ihCU/rdodxk+sNrxlPMlJ9ScN+qkanNcGo
 Lyffhsnj1xJuc8wvO5nTmNbQRg==
X-Google-Smtp-Source: AFSGD/WY6dLD3cQyZ2ImzL9lZZNyNW+o4NDape33dyWLipvIgSGyCddkZe4zdcxrgLMRgQVrC4zbQQ==
X-Received: by 2002:a19:aace:: with SMTP id t197mr12433171lfe.7.1544649298431; 
 Wed, 12 Dec 2018 13:14:58 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id z9sm3384508lfj.79.2018.12.12.13.14.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:57 -0800 (PST)
Date: Wed, 12 Dec 2018 12:54:01 -0800
From: Olof Johansson <olof@lixom.net>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [GIT PULL] arm64: mediatek: dts changes for v4.21
Message-ID: <20181212205401.xixp6qrwn4y5wd4t@localhost>
References: <e5b4136c-99fe-16ec-8974-9c4d1d83efa8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5b4136c-99fe-16ec-8974-9c4d1d83efa8@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131510_854005_C2DCFFFD 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: arm-soc <arm@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Houlong Wei <houlong.wei@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 11:08:59PM +0100, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Below the very only patch, please have a look :)
> 
> Regards,
> Matthias
> 
> ---
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v4.20-next-dts64

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
