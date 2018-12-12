Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B7C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050B12086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lnj6uS4A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WbTYP1cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050B12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iTuobFshea/pvxTNy5XwFxOZ9XAuUP8Ad7MMdtj2sDs=; b=lnj6uS4AduDmwV
	iDloT0SDWeu2ZQ4+shkjNjGnpuBS2MaYYIOVCc2RCXD35GFoSze/TagovAldY9iO2QAZBQ9zozefX
	qwx/z+vrh8tYjVgt1NN8N/ZH+ySJogrEWEc3PTO+Y/6tBIGl6Qvn4tsRAh0BnzcX9OLvvHVtgXMFn
	4WFEGoXpky3u2hrsi8GfTqCMxKhiYTHGT7YYVFjBvZTuSYKaHr5aENCVhEP3oWZ5rdCx3vvgpSycR
	xi7THbiUo3ELqTPYIzSYeTBE0a/f3QdXqyYqhqsBzyuahhZXLtjGzLrSaBehlJDorXF8OtgkY3Iyw
	lflCbVeDoPDHD3+PBkPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCrJ-000288-5J; Wed, 12 Dec 2018 22:20:01 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoQ-0007Fb-HU
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:04 +0000
Received: by mail-lj1-x241.google.com with SMTP id n18-v6so17721435lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ajerah5isYx2kKs8Yf1tLRf9ZG7XLwAbtmYCYCui8jo=;
 b=WbTYP1cAWG55Gz2ejwCdYpQi3v0/P8MNn7N/KjOwdtSPRCfWOzcuc8pN3N25txmZDo
 lswEFVsKpLefjP1DLm2GhZjnjiKD7HZTTHuHYjn6UnNHjrb+XAhniR0hNUJzOdWFCElC
 KlWmkubM6bf1tYGGsGcaelnMS3xp2nK3g8t7MNwxvFFfuMMdjgGTGVK/WvHMQEZWOFo+
 sG6AHAlqWdY4WYHde0cUhXJGwwL/+V9OafI/A5Yzgz5PYna0ZgoK9DhrYkTjbiBiGO3C
 Bs53TzHLs6NUhsklA417Ff1ISxbtlhkZhBJ8VKui3ujBJ/J0r73vfiGlIstqDYglkP0N
 KQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ajerah5isYx2kKs8Yf1tLRf9ZG7XLwAbtmYCYCui8jo=;
 b=Tm9H+vVQQMDUsJgJD2Yy8mLHLuuIUOdwBNTPus4dDCk+PiTIJdOR/VwyzFVninnEIz
 jn3cAOUSFLZGfmeyg8fmJhektl2i9grfQcJrp25yZrvO01PUTGVIhvMLTzRXOqfujGa7
 OlwDTmXQ0ee6o7XBmtH5ZIOOg+MjiSmWM7x4J6oPFRc26rM41lh5ibiYUl6owBvsd953
 X14V+p6q3IKUulUZleSSZXXVYd8taUpk832R2m0RaiqVJNkhdtw+HKy/hX96h1Kay3LZ
 lpUSqEwJ+unPHZX0R8Adxu0Te/yV058OBcfnC/TIgUecGgeG7o0lkWu3p1QXN4pIFqnF
 Pzkg==
X-Gm-Message-State: AA+aEWbD3qy8HJyJu7ErecUj+jJi5tj33BfT/5D70L7UoFJ2K6kXnRGN
 bgomZYYRgWNl2kynnr0y6zgXa134WIv+iw==
X-Google-Smtp-Source: AFSGD/XFmuNJKQW7n0ebYM8DP31/zcQLxRJPFaNbgfdZfThtFNfPUzxizq2gGqZt1Aoe/XnyDlUgzw==
X-Received: by 2002:a2e:568b:: with SMTP id
 k11-v6mr13788862lje.105.1544653010471; 
 Wed, 12 Dec 2018 14:16:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id w9sm1121lfc.66.2018.12.12.14.16.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:49 -0800 (PST)
Date: Wed, 12 Dec 2018 13:53:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 2/7] i.MX SoC changes for 4.21
Message-ID: <20181212215328.it64ay6ghnv226r6@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-2-shawnguo@kernel.org>
 <20181211025115.GU3987@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211025115.GU3987@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141702_714393_FD0D1B56 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:51:16AM +0800, Shawn Guo wrote:
> On Mon, Dec 10, 2018 at 03:46:33PM +0800, Shawn Guo wrote:
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.21
> 
> I just updated the tag to include Arnd's fix on SOC_IMX7ULP option
> dependency.  Please pull this one, thanks.

That's fine, but to avoid confusion in the future I'd recommend removing the
old tag and pushing the changed version under a new name. No harm done though.

> 
> Shawn
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.21
> 
> for you to fetch changes up to 167e63702d090b831c513d726b11a412b70aab09:
> 
>   ARM: imx: fix dependencies on imx7ulp (2018-12-11 10:41:20 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC changes for 4.21:
>  - An improvement on i.MX debugging options that only defines
>    DEBUG_IMX_UART_PORT if needed, so that the option will not be present
>    in the kernel config when DEBUG_LL is disabled.
>  - Adds the necessary platform support for i.MX7ULP SoC and configures
>    power mode to Partial Stop mode 3 with system/bus clock enabled.
>    Otherwise the default STOP mode will gate off system/bus clock when
>    WFI gets executed on i.MX7ULP.
>  - A fix from Arnd on SOC_IMX7ULP option dependency.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
