Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56AFC2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gi8xvbpS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZdsqXMa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AFC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uDVYTWGcRRMKfgtnPwkGl+yJO1f/bk/C5jxgcONIDhs=; b=Gi8xvbpS2+CAvW
	IIieBCJHbKFHuJUQgd4s347LV5gWu/kW4SeXiRvToPRWkiN2w1If5Ljp3HL2OI5hXJzbq8tlp6/I/
	S+OLgMLwf7Ay6jrAIaiCufdu0FYXt1AqSrQNuEeYJCRj3mO8wWqXO55T8LhVcTovxGuxJGgwKwJHb
	A5LhCWq2onSSCHGYkLeNjwrUWbqJOHxwMbQ0I/HUvo7C2L+vHiJu6BLQ2PNRZ89tc3BkiGfZLnmZ/
	FGloG2vC/8rv9XORXeBUPSy6vUoTEH0EPSx1PFWhT3ru+XaT1ts+oYYl6WnwLPusK33DCfxwzkv4f
	zbC2zb5ImrDtOE9TqlLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKrw-0005Th-Gs; Thu, 13 Dec 2018 06:53:12 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqe-00048x-Hl
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:55 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so784291ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O7gdbVA269HOE3Wf1R3qu159FiwaixM6OJOLHRAtKsA=;
 b=ZdsqXMa5Wl5e7hIP+GqqOJFUsvhsFWX80S5sC5EJYHFZpRUjXgVWd5Wc2KpTRrWTAt
 GWhnvStyn7POns5BiOFLOpzm1uZNhXn0xkpgSg7gKgQjPmnyhb+ucspFXSSNyQhH53Hn
 sqjuluYXSffgHQuA37RyffmNfh2nHckFA870/Drd6UFrIZxQLta7tBdgRerBbDOtATSc
 /1PWYITGc8azXOcAbobf2KYReuhpTvv7RpV7+Xkmi0/48cB66Rx6nAgafJUxViwabYBU
 pHKZdT/v2PTWWXPGPy4KzV/ny8Vq0Wr1w5o2sryG4gcTdADfsFiuDO968JnlJ5qfLYMb
 A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O7gdbVA269HOE3Wf1R3qu159FiwaixM6OJOLHRAtKsA=;
 b=PD/nr9n9OXIQwpnaP22ZwCJiysNbBoFPXNuChn0bKpyzqf/XXH9KWLdEpeDhuFyrPf
 TI/b5SECdGirFvqD2XqG07MG7GpBMG9TWAwRAuW5SXvSs+2E8XuDNkMjjluG/ya3QTVk
 G+ce82Nq8YjZchmVZtD7g5yE6LJv5ftAcN6wTjnTe1e7yaHDO2RbdoHkvHlUxjhsBchK
 H3QR3D1NIXLwOA+CCGL9ywK00qK4HlXAsiHpwmWURh3wdmVXAjY5I8R1JWCtsNrtty7L
 HNiECG+1kyaEArhcbX4qOgXnBAE3lDW7psaxpFQ5O5R9eaWW5MlCAKIfVE8DeEYY73KT
 pfcw==
X-Gm-Message-State: AA+aEWZewaJhlJ0ErV5Kvfs3SC0Rmny2MCY5e5CG1u2bwWKE6DrEhNkb
 vpAPugRgSUoUzDEa8eXkqTxnyw==
X-Google-Smtp-Source: AFSGD/W4pIXTG/eKWM+tMGPqcBZpWzHhrbfqL7JljT666tcMJHFyRcLSBTmGpoXMl4d6IvRXGh3e0g==
X-Received: by 2002:a2e:8007:: with SMTP id
 j7-v6mr14093866ljg.22.1544683905475; 
 Wed, 12 Dec 2018 22:51:45 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id i75sm176942lfb.58.2018.12.12.22.51.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:44 -0800 (PST)
Date: Wed, 12 Dec 2018 22:50:25 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 9/9] arm64: defconfig: Drop redundant sound codec
 options
Message-ID: <20181213065025.3j5gximuyormpbct@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <a285bc62-bfaa-d53a-129b-165df255b3ed@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a285bc62-bfaa-d53a-129b-165df255b3ed@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225152_813651_FA172129 
X-CRM114-Status: GOOD (  11.00  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:08:41AM +0100, Marc Gonzalez wrote:
> SND_SOC_RK3399_GRU_SOUND selects SND_SOC_DA7219, SND_SOC_MAX98357A,
> SND_SOC_RT5514, SND_SOC_RT5514_SPI.
> 
> SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_RT5645.
> 
> SND_SOC_RL6231 is pulled in for SND_SOC_RT5514 and SND_SOC_RT5645.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 6 ------
>  1 file changed, 6 deletions(-)

Also covered by patch 1.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
