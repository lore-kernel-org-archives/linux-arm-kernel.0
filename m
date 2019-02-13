Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73303C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:28:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47288222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELBtdKmI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRdSBbmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47288222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cocMXltvcC5u63Qxp0tFbzmRY1KKP4K5LpoUNlz/WuY=; b=ELBtdKmIBbWikm
	hDbhkEqIZBI2niHnMnVrxOuVaXhK02uHf002pUB32KLTzgbKfqDzWK0Lu2A2vxOL0Si7RB6/Wg56T
	Pkfv8i5/sFNFCSpPxcVyJLyqVX2DZlI83wKuwB/lhZGOtEDGUKFHvTA/ZGod7MEZtmd9w+OpuZAho
	L4QO4FloQXmAJGfscJnjv+OSHFzAKPfw0gQUPNKZOZLEsme/Cvl8yiPwnfAzzIeOaZf8zvndw2i44
	c7wJQo/B/RUfM2DqCYWWZLSeW5pbd0rT3lS5jBrKzaoYJQshRWuZeaKbiXWEnKDkGqEP33Vy5mAGS
	3GiIJ44LGsO58GOAqkcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu0CP-0007Ad-Mb; Wed, 13 Feb 2019 19:28:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu0CM-0007A5-Vw; Wed, 13 Feb 2019 19:28:00 +0000
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F41C21904;
 Wed, 13 Feb 2019 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550086078;
 bh=d4USaxOaZ5zIs0Yd6AYwU7IxGiiMG63YyGPnEEw7QQk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MRdSBbmokqMe8z+9FVsMJsm648JqGS4TxplBfDvE4kg//D3ih8EgoUzNEvOm+uwxn
 OfG3inpBJ3aRJziIpru75JaWAPGejKP+rW0jT753boDgWR4cniOiayP/gg5vgcXp5C
 PoMWr+zmo30lm/AU8BhVR7120eozOfZ2/B37L/HE=
Received: by mail-qt1-f174.google.com with SMTP id y4so3993399qtc.10;
 Wed, 13 Feb 2019 11:27:58 -0800 (PST)
X-Gm-Message-State: AHQUAub/6gRYirxDXtevEM9e1MhFSqvy5Lo3OM9VL59blUE/tFSLtXf2
 yFDWoP42beWqAdYxngvsX/Z6v6VD4KYUUPsTzw==
X-Google-Smtp-Source: AHgI3Ia7ZzDKkBkWUQYA6sU/9ZdcsVSBsmd/pRgt7FkqYjFxVtDglXsm4TWC21OgiOFhLerCX65ssWFBeBIZC5R9+H0=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr1699437qve.246.1550086077695; 
 Wed, 13 Feb 2019 11:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
 <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
 <20190213182435.GA19906@lst.de>
In-Reply-To: <20190213182435.GA19906@lst.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Feb 2019 13:27:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Message-ID: <CAL_JsqLCr4Jk_-cWUFGs5zfk+NKksc+bs0bpiBeQHsZFthaM1Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_112759_047520_8444760C 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 12:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 12, 2019 at 02:40:23PM -0600, Rob Herring wrote:
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index 3607fd2810e4..f8c66a9472a4 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -43,6 +43,7 @@ config OF_FLATTREE
> > >
> > >  config OF_EARLY_FLATTREE
> > >         bool
> > > +       select DMA_DECLARE_COHERENT
> >
> > Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.
>
> No, that will fail with undefined references to memunmap.
>
> I gues this needs to be
>
>         select DMA_DECLARE_COHERENT if HAS_DMA
>
> > Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
> > from DT, then it should always be enabled anyways.
>
> Fine with me.  Do you want me to respin the series to just remove
> it?

Either now or it can wait. I don't want to hold this up any.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
