Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F8C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C665A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dZxoJ2r/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iR7xO6Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wjx7XNR3yg8+6SeS4O3P6JcfaVOuQs8muqXI8g4v2WU=; b=dZxoJ2r/h5IuHr
	FBFPjOjQEjxLsYVyUkPCFPwQ2NXIq7ye/fj3mGFm1/CDZpuzgIZYZ61/sD6C8efCwH+1jMBTw43Sg
	fqiLFFv9PHJStfsAcIuwrKwEW/V8JNhDqWhCcL5SvFbZt5mx5qWeMlSBb+e1hAy1pEf6wKzXVJXSz
	RAzhutObAb3MQMnGh+5lEaymMQRoo80I6UXZWLmxyGAc/t+l9+rcYROn0o7gapYi5IscOdwkwx16E
	BiWpNixwwu1FuzLLXeNCVdUbtXiiDcLWMMKeIkkDqZsdke8uxUYQT/GEr4N0QaK7276WHMU/gwbS+
	tiwyDdZr/yE5TeBXLRrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkeN-0004hW-EG; Tue, 11 Dec 2018 16:12:47 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkdz-0004KM-3q
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:24 +0000
Received: by mail-lf1-x141.google.com with SMTP id p6so11217244lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XcMmZDcuTqcuMsOwhKgHSKS/53boXd+a8dFm23kzE0w=;
 b=iR7xO6KjYlu9g5aAltSf1n8E37ftAPJ8R43m9d0dirl8cUlq6Bi1Sm4x6BT2iMzYVL
 9J6jyP8gyCOxKAiAd6dPxzpQQXYp48zPdmid21R07ky/9MQyTZLRYR2RDVOCXZtvky8N
 1osDsnKzOZAPA/SmEBDQ9h6vYhV1JZIwJ2ibwNOq9YxnuELbwh15PlFp9Ax+7/1QUu5D
 1JjZU63CI1iXluaOo3uXBL0uyq4t8ZZzckogxeiPTG7GpaNH763NFlOD4tTvWCgYo9qn
 tGSHqHnRETA3Z63YUy5HFLnG96TA5dWLmcLC8BA79eHt/xw5xVW6XiQo5kYOGuh56OI7
 svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XcMmZDcuTqcuMsOwhKgHSKS/53boXd+a8dFm23kzE0w=;
 b=j7o+99Se4iKstqU1cefyq0Q0oznMIXlxOB2WHJfDk9Xunse8n2EVEljikLYSb4oPEW
 2pDh9QipwWU8AACrsgj/jQPekmGz6yrJurMQWimczZrjLl5iNT6tgEpMH5BpDdcZg/Ch
 K+ncM/KT+KfAyNzH+1XI+UCOx5VaqW/j4S6iVyp/Hp3YS6dc86I50O4lBKyrrMjzIj0D
 hcZ77CBkhY9GDYjAhQjMDcnG5KT+8fatSW/1Jyyo9i5WbCzOOmY7iSteD67kxXAdlMVD
 UdRtXO2MmcENA3NT/eYqFl0sTmy9EKSL706FWXkjrv99XReteyVY5JTQI+yof5/D1pBx
 xlng==
X-Gm-Message-State: AA+aEWbI98h6VpZ1uTL7HkUYZXgPKxne1rTxKt4a0fRP0GpvvRr8ed9i
 ACquneW9lpYKPk2z+BAaRn5hOz2lQorpHw==
X-Google-Smtp-Source: AFSGD/V1XRQK4rFa9ph5XxyirZb5Wp5LYBbumockd6O+A/j/2na462KPEyDZG0ivIbv1/wXUOlZq4w==
X-Received: by 2002:a19:5782:: with SMTP id l124mr231769lfb.91.1544544731114; 
 Tue, 11 Dec 2018 08:12:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p23sm2721768lfh.47.2018.12.11.08.12.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:09 -0800 (PST)
Date: Tue, 11 Dec 2018 07:41:59 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <20181211154159.54yaytbp4pyjqjhg@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081223_151016_8BCF2872 
X-CRM114-Status: GOOD (  17.09  )
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

On Wed, Dec 05, 2018 at 04:33:37PM +0100, Marc Gonzalez wrote:
> On 09/11/2018 01:54, Marc Gonzalez wrote:
> 
> > Hello ARM maintainers,
> > 
> > v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> > 
> > v2: Improve commit message for a few patches
> > 
> > The set of Kconfig options slowly changes with every kernel version.
> > This patch series regenerates the arm64 defconfig for v4.20
> > No functional change intended, except adding PINCTRL_MTK_MOORE to
> > keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> > keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> > 
> > Marc Gonzalez (9):
> >   arm64: defconfig: Regenerate for v4.20
> >   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
> >   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
> >   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
> >   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
> >   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
> >   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
> >   arm64: defconfig: Change SCSI_UFS_HISI=m
> >   arm64: defconfig: Drop redundant sound codec options
> > 
> >  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
> >  1 file changed, 49 insertions(+), 59 deletions(-)
> 
> Arnd, Olof,
> 
> Would you take this series for 4.21-rc1?

Hi,

Yeah, I'm happy to look at applying it but will do it towards the end of the
staging of new contents so we don't get too much conflicts with pull requests
that come in.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
