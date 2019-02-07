Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1501A2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cSJlbjxb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWYF90HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1501A2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nn2h5F/VD0RYdoX3/ymXM20ArZ1ugVRiPx9Ftp59/lQ=; b=cSJlbjxbEbFUSM
	0+t4+aN9XnYucRyAjHTVMx6x1Q5V9PUlYYEZCaK0fthurBnpswCLcssOwwY9aFhN47XaRJ/twV2tc
	CCmK6Dp9yN3rTdivnjypqw28+db/xKtiERHtTy/Esto36883JqndO0si40N1tIA7s9KGMqTI75imR
	KNc6/+7RZi23IrEs/P8VSnChevNPuef4lPYs79cNylD4497AWY4UtIdASUEvydxqxSO/IsYccttBR
	qZfhigi3q/59wXDXgPWUuPktj/12AKQKeeBrCzHp/VkVLgjPihiU5ki74oABSZWNafzyiiRWPmGl+
	6n76W+m8o4iRxc/PdhCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkYa-0000An-Ex; Thu, 07 Feb 2019 14:21:36 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkYX-0000AR-6x
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:21:34 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so21657wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gz2dPntIwgNYepmZg5UEJH0ebbq1Vw9WirU9NneIHWE=;
 b=BWYF90HK1l3yNFv0M4SA9VIcu9Ul2U3Y/J6A3uMg1VNT/AFu60W99A4GrvuLVP6wJI
 3IGaCKBhCHnZl7IaYV2S9FAQiLinTwOwrbFIh954BNQGDI9YZcDp/zDbVLLFpPkV0lPV
 y55TDENE+cEYQq1Zfp0+fWliWLe6o2iCbDhtQs7ZavBYDyAYcAW9YzD17S4CG5ULNptb
 i3H6ZtfJBn2K3zTzFpAMaz/bZjxma9OIE+v0pHWmlh8AJLO5nCxgqLwOqHU7p5M/W/xH
 wBcJ09m4SwK79+I14pue3Tcg+UnvRINmXtmCy16Ji/r6TpannFmIxmiOvSQjbFSJVrCF
 p+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gz2dPntIwgNYepmZg5UEJH0ebbq1Vw9WirU9NneIHWE=;
 b=Y2oVDJ6w4156fP/oDxepdl+vChAkVEjv85qyoS+l1Fyeen4bBywEjy0V57q2BAq0KA
 hB6PlmouG4pFtX/Y7Q7KWMlCzD6Y6Gjl3tcz5cK+hsDDsfi8V/rZLpJKt4xiVeZ61CtW
 ZR0ibjCnhbIZ/yBbokyJvWeVu2tKJAwvrlt2iYovPF8O0Prfqw6Fs17NjY8L1pH+BbTY
 kFHRJpMC+6kS4O5ofx3Ii/9pqEy9wZHndi2j1xio+eTXDz62qO+A1dtV6fOgg38nA9c5
 8TFPP6f1rm6MBQ94kX+A+F6Vu0L/31RQOYYrwEWEOXwDyuaVxp2Tw3xiMhiDKAX1yDI+
 it4Q==
X-Gm-Message-State: AHQUAuayRIFuSLItW8ZesGWNhwMQxy14QuvUe4ciJq+K+E8AGH6D9+rF
 IEh7fhZTfX2+bYiS3u3BKrgvKg==
X-Google-Smtp-Source: AHgI3IbyNn6jHLOmwmrqSWwF69QL8KRFYNT79r1quOGgvIBj4O21mSqu3Htj3rovHnqsrRqMUIrXTQ==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr7479890wml.96.1549549291195; 
 Thu, 07 Feb 2019 06:21:31 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id f187sm21405314wma.4.2019.02.07.06.21.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 06:21:29 -0800 (PST)
Date: Thu, 7 Feb 2019 14:21:27 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v10 00/25] arm64: provide pseudo NMI with GICv3
Message-ID: <20190207142127.he2vbe4ts5fmhtmy@holly.lan>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206102706.GA92291@C02TF0J2HF1T.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_062133_313650_2B10A2DC 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
 marc.zyngier@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 10:27:07AM +0000, Catalin Marinas wrote:
> Hi Julien,
> 
> On Thu, Jan 31, 2019 at 02:58:38PM +0000, Julien Thierry wrote:
> > This series is a continuation of the work started by Daniel [1]. The goal
> > is to use GICv3 interrupt priorities to simulate an NMI.
> > 
> > The patches depend on the core API for NMIs patches [2]. Both series can
> > be found on this branch:
> > git clone http://linux-arm.org/linux-jt.git -b v5.0-pseudo-nmi
> 
> I queued these patches in the arm64 for-next/core, on top of Marc's
> generic-nmi branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms irq/generic-nmi
> 
> I'll push the changes out later today, once my tests finished.
> 
> Thanks for pushing this series through.

Absolutely! Very excited to see you carry it so far.


Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
