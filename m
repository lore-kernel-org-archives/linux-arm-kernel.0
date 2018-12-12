Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43165C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7D32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RvpEbDM0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="d3K1sRTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7D32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DC2Yuk/RlUvUTQWDzWtBm9YSu387915qdrHXoRBFdj4=; b=RvpEbDM08wKB5F
	6i0BkzDW5StBm+w02K7h8xm207at5JlUQv284QpLGSNtWHtvBTfj270zK9K8sQARTIalUywYz137G
	DKR1clCXbbuKv4tc2Er0tRhjkcyi7zJ0i9T0+JMtuUGCF66C7KkVTywAFzd4Uq6gzptopl85Xjnrd
	VOJgl0U7IyfLiftJg2XPadxrNWCvxZS+vHqxsZQBFH4sbH23CoL6WPpH25E30Y5j7L4REFEJhBJzN
	5D3VMij5Mq6JOuuUcSYetH+wDExysh20jQ4At+fi/GFJYSm2WSbNXZnf38IyM3V6EDN7MBThMXAfa
	cz1SDA4kLM5yA5AHfmIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBsS-0008Kx-K5; Wed, 12 Dec 2018 21:17:08 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqY-000550-HO
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:16 +0000
Received: by mail-lf1-x142.google.com with SMTP id p86so14667714lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g3mXTzLlfEusF4WbH4LRlSZ+/UrqTtzfH9QNeZZK6gc=;
 b=d3K1sRTHhFU92mE0toTi/XAHSGy+uTSLTQshyn2CNFbvNUq0lORdawPpxAYkEtyeyQ
 wpanA7zKc/z7V0QbOGdHjm2szrMrOWKpdEGCbmsB4gl8fHXyTKfIuUBULqkh7j1Sdd1Y
 LDxkwY5lARde+9xI58yWhBR97QH5Cb9baLsy0TpttA/2Wi+zJ2AW5I3SYyQWZMRrtGIR
 xg//Hg7iRTe+niIXNxBBq7GWICt1R7BTPoIkhXxW13LXhJek/hluez01VRqklRkqD/7r
 4nKroOfIhAccanYqsovn4fIN2Duh4VVmELC/mYiPeV1lzDzkDzcCG0dh2mwxgXNaIg5l
 DdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g3mXTzLlfEusF4WbH4LRlSZ+/UrqTtzfH9QNeZZK6gc=;
 b=rv5Jl+k7A/HKSFTvHW0dBi0X5o1MCmeV6v7jlLpq7hNW3fvRw7tdQij8U2kxaSRp5f
 ybmchDhy5X8pvhf4hL7zsJve+ODZ7q5Vqah3w6/00OKyqRrGmxrx3ElconzQXlL+QSGQ
 tMjBkIfCsBAlajGqH3bXapE+B9DV0LrcaYPKvrNXfIXQ6yEw8Efp+62d/fXH8E6dd51u
 ti1RLvXJbucsP7WFqfL29QRYDP9eaMBh33PIZdRhFHGc5QoRwK5Vgm+xhZU8MPNLE1hR
 mSg9ERf6gHucgkJdumXDzkK8QX6ED9ORHqSTG3HDEcVx2/OzbJ9DymnvDTrOSphB7f07
 x9BA==
X-Gm-Message-State: AA+aEWbvnEt8p82p6uY1VIp03kqF4wK5PvqZvcdKiQCyYsnR+MDyFQXi
 Ni1+CVoRXN6Gb3pbmb7t2Ei1exw7fWzvRg==
X-Google-Smtp-Source: AFSGD/X9fIAgoAjO9RA93Bv1vlekafqbgBx2Cib7CO+vT7jbmJLq7bufuvaJG06WYyjRKGTU5BtjSg==
X-Received: by 2002:a19:518d:: with SMTP id g13mr12301839lfl.143.1544649302893; 
 Wed, 12 Dec 2018 13:15:02 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k11-v6sm3497960ljk.40.2018.12.12.13.15.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:01 -0800 (PST)
Date: Wed, 12 Dec 2018 12:56:14 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 4/7] i.MX7D PICO boards device tree update for 4.21
Message-ID: <20181212205614.nrm6grsq4xroxmz7@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-4-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-4-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131510_863055_5736D657 
X-CRM114-Status: GOOD (  17.71  )
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

On Mon, Dec 10, 2018 at 03:46:35PM +0800, Shawn Guo wrote:
> Hi,
> 
> I need to send this patch series as a separate branch/pull-request
> instead of just as part of imx-dt-4.21, because it's based on a patch
> on imx-fixes-4.20-3 (ARM: dts: imx7d-pico: Describe the Wifi clock),
> which has been pulled by Olof.
> 
> In short, this pull-request is based on a merge of imx-dt-4.21 and
> imx-fixes-4.20-3.  Please consider to pull, thanks.

That's fine -- you could also have merged the fixes branch into your main DT
branch if you wanted to, but this works well too.

> 
> Shawn
> 
> 
> The following changes since commit 2e8566106d284badf6ec94509f77fdf7725d04b4:
> 
>   Merge tag 'imx-fixes-4.20-3' into imx7d/pico (2018-12-10 10:32:51 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx7d-pico-4.21
> 
> for you to fetch changes up to 7f68ffe0617b44fe189271701f6443beb23907ad:
> 
>   ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant (2018-12-10 10:33:36 +0800)
> 
> ----------------------------------------------------------------
> i.MX7D PICO boards update for 4.21:
>  - It contains a series from Otavio Salvador that improves i.MX7D PICO
>   SoM, and then adds Hobbit baseboard support on top of the improvement.

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
