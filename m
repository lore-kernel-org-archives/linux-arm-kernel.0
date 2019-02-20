Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DCA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ABzxkad+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+BuyOCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DCA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jzYeCNpvahiiAz+Oqoxxls92tZUDYC4Lz061bZf0co0=; b=ABzxkad+sv6g/o
	c2pVCQeyLpeOFApo793U8wj+FFBRddr70J0n/oLbR0DpICMHt4neyfXD7S8eIwu+Ul/ChP9tbFUbQ
	uf9rvS5BU32+fikGYpVcnDZiy6lIDYfZOqVz0OZjPxVpoqJ3vbdrkt2Q4ex12b1u/olY9fePouPjT
	t3xalnUB87BNInqVMgdb453votqC9zgHfv9X6pxwFLsDnQ+SfEOrmPm+ZdCoqFWyYip8I4GPuCzIo
	4Jc9JCLzVJORMK/sE6Ri89JMOFhPOqJ+zlJlgSqmiUNw+LvoblwSHCvwTQSM3QSD2SwKow8V5LsRv
	4VkVWgjAiGr0ezxqHmUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSPe-0000yu-W5; Wed, 20 Feb 2019 13:59:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSPc-0000ya-9e
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:59:49 +0000
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95FB12147A
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550671187;
 bh=Ud5jdsFYmSg0ZW5/m31OCJLPGcn72YaVm0ChgdxLfuA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=E+BuyOCEFRhGhXZyV470muEmYhe5q47bUMt/wF2Gi/QHUvt1f/Mo+U/D91fkrRxqE
 Jr0A0dMoinHAeFemKJ72cpSwwjytmhlhchJh/hjeSekN0acuit8cHajFvKuBRwpXt5
 ASt4zIi9ifC0ipzXk/3r9I1D08x6+isaqYC8qExE=
Received: by mail-lf1-f43.google.com with SMTP id t14so17651481lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:59:47 -0800 (PST)
X-Gm-Message-State: AHQUAuZknl94jJUuw4XwCrYBDeRhEFP3n6aVCn3ptdEGqOk5O5Mp7pNj
 v+J29SZV5TqR2eZZ0l9iP6QqRLviOjE4bnZFTyM=
X-Google-Smtp-Source: AHgI3IY+0B2iQKWk2fzKTKhsS0W87BddOqWyWa+1UJI1wXIbSLKWgt6UG1/re8aFf1EkDVQycKchEv0fWqzpwMY/IYE=
X-Received: by 2002:a19:d83:: with SMTP id 125mr19889468lfn.159.1550671185658; 
 Wed, 20 Feb 2019 05:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20190219130337.21353-1-stuart@menefy.org>
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Feb 2019 14:59:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPediHZqN3MRMYUaQT_jKyvb_20fxZm8paV1AVysWHScsQ@mail.gmail.com>
Message-ID: <CAJKOXPediHZqN3MRMYUaQT_jKyvb_20fxZm8paV1AVysWHScsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Devicetree updates for Exynos 5260
To: Stuart Menefy <stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_055948_352257_5D91F3BE 
X-CRM114-Status: GOOD (  18.02  )
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
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 14:03, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> These four patches are stand alone updates for the Exynos 5260 device
> tree, which do not depend on any other code changes. They either
> fix issues or add functionality which is already available
> on other Exynos devices. They were previously posted as version 1
> of the larger patch series "Resuscitate Exynos 5260 support"
> https://www.spinics.net/lists/linux-samsung-soc/#65035
> which was only posted to the samsung-soc mailing list.
>
> Changes since v1:
> - Removed from larger patch set for easier review
> - Applied reviewer comments to patch 2/4 "Add high speed I2C ports
>   for exynos5260"
> - Expanded patch comments
>
> Stuart Menefy (4):
>   ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on
>     Exynos5260
>   ARM: dts: exynos: Add high speed I2C ports for exynos5260
>   ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
>   ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260

Thanks for the changes. All look fine to me but it is too late to pick
them up in this cycle. I will take them after merge window.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
