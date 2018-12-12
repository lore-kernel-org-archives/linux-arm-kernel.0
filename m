Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4A4C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5342084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ki4FSLZc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Gc9ZAeMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5342084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XhV8RfVZ1JohxGGHtu6BzY4M8p//HvML+gc7X6ka8NI=; b=ki4FSLZcEMSeSx
	oO+wAzj9+itwrVmcc8ndfp2W84cecDVJyvxAeBTSpvYlCWXBhwDV9V4hH36ScJa4FYQyVji0GWL2L
	K5VWeS/bOcSWRcNvhsdwigOco2iPSBBZfuKpfOArS4WwBGTdXAW1LzO9Twff/pDChQGYKpsyof+Tn
	Luy0GeqqsXZNBuaIDpsNX2wRS8giE6eqmjuxV/Vpj/D/SgwmrG0Os4/qSrUemmLZpemqWNMRaVI5F
	FaRWE+5AboFYdsRMrvxk1mNDOEaaI3rIqGxZf7L9+o747lDNGKzaxOu6naFj5usssGTbairD3DX+l
	//1fqeCR1kU3XRGpto5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCqT-0001J4-V4; Wed, 12 Dec 2018 22:19:09 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnR-0006FB-Ce
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:29 +0000
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so17719497lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1s471tMLCKnuzE2Rxbwk57tYy+K0xvZTG+xB5NmBJ2o=;
 b=Gc9ZAeMl6N69mbpkCZQyzhMoLxKwmeCbfjB0Fc/zv9NKCm29SkMIngvPA60QR4yzTo
 uJJPaVg03nIPqW214XqMoVNMWsdQ0rBGFvJ6gs0DfBha9iQfeE+TXCe1d6MZa8CTl9hW
 FyjURV14/qvxd2lFC1JcN/rTusxMf6KbxQxdCiHPBr0Fvnm9uH1BcSFWv2s73OirPht/
 ygXQa7zTAw+1ZrIRMqw517LuC0k7RjxVGs95bzPLMghzG85IZPBetjGvWmswYBjnrMO3
 RLt063kY5wcLpB/CQJSMVl2UmCASZXe2/KA6M29gPLbO9xR16bU6mcuqEFYTN13R/lPg
 KYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1s471tMLCKnuzE2Rxbwk57tYy+K0xvZTG+xB5NmBJ2o=;
 b=OpAvKi75qcGzRaBmOgL8vk3PeqjfS8FKPXAroSLqEtlJIzJQCpAzhnoiBrhaFWZE4x
 IDQ9xxcQyrLyLyyxubioViBESdeJGmKDoQDAdfkEmqPLB7QGdzf1KeoIPHc0lvPsOzBu
 1TEiltX1iME6RD361iTbfLoTGPTPO3jHCEi1blV8QaA+BW+wYayTZ55FjqlgfqX3OJvb
 CWzq7KrjCvzQrpzuqOcij6Rplb6iaWCfgyadqlIx5CBnQfTklPhaygi6VO8Q+gq56m6x
 9A1gKK59gYek/z8HKkthM8DxAfWM46r76EVvT8ruauP6hbqF5OrgLxh5lSU0X0FydQhU
 2PUA==
X-Gm-Message-State: AA+aEWa40f/5kEUarKF8SB9cxaskr5S3VPDLsylmm4OnUzGPBR6vXUgp
 EZ9Lph2OS8nU3j9w8DE1T8wZsg==
X-Google-Smtp-Source: AFSGD/V2dd1BGPTymzBNiWxyZPCRJmIRLzNdveOLoNwfotrxlmigLW5BioJ0wQyR2ZXM8dsHaAZWLw==
X-Received: by 2002:a2e:95c6:: with SMTP id
 y6-v6mr13002185ljh.59.1544652949412; 
 Wed, 12 Dec 2018 14:15:49 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 6sm3846lfa.27.2018.12.12.14.15.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:46 -0800 (PST)
Date: Wed, 12 Dec 2018 13:32:40 -0800
From: Olof Johansson <olof@lixom.net>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [GIT PULL] soc: mediatek: SoC driver changes for v4.21
Message-ID: <20181212213240.uvquddiznmnufumv@localhost>
References: <123d92d6-2cee-cae7-42e6-77aabda91038@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <123d92d6-2cee-cae7-42e6-77aabda91038@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141601_774067_ABD22FEA 
X-CRM114-Status: GOOD (  15.74  )
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

On Sun, Dec 09, 2018 at 11:08:56PM +0100, Matthias Brugger wrote:
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
> tags/v4.20-next-soc
> 
> for you to fetch changes up to 576f1b4bc80220e1f88f1de5ecb25d99a6e9fa04:
> 
>   soc: mediatek: Add Mediatek CMDQ helper (2018-12-02 20:46:10 +0100)
> 
> ----------------------------------------------------------------
> add helper functions to create and send commands to
> the global command engine (GCE) device using the
> command queue driver (cmdq).

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
