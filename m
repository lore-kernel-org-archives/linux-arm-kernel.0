Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB627C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859CB20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U8e/GPQ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVTT82GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859CB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sj0eaWroE2GMucGJvDzQ3k1k8TQLYn8bGA+MhLk0O1I=; b=U8e/GPQ5e0yA/A
	YCMwc5XAjuMtIkDr6LWIZhYm0Aoiwey7zU1XO6ffMX3SMnmUQUV7wC0hhCOe8iX7ZOKrGnp6H37IO
	o+sUs8GHU6hvUN+88yTwUVR5OGDEhQUVMu/0wJ8+S9yP36m3+eRvysslNS2aDqnQgQFzMxZxAIe55
	2H3an3z4hjpEOHxRcye9VlOdWYILbxpLQMunRK9cndj4qV7WWncCF3OEgrZ0Jo7cd0LgYcPmwOAK5
	NpT585SqauZSptwATpL/5+JTVD0lwV4mn2ca8Y8bQOCvXu7zU6U5pA8RAmodB4/NfIvgQVp4a2igJ
	gBBxrGN450DT03hiOesg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUGo-0004bX-4a; Wed, 06 Feb 2019 20:58:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUGl-0004aM-0y
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 20:58:08 +0000
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABC29218D4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  6 Feb 2019 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549486684;
 bh=iYq9he06TAyIGnxh+2OpA3hFGxEjej0/ATcGdsMo+tc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hVTT82GHQobsDFcc1me1zSrLDrGlfYtYtTeN/r2OHQEu1y9UKhmZVRXgLvO4C+RxD
 zme53IsZ3kEfqdxw8LkQY0xZodPw7xsNhJF+hayPqwANC7J3EHiVltW1MNmtiYTgQs
 VsWgFhlrzJyT8SjAdOUxT0dihU6YFbz7Yd9UhVXQ=
Received: by mail-qt1-f181.google.com with SMTP id j36so7249241qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 12:58:04 -0800 (PST)
X-Gm-Message-State: AHQUAuZy4dBlOBrAYCjXNVk0P2u5YzrIMQ+jy5QqgAGHGbgVaOZeVo4R
 txxhOhjzToQf3YHx3u3ravBI36QMR6Vgx77NDQ==
X-Google-Smtp-Source: AHgI3IZ0eLGnTaLNOpY4JE6oz8hPOChfwuwrc8kANbEykIfaD0X5YtwGOEZe7PyYObuKrj9JuxqUx07Bpqa7vwpBMxQ=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr9361993qvb.218.1549486683865; 
 Wed, 06 Feb 2019 12:58:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
 <824396752ee40c8e4222fddb4a80408646989c17.1549482066.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <824396752ee40c8e4222fddb4a80408646989c17.1549482066.git-series.maxime.ripard@bootlin.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 6 Feb 2019 14:57:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+y++qMkCNehPxZ3J8bfU7Atgppy4uMtTEdPdkt9Xv_jQ@mail.gmail.com>
Message-ID: <CAL_Jsq+y++qMkCNehPxZ3J8bfU7Atgppy4uMtTEdPdkt9Xv_jQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] of: address: Add support for the dma-parent
 property
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_125807_087934_D63E1D9F 
X-CRM114-Status: GOOD (  14.86  )
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>,
 Frank Rowand <frowand.list@gmail.com>, Dave Martin <dave.martin@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 1:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some SoCs have devices that are using a separate bus from the main bus to
> perform DMA.
>
> These buses might have some restrictions and/or different mapping than from
> the CPU side, so we'd need to express those using the usual dma-ranges, but
> using a different DT node than the node's parent.
>
> Add support for a dma-parent property that links to the DMA bus used by the
> device in such a case.

?? dma-parent is gone now, right? And I see #dma-parent-cells?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
