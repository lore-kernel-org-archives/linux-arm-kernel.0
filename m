Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0ABC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD2C20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4zn12l0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kuumHzluc4o3D4TXnzLAxL3FrMnfbGAsBvb2BNm1meg=; b=c4zn12l0KGi21/
	0YvzTEBQgFHTJoaR+iSS+FScM6ypIE/gtbf5Q805goYphCbMHFj/CzOYJmvWgty4eXnHwt2rPVp50
	AQmSw7cXpXUZLNKl9hbUDJGIFleOnoWZrka59A/ngKN4NzEeY2+FTceVLiJD+oxc/TBx7JdJ/ajsp
	Kd1msvJNcBPiihD0JV9mp4Q3jV9SDTencdYNSZrN9F8oHypurXgJYxlchWei8+82Zq/UDvbc64UMo
	OwCmHUzdEUbTLT0P3UU4Yv0KZWi7i9nYDJmxi91fpNyEq0xY8szPP6S51SGe478MuFCCW2kpu0wGc
	N7E30U8B+4QOqYYp7QtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guf9W-00011I-8O; Fri, 15 Feb 2019 15:11:46 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guf9S-00010t-Vy
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:11:44 +0000
Received: by mail-qk1-f193.google.com with SMTP id y195so5834164qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tOYdFUzqbifiMo+qfEZe9irFMU6o/xZi6gZANn1QLow=;
 b=aAITOfHAr/q8A9GnUo+jkGxyOQOACnW19DqlqDfoyfz6nqk6/01pSZvJl38GH9VQ79
 J6Y1OqXj4gyIVkiVwJ92t/IQl56O2YsrS9WT8Xe+xtYi30CReluPYIQIAefl5PCuAhDE
 WMlL9QgB1xrfwewTfW1Wfb27B4wPmMs787DDnIUdW4Gp7htABe7JldQT2XgKCutkdwEv
 /Zy4UkXAiRysN1cv9FT4jIfevDDNCjmHILTBHxFz0mgdBMBVNH3tZZ23Nc7OEbBQYP+S
 XTgiuwSuni5nSIKtGBA591eomYOhUrk0203IT3r/Th3H/3NUzp2ObLFaGC2qASif/Bff
 JZzQ==
X-Gm-Message-State: AHQUAuYbsZq649HoqFjDyqFi+45SeC9LOMoDqlC6hmTSTTjKqR4PRimd
 jn9Zafy78mu0y6srg5A+mm2EwiqYYEruNbN/ugZHNw==
X-Google-Smtp-Source: AHgI3IYrBuMEDAkZtE3cGA7ot4TlGySJObuBQBCDD1BGPeG57Od7hVGsYGDsTty8uIDsRBYkWeyANubwqZzHmMD93vI=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7377908qkh.173.1550243501958; 
 Fri, 15 Feb 2019 07:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-5-shawnguo@kernel.org>
In-Reply-To: <20190212112126.572-5-shawnguo@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:11:25 +0100
Message-ID: <CAK8P3a1eAo+oW8A7wV_RTSokKbJsbKr=8yJKVSJpsPOrwSbseQ@mail.gmail.com>
Subject: Re: [GIT PULL 5/7] i.MX arm64 device tree changes for 5.1
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071143_026381_C5F20A1E 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 12:22 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-5.1
>
> for you to fetch changes up to ca04fed4706dfb13cb964be2dc294054ed0efb6b:
>
>   arm64: dts: imx8mq: specify dma-ranges (2019-02-11 13:44:12 +0800)
>
> ----------------------------------------------------------------
> i.MX arm64 device tree changes for 5.1:
>  - Add initial i.MX8QXP SoC and MEK board support.
>  - Various device additions to i.MX8MQ SoC and EVK board support:
>    RTC, QuadSPI, PMU, ECSPI, PWM, GPC power domain, USB etc.
>  - Use generic node name for m25p80 flash on layerscape devices.
>  - Add num-viewport property for layerscape PCIe devices, and
>    incr-burst-type-adjustment for USB3 devices.
>  - Add LS1012AX based Oxalis board support.
>  - Add fsl-mc, FlexSPI device and dma-ranges property for LX2160A SoC.
>  - Add SMMU device and missing dma-coherent property in fsl-mc for
>    LS1088 SoC.

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
