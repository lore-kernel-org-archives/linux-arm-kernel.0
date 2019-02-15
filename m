Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECEDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCFC21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgcHFscQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCFC21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xliv9EMJ443xmpSLYUSWG9N9XjthUOwKCz88wuHLLnk=; b=YgcHFscQqkwwh8
	PviJgs2vNgqTDLR+7pd4mdSlqLxrZAGpALvVnB4i9yx210lCHfO23niVJb8BJIGHM95wzva2WCtUV
	uDpNpFidQGFWO0KpArBEzYbP7FHIgCkTxhd0t3Q9Vw8XjFyW/RHK2NaTFXwL1Mmg58Hi0pBaPcHRT
	QAQmRqKfW+y/LHaU97jE4eUNA2l850lu2a6IzuXVGYfy5hgWUmEEXFgz5JdGtz/VuOzNCYtkA+Y0j
	9Zh2k0X9uocamt2ZA+iLLdmPCcMns7oo63EFgfCaXKUs4CHpFaAzA8b1rkr58K9Yikv5bRc6mHxfq
	JeWCd5yUTaw3P2HaBAWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugdn-0004Q0-Sj; Fri, 15 Feb 2019 16:47:07 +0000
Received: from mail-qk1-f180.google.com ([209.85.222.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugdk-0004Pc-Pl; Fri, 15 Feb 2019 16:47:06 +0000
Received: by mail-qk1-f180.google.com with SMTP id m9so6065687qkl.4;
 Fri, 15 Feb 2019 08:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1CW/0RlqVKG17nMeZJdietLaiCVzhsd/0NMTXLxfngA=;
 b=rN5MUg1epX1Pc9dw56DOwS//cPIXWyc2XJh0lZqhT3ofrLW7Z1wUybGucUmLWyH0Av
 U3B8Kf/ZNzYm7GfyqDxdDZpO71KlPceDDZI5ZdGJ2pwlzS3kWr2uLu9OLlG0ye1kGaAj
 /C4qrK8F03TfMLe/5giiqpEcKCOAQ57zfLIIoR3WWMBjIpJTc6oz5kL45q5shcg6GPGl
 O0QcaO/yw2boF/WLMnsb8JXrM8+hb2mlHVFw9haceLm8neLVFfxcsPE60jtDBvfCZCQz
 T5Ob4FHIM7an82qqdNOG59s2Vtf5sZyhjGAkGgvzzKJmFtYp7p0i+n9bsHIiJWialcVX
 bY0A==
X-Gm-Message-State: AHQUAubJ201ky61XlNJqsU9jSHYNd0EOHEivLCnP7gAuL+VAlOa1rgE1
 D7YbrMx6iEJM/3scUno5ZOPVETwqTpZ4FrgbN/w=
X-Google-Smtp-Source: AHgI3Ibf7ENwGUCymAC8nronrRheSoz10+htzD+WK/jAM26/ydCWqElyeAW4JMQj5OuFHbnT9GsV+9eyPyQBwkZMV8o=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7318844qks.343.1550249223692; 
 Fri, 15 Feb 2019 08:47:03 -0800 (PST)
MIME-Version: 1.0
References: <7c3dc195-68eb-e78d-3f7d-806546608d2c@gmail.com>
In-Reply-To: <7c3dc195-68eb-e78d-3f7d-806546608d2c@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:46:46 +0100
Message-ID: <CAK8P3a1Y55XZkULdvaSctZwEDKEpr4eWA60UQJPsk5JzGwA0mg@mail.gmail.com>
Subject: Re: [GIT PULL] Mediatek SoC updates for v5.1
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084704_832895_43CD655A 
X-CRM114-Status: UNSURE (   7.93  )
X-CRM114-Notice: Please train this message.
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
 <linux-mediatek@lists.infradead.org>, Ryder Lee <ryder.lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 9:00 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:

>   arm: mediatek: add MT7629 smp bring up code (2019-02-07 17:59:16 +0100)
>
> ----------------------------------------------------------------
> mt8173: minor typo in scpsys header file
> mt7629: add smp bringup code
> mt7623a: delete unused smp bringup code

Pulled into arm/soc, but please elaborate on the mt7629 chip as I could
not find any information on it but would like to include some text about
all newly added SoCs in my pull request to Linus.

Is this a variant of mt7623, or something else?

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
