Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDE2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:35:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C72173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nG0lbWqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C72173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCUaJSHS0zt1uiKldw0C8NyQoMVJWF7iwQTZj5BAk8s=; b=nG0lbWqtmxGG+y
	UVD49dE564RXoJbwvk4326RiX27yr8ZdEoGju89OK1+kAI+LLvLe2YNk2i5b3oqThwozKVQkeozAS
	PmOvsQynZVwSoFs21KHyUKX4QP1nH+nnkozH20T5X/QEhuMVpjFpM4dgeKpdj1ur8O3PnmLCRR4+P
	cgzgW4GHKl80UmSVQvIMJCWJh5tZNF9Ww/vqduLlzcT897vVMD3d6sX177kPp4JTHGWXODct2+kzb
	eQNfiTHT33YhXY7NEF0s2lwmh+aCcygOrqu1tkjdTNI+wilLK4c5Mm8lrHuEG1pjVHHlG9vp7nssI
	YIWcZ45X8GdgNocOcNWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgGU-00014B-F0; Mon, 18 Feb 2019 10:35:10 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgGR-0000ki-AG
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:35:08 +0000
Received: by mail-qk1-f196.google.com with SMTP id o125so9673374qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=31I98wBtG46flOMCHX35G/QXOYiz0ypU0MPiC/Bt+QM=;
 b=OTtjQA6mrB8A8srf5f1scGcdqmbHdp1VSYPjEb5zDH/uLHGlkMdJ893ES3j4pRTOpu
 WfKUS9034k++NzuAHKrqZXPG5tHYYEgR5zTw6cxueuqKrf3gsS6xfGPFlDokMTTnKnhR
 J4291V511GnuEp3SZo0tS2xkN17eaVYQupTqmKcyBDlwKMUkwqbOuJT0vtr/TBPNc9O9
 8KfblIHgp2ZcFn8+0aYDVZFxRqrxn878wpUJ14Nss81wbZZsB7PTefmuH/t8zzBPX1ix
 87uIcpLyeVYwpySXPuXNH+0CsCYeHBOV/d7BSwWX15wN7S60amCIA482ex/EWea2D23t
 jKnw==
X-Gm-Message-State: AHQUAuYisSVula/swPcH2MTOebP4Rg5vMul6k6vA2xVcPgeZWssG08NZ
 NxO/RxAmYNhD0R6Eyg1f+Qdh3EpgCeka/yzZ/aY=
X-Google-Smtp-Source: AHgI3IauOpRdgVsOn6T1pujqDnnxhfgsw/2bJs3AIN21nasL0nQnv3TMZV7J4+MgCn/uiVFTZlo8nuhlO765esRY/ng=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr15376077qkf.107.1550486106166; 
 Mon, 18 Feb 2019 02:35:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org>
 <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
 <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
 <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
In-Reply-To: <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 11:34:49 +0100
Message-ID: <CAK8P3a3mpr1CpdwPEjGyigTFgqP4gVxQbpW+qypv1kaYskLBUg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_023507_367346_07FA89AD 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 2:56 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> On Wed, 13 Feb 2019 at 22:32, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > Remove wildcard compatible string.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >
> >
> > Looks good to me. It does break using the new dtb file on older kernels,
> > but I suppose this is not a case we care much about yet on your
> > platform, given that both the dts file sand the drivers in the
> > kernel are still  work in progress.
>
> Right. Thanks for your reviewing.

I have applied patches 1 through 5 now. Thanks,

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
