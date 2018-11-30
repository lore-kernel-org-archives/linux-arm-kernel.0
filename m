Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:57:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECF220834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NO6Liniy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CMP08eMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECF220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rxBKmLhNJIGij1OkAV17m8/Ak7zio5W/fIyoXFRx8JE=; b=NO6LiniyKZnmrY
	MaDcNvD+F25nMdCq7wRYLIwOnN+o0ArlZgdDcLjxpyfypbZ4Mcwua1VhDt9WqqsQPwQaV8hB6nHnE
	Rx+KPpZsKXEg94L+gRZL02OwScJv0NNYHPsv4yEtuhcU00LpeavNfSgnam44zoPfcXiCVLmn2CFL4
	LJ2UMhsHIoBzBvXUIjZuxlngmxlX9U1IBsV5LVMz46j5TKmCNVf2d9DWnNyJ1jNHSAXvi9NY7jra/
	FpOuPGr25R4rPzUtYq2QWWbc06Ltx3shqZmz9VBfgoUNeIT9vnvTXES31fl5qEYt5v/G8+lBbF6tz
	0aNUA4yusFNp9oRNf8ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrjC-0004VU-IG; Fri, 30 Nov 2018 22:57:42 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriA-0003vA-K9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:42 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so5280519lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CRaczM14x8jN2CGA32OyRSnI3OnYrZYJ8H64Fo/XgsY=;
 b=CMP08eMG1ImxNQPqDq6Dz1EVM6Gn69gv14Orf1Cp9uUyfGOcJxwrje5SQrueUWQ40f
 SfYoPSBYk4+HG9UzDLiZiFKholiBpLJBLtG6S2HCp2jMI8a4XTpurG5XOVcinvQIkj3X
 JbefcIF5uBrLxF0rPDIGXzI67l4Eu1JXpRQgbaAH5LJ7fCVOAHPWd7DiNi6/ByCyWOe7
 02m0kKTce0hMp6Oy+bRXF8fVWZlaWuSQr/VUVnHNNe36OKDlDWVZqwvx4nWUdJMCX8lJ
 hoPltMmRGie/qv1ULtFIjJ6+dj4fdT04Mci70mdv5hkOBc92lHGpuihSXHcdlaX5PNHI
 RcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CRaczM14x8jN2CGA32OyRSnI3OnYrZYJ8H64Fo/XgsY=;
 b=cVKtb+b7yDM1vcW6k7/B31P8+eRzkzc6M7yaTFM4xXn5pAPWru5u4rg/IM55Hlzy7t
 iD9/BwsivIiqbYPIRyY4gufFpqW2CG7r/hvecifMm4kN4Xx9xfeipNe5iPARbl78Jxgg
 lV1py0WxOQsPPZqdrfkWfNDrYwmCuC2x5gQRfyo2onn+GaLwk0SlBfkW5KfiN8MTEqw/
 yBkC7yFM6aeAQ9a/LuPwwobryekwITy0g3utiJpo0o/DwKn4ZPh0n+d8y2szwtNUvWsY
 FpzQB+8C2jcuAbj/c2XEjHfOK5jARuWmDjOEU28UL1e7M8X24YFSfpSOyqFHAAtaASgi
 XjdQ==
X-Gm-Message-State: AA+aEWb6JiS0xsC16eLWgUIW7DsnuZatS7/IahOAAwjUubfkaUPyFu8S
 PJvdcZMi/t/E4IusPJtBro2/3w==
X-Google-Smtp-Source: AFSGD/Xytu2S9QiwctTNlf6nYW5Fpz9uarqPX9iu2oP71QRDFwBrfFMWbIxHXuBNsUWhpOTpRJYEeQ==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr4465906lfb.76.1543618586569; 
 Fri, 30 Nov 2018 14:56:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k68-v6sm1013616ljb.35.2018.11.30.14.56.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:25 -0800 (PST)
Date: Fri, 30 Nov 2018 11:49:19 -0800
From: Olof Johansson <olof@lixom.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [GIT PULL] ARM: at91: fixes for 4.20
Message-ID: <20181130194919.rah6fxh6jcaiadea@localhost>
References: <20181121111623.GA10372@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181121111623.GA10372@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145638_853541_72BC5BA2 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 12:16:23PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> A simple DT fix that is necessary to get reliable access to the NAND on
> sama5d2 based boards.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-fixes
> 
> for you to fetch changes up to 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> 
>   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
