Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79103C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4338F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuKDfdyX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMCiJmt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4338F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PRwNq2KPRwoGecMx5ZoYjnJwZTVaKccPz0f+L6h4RzU=; b=OuKDfdyXoaPwtO
	VsoRNh5qL2qxgOWnRak6obtQ0hiV/vBWZH5XM9LN8DAfmIwwI5F3AVYg++bwBwtoD+rMKftMIslMe
	6UZAbB9LyZRWYr17F+73oJtuCTFJr1ZpDmx592300x7f+82vWC2APcR6/Idk5hiqLSI/fCAXbBere
	mUYcfQr8gPhz59StphMSxihu7zgq5ATIdBbuZ6cPJIMrIcvaDWf/DI9YTF9xx9q/kaFrpxeK5yPHS
	B229BhwM4zq+JGrYd40eBuiMUw0RaaEAYqQuC4kSgQ3dxyVurhKwbVQh0kI2d2P4tVQmVZ0ZjGPi5
	HqS33mWGeUn+uLGrHbOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEr0-0004gQ-Uz; Tue, 19 Feb 2019 23:31:10 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEqx-0004fx-Qh
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:31:09 +0000
Received: by mail-lj1-x242.google.com with SMTP id w6so14341677ljd.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kIE35RsfAdfmPvEPcsGzl5k3eOYcySsNWpC7InGPXK8=;
 b=EMCiJmt/ma++GI5luHEWAweINLW5BeG+23iPS+q4Rf/Xop3Rat0n9vgaRuiLL2XzGR
 jMTnTlMySwyLHogYwZHrJZ7qaa8+iEHNb8NfquvcSpIsUjZ0Jxab4ktsfq4KLQ8InTh6
 ZB45N2QX4b1PifPwyCPbtWzppk6c/fEdB7yn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kIE35RsfAdfmPvEPcsGzl5k3eOYcySsNWpC7InGPXK8=;
 b=XC+3fjnUVaQb3yZbCQgJdl/8gyLyp/6HvpSm8Xhf/9a/7p/9KtyjPaQ22H5t/SUrPT
 IG30jVDDy6D6GNmomV21OzuhSKtxRAe6FNksHLYWsH1oBSUYjZgR8XOIlke4oJs25yKG
 GfYHBFbiMSKxoHMCzT7kL1u3dEte7KXp9R2P0aABL6adw0COwmy1V7sc9mmj9M9uuqv6
 UOTIAIkqOsqy+B+YOUiPEgCJXKipfaJfwO6XP37mKmpeZU0cc81Tb52T2EY5AdhKVUOF
 2t0Wh5/saV0jNqY7WS/aryi2YGohK+GrbFLALF94mdGEK/CAZQdATzo8qxRRCDhF6Oq3
 hcdw==
X-Gm-Message-State: AHQUAuYB5pFmlYWhfHwYURrfZv2wHjjSaqRQBQ68iTSt6H5Zwo7yqwEL
 /mtp5kR+5Wv8H+TmacqzfwDRHld2vHk=
X-Google-Smtp-Source: AHgI3IZmCMAT1TvxLuqn3+MoB96QJgmDQ9x4aukiTCqkIaoAKXQBpoYAGJkEPOtZK6/0okE30Rmpzw==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr8524712lji.152.1550619065655; 
 Tue, 19 Feb 2019 15:31:05 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id k68-v6sm4786654ljb.35.2019.02.19.15.31.04
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:31:05 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z20so18104218ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:04 -0800 (PST)
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr19628484ljc.97.1550619064118; 
 Tue, 19 Feb 2019 15:31:04 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-10-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:30:27 -0800
X-Gmail-Original-Message-ID: <CAE=gft5UxHBwQ_fm+MD-x-yX8fUd5miFzzMnc8nmet+8JvqXKA@mail.gmail.com>
Message-ID: <CAE=gft5UxHBwQ_fm+MD-x-yX8fUd5miFzzMnc8nmet+8JvqXKA@mail.gmail.com>
Subject: Re: [PATCH v6 09/22] iommu/mediatek: Refine protect memory definition
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153107_858940_B89FA0B5 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The protect memory setting is a little different in the different SoCs.
> In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> protect) shift bit is normally 4 while it shift 5 bits only in the
> mt8173. This patch delete the complex MACRO and use a common if-else
> instead.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
