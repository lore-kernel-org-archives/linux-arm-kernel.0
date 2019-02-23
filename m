Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6633DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:13:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3866B206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RGmm0PK3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ish/Whc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3866B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GrVVPCaCCiIjW22zz3IgAOIzaPmdTTEwaD5KwKPoiQg=; b=RGmm0PK3OrU5fN
	bz5OfuWBGZ6Ji/tTjjp4onwh4Y+18UQb/WBFj0czvW7AjsM4yV5PlbTOBRO8F3QplD+49xvo9YY1m
	uFZbE34U+kIDWs3akc85CLA/Xd56FB8lm9+mAHWbBNYXYF4NT+wF7iReZ4N8OLdL3NNXqo20LYyrx
	ptXw9Dz2CTLm/XQHbAxwiP8ijRY3X+fgKPEX7KAAU1m62jf8j2+wrL7hzSFpfU+myXFqV3yqFy6sG
	4pECpVTcelblqcsJUTpCNlVkMpaP3T/Ed5rTroiQPT/ifq5uLCBCcUhS++ygvUQ6dzHmJK7SFAWlb
	S+KoVGMzaOEYFghhAmZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxbnL-0006d2-Mf; Sat, 23 Feb 2019 18:13:03 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxbnH-0006cj-GC
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 18:13:01 +0000
Received: by mail-pg1-x543.google.com with SMTP id r124so2589069pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sP2935QBF/NPe/dZl0b3jMUepOEvY0BXuyW5CtqjJYY=;
 b=ish/Whc1Uksx8dBz3VqzoVh2s+wScJoP6At1+b4uZ8YmHcmeTzmX/q4wrooejlZgCS
 crkDydtgaUhe7IqU7JRSXSvP/6IfLD0HqyJFSYu3Gwg7lN+fGEQLZo9El0nOBgKLX/qf
 D6yRQB8j6oVdc6rgQFHiSpnF95/Ai1K/NjPCPJFgq838E0h16Xg08MMa97VlXzSx4gbR
 dknAVFmaJ4vxaQQhUAP+uc6gyLBl3p/+Idy4YCKBgNCsFAKXPJ5QdlDFLKDsumvX6EDp
 aMUiC329UwJkhgmIe8R04lda4FRblRNoNxVBF64NhZJN3vHRZpjqJiD28J7BoIaMovXx
 jEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sP2935QBF/NPe/dZl0b3jMUepOEvY0BXuyW5CtqjJYY=;
 b=WX2mn1W5tUYzRM2TckQeDDgREyLEra7KwhRtsvW1wNCaZozmRwSS5QGMmUhMyZzCDr
 RYT+uAKlNIpOSbkGKZIBXH0U4baG72hO+T+Pg/hV6/Je/jp5kE22mROoEEr2eF5sAqwU
 Q2QJUfnxiqYd/vp7r9XROvGqWBEwnAwNMgqW5TimkX1Y3gGeoE3hRSITc+T9Argrblnh
 E8/ydFRqX8N68TAAz+DHrdR8su68sLDxNWBD9uMh/5DJIOjgB6UZOn5BqUMBN9XCyA0o
 4NEoRWmXKyiN2z0QSS2jwkSPpSJiqXt3Mo/qCTI4frTBowJLc/puBr0ti8tDSGlGi5ld
 /0Gw==
X-Gm-Message-State: AHQUAua4ut7s1aYF2TaJswwOD7va68aO5d9BOD+1kmAmcS5t8BZ0Yh+8
 JB2rd3ui/QpKo/YxvKUmtH+dyQ==
X-Google-Smtp-Source: AHgI3IbAS/S9+F0oHH7L73VSDLX0ekSAgY9OlDLt7Ph74abIEtyLbB6C/dCo1voZOkzoWQpEK5/BCA==
X-Received: by 2002:a62:1854:: with SMTP id 81mr8061925pfy.223.1550945578134; 
 Sat, 23 Feb 2019 10:12:58 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id y133sm7417361pfb.107.2019.02.23.10.12.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Feb 2019 10:12:56 -0800 (PST)
Date: Sat, 23 Feb 2019 10:12:54 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190223181254.GC572@tuxbook-pro>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_101259_550255_9327DA9A 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, AngeloGioacchino Del Regno <kholk11@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:

> On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> 
> [...]
> 
> > Also, just one more thing: yes this thing is going ARM64-wide and
> > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > I'm not sure that only QC is affected by that, others may as well
> > have the same stupid bug.
> > 
> 
> At the moment, only QC SoCs seem to be affected, probably because
> everyone else has debugged their hypervisor (or most likely doesn't
> bother with shipping one).
> 
> In all honesty, we need some information from QC here: which SoCs are
> affected, what is the exact nature of the bug, can it be triggered from
> EL0. Randomly papering over symptoms is not something I really like
> doing, and is likely to generate problems on unaffected systems.
> 

The bug at hand is that the XZR is not deemed a valid source in the
virtualization of the SMMU registers. It was identified and fixed for
all platforms that are shipping kernels based on v4.9 or later.

As such Angelo's list of affected platforms covers the high-profile
ones. In particular MSM8996 and MSM8998 is getting pretty good support
upstream, if we can figure out a way around this issue.

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
