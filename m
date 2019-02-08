Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E948C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:14:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F7C21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gK/NEJkF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQHVF7X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F7C21916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z0vLZiOwloLT5DIxIY243h6ToQZV6UvkcSj/Zdol0/E=; b=gK/NEJkFESyGhY
	kPu7e1eSZSeaRnwNGsTzpOJaNkdzO6wbj3uPUor0G+F43bOx4CNkG1tyG0w88l0HUu2V/Azhw9l8G
	fVBhoByRT5RgT+HCo+/8/UHrX/mtdXPcHK4loqrRIGAYkzAb4pgsT0ZOWNpMSs/JYhC5j9P9m88rt
	/RbAhLMnI8JyV8tU+cEAyx8rf+GYLh3lxgVO0COeqkznRJ5Af4iH7d/TNct5GoLj5SdmNmDKWFVSF
	MgYx0bD+RFSXN2nh5yiL0iTLt4Uyp8+XY30DttviRZAOGrzcaGCRdOczQxR5URD5cd5vM/J+DjQSj
	ECGuOpFS4PTfIilJgQkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs1J2-0002PZ-Hq; Fri, 08 Feb 2019 08:14:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs1Iz-0002PG-OP
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 08:14:39 +0000
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EDF0E21924
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  8 Feb 2019 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549613676;
 bh=xL0KCDNUiJduuCEaNXLRVFjWNZf+NkNqmsXdvoSK/iA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rQHVF7X1duZ28gHc0ImOStTlxfQVScm08VOpsL/V+NNdrlhMgmQxCwLX5b7PBS/fG
 Sem2DDvpYbDQ7yzQfZAjkGEPRSMUnFmwctwV4EpciVrDpHwJzQLdTDxig96QgSj8Ip
 neBaqpPPUBjTla71dH95LKNBXluAEc05v1gQMM1k=
Received: by mail-lj1-f178.google.com with SMTP id r10-v6so2236116ljj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 00:14:35 -0800 (PST)
X-Gm-Message-State: AHQUAuY5OH0lZ7cYdTV/LlS2s0b54TZ+cip72a6nD54Z0pOzF4PuDxKU
 dh9yZ9I4XokQqoZXK7CZxC5rowzhQ2kK2JCmGP4=
X-Google-Smtp-Source: AHgI3Ia6/zOcIsnEFzNo2uCfZM+RMVESEyuhPk6eG8hwJpMSyzK2JtZmdYs9URL6G2FlnZYU36Rp91XupL082i8Nmpk=
X-Received: by 2002:a2e:7615:: with SMTP id
 r21-v6mr8595853ljc.131.1549613673936; 
 Fri, 08 Feb 2019 00:14:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e@eucas1p2.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 8 Feb 2019 09:14:22 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd07M_qAMtkRE8u6JFAj-f7iPEmwanWfmLkpG5Osi8mSg@mail.gmail.com>
Message-ID: <CAJKOXPd07M_qAMtkRE8u6JFAj-f7iPEmwanWfmLkpG5Osi8mSg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] DT: arm: exynos: add DMC device for exynos5422
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_001437_817630_E1775D72 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>  2 files changed, 100 insertions(+)

Looks good for me. I will take it after bindings get accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

The subject prefix should be "ARM: dts: exynos:". If you are going to
send v5, please fix it. Otherwise there is no problem and I can change
it while applying.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
