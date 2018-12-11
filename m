Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB9EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E832084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cN3KRyZz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zqP+57oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E832084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yd9V0HsapnkrPdVXVLVDL8dzycI1uPS1p6rEek0YKTM=; b=cN3KRyZzQYBuiz
	ovfIc1il4M7atQr8MDmWgowAQecUsuNb77MX4PKgXdv+bb3eIlmDZyrnb5PmYaEWtHo60voONuPJs
	ILk54bYeIRftB6YEdlbp6wsxIwb5om85+y3t0nzSfgmC+1T4OL/XJRLrzQvcwbl6YKyRIOBBrq4C/
	2xEUrgH7DezXFFmj0fe6+JszBP3ghHVm6BaqofJZo1TGS5zFbHuRPw3xx2tkz8nSaIDlg+odHQS18
	0Y+vunhhnywpmglbsNZb4v4wwjN4iLSDLPpNJEzg60JsCxoXbEN5KxWQebx/gOhyIFaopaLAcuq8d
	GIctVyOrCfZv2VQVQrOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkfr-0006dc-NU; Tue, 11 Dec 2018 16:14:19 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkeL-0004VK-7H
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:47 +0000
Received: by mail-lj1-x242.google.com with SMTP id n18-v6so13466593lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hJ9a8OcNiQ+4Mfr457YX9N9jcqeXlrjHTJ3tGWX1bl8=;
 b=zqP+57oZ1HwRRsGagRJuJ077uMCeAkVBl54v1xqSfSRvn/2IAtaJMZlJr8czNKqSVT
 tglpOjZ+OoNxJPNoMiLlXdzplkNbw3DCEkajQXRwABrKtghcslHw7Hlrk0ga1ums4ZpX
 yv/kw09yhFDESDWRwUOCSi5WJgdjqddRGnrp83zKKl4uFEa1/xP0yugwokrTJ68aKdvu
 yt5CCSDFlyTvMEZ6lb7pe+sQwn+bSqWv3wzZVC68kO2kj21AYIfoH5cGjgJCXF5AU1FE
 Lsmt9nU5cw0FCk05h6/fP6cZif7dgXaCbjIV2X6bijUao5RMhzrSJDXMwuo51oNCilJH
 WvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hJ9a8OcNiQ+4Mfr457YX9N9jcqeXlrjHTJ3tGWX1bl8=;
 b=FfKq3/WqJkso+1Gh7rwNoMBIo8SjRDV4B4igAy8lUEk1XZ+BfGqEVcj0YJsF7I3/rs
 PyOYc0v94UPPUFcx3MjfTsVSrP/+zYOSLfed4+8YNMhmhz1AO/2+/DPrb0YpUGGmIA+Q
 h/6aQ/UMYomqggQdc4kQeqE21SYwKzuiyDXpe+0FByFZNSRmF116U5UhyToUogaUb9mC
 BelQvjX76czG1FtCOfC76izOm34iV8YV+qLyKxO8fUGdyz/Akm5EbQPyar+N7GwWdSP+
 hdlYMloLG33MlClg6vdvz34YNDTVF6/7wt82YhKSg3terTC3vgwCz7tqWWT6Pnrg9gmx
 6dPQ==
X-Gm-Message-State: AA+aEWZxlfpoOh3UwAYirF+PowpKh3fvppUd03yLfe9jV+aH7fWQoF4F
 AiGyl93KT17l+l4Qg7QFzT6xuA==
X-Google-Smtp-Source: AFSGD/Vee6MwQF1/3NYDT2Eq58985vkc8A2TaGSBsBJ/tc6tVzfKbQQ44+sLLOCjHksD16DZRqNZ9w==
X-Received: by 2002:a2e:20f:: with SMTP id
 15-v6mr10433747ljc.172.1544544753444; 
 Tue, 11 Dec 2018 08:12:33 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b21sm2738514lfi.7.2018.12.11.08.12.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:32 -0800 (PST)
Date: Tue, 11 Dec 2018 08:07:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL 5/6] ARM: tegra: Device tree changes for v4.21-rc1
Message-ID: <20181211160755.ghx5zvunabc6pjad@localhost>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
 <20181207141739.9085-5-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141739.9085-5-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081245_263557_1D43EC2F 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: linux-tegra@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:17:38PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-arm-dt
> 
> for you to fetch changes up to 3dde5a2342cd204df15b6b0b90ee0ed4542225ca:
> 
>   ARM: tegra: Add VIC on Tegra124 (2018-11-29 17:07:31 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree changes for v4.21-rc1
> 
> These changes add the external memory controller on Tegra20 as well as
> the VIC on Tegra124.
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (2):
>       ARM: dts: tegra20: Add interrupt entry to External Memory Controller
>       ARM: dts: tegra20: Add clock entry to External Memory Controller
> 
> Thierry Reding (1):
>       ARM: tegra: Add VIC on Tegra124

Another small nit about consistent prefixes (ARM: dts: ...).

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
