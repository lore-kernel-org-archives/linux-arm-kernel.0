Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA462184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="joxr0TJq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cHp5Y6XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA462184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BPzlHe3GEEwuP60E1rke6IqZQeRmc8g+IbyBMt1XW9U=; b=joxr0TJqsOp5T8
	yJf+cx4zVVjwk7lQIK8blJ9ZfWUIOA0VXt1NTzt2PxrnWwaBhCoRGe56Uqk+q2YekC4PmwWyFPhye
	MlWsB5iDuIW+Hwb+nU8nyu8JzXoNGvJU5ma2xZh8ZjbXKKfi0ug3DbddeZ/4ZxDH+FFVxP4Kxw3El
	rDepEB7jpiRk4gFKn7DhY/ttTrP05qEuCjuP9Ur19Eu6moCc8IRFq3HC06t0JWCcNxxjQIal86vu8
	wXK6OTv+eY0ijVC5BLtdCJ/SmGeLj0N4GNwHA1sDFu8wZHVpx7l43k2HBLgCdGEUKniUIq2cOgbUX
	feqbfKMG3wSFIapsO3IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQc9-0004fJ-1Y; Tue, 26 Feb 2019 00:28:53 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQc6-0004es-Ns
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:28:52 +0000
Received: by mail-lf1-x141.google.com with SMTP id g12so8271858lfb.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R9fHDYu7/K0cxYsKBhkgbdvY8kvR2QORwgRSe5slh5k=;
 b=cHp5Y6XMmnVy/s/bjXsqT/7Q2JuFKTBrroRWUUnR9bfI7jozMY6TrEPaWzh7X1WuPh
 EKCkHnqlqQCGHRabdiKlXklvMa1rnGu7wSlz5sFySPzR6pdsZMGtwmQMEAyb1EgHlT0Q
 x2zZHPMEYO7N3Zzq/PN+95pCmAVMrK3otSyfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R9fHDYu7/K0cxYsKBhkgbdvY8kvR2QORwgRSe5slh5k=;
 b=KA3nXt8+Qkv5ZidxvNwIAbzLvlftH7dPkkzJzqhy1tuPrxW/czYvIMRZQxI7X1Lce6
 cYEPhSIKQ/jo+sxc9dos4hIWlMVqP3XqCVObszCPzK6g/JXmsUbwXzYQLJTfmFVQnnGs
 ne7VoQYYJ2cPN18y9HHHoF/n62dTB87PLC6DxKetrkp/4FovIJBR1GegbhrfKtm7tNo7
 6rkNni44OT5+brHNBZNUcDp0A+DZc7gnDVOTGBw4TODx7g84RYcdWyzxNgsNpTLlscTk
 FOJ0yrvXwjQjvlFill2GcnKrNycGLEOVluQdJWXn6uOEh9WSLKMe9I0BUsb6fOdE26zl
 BoCA==
X-Gm-Message-State: AHQUAuY5BYMwXzLfh+9Sl17TkqhFoTzCybckmb9CpzYaatPxTu6fT/Xy
 uRlzM0dKGgmCjA0KsqkRICWOVxCl9v8=
X-Google-Smtp-Source: AHgI3IbuAbtJ9Z2hvSTJlvib4T02d6KrZWUyHV8OqTTDC7DlHNJJvoNkV/EYaEkjm58WielcCv9voQ==
X-Received: by 2002:ac2:514d:: with SMTP id q13mr11649288lfd.30.1551140929004; 
 Mon, 25 Feb 2019 16:28:49 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id b15sm2566051ljj.70.2019.02.25.16.28.48
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:28:48 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id z7so8965481lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:28:48 -0800 (PST)
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr12182408ljk.64.1551138970199; 
 Mon, 25 Feb 2019 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-9-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:55:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft5rTt09Dis3Jq9vNqpqU4W-ehOxAmepYWJ6LXXnkvC8gg@mail.gmail.com>
Message-ID: <CAE=gft5rTt09Dis3Jq9vNqpqU4W-ehOxAmepYWJ6LXXnkvC8gg@mail.gmail.com>
Subject: Re: [PATCH 08/13] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162850_781322_CB0BB9E8 
X-CRM114-Status: GOOD (  10.54  )
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
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
