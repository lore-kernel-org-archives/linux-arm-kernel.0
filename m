Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80039C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4794F20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFroJUYt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnsOhErv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G0nV/oUzLjYELy+VEab2a/BgG5yfp5Xsrq8s3ejh8kU=; b=RFroJUYt/77zYt
	viwFf2Thz5QOyITKTpwSm0WG4RXkmjZd5HojeRL6ZhpbWnYb+cIMHJbh+3Tb/L0lZl7AyZ7BLRLCr
	SGXeIWBSJsh/zy3IPn4EI6V9ABDI3/zhVStkO8L0MeK50QkLNxUF4ismHzaac1fAd+O1k4zddjBs4
	eicx7QFmmpFaZurxoMNUimXRzVfrIaVe4P7W2pMz+Jqy9y1CcqnWhXM9U8j0otMWQX6N7ZK0gMzk8
	2k4iHGtQT5qJqgbloq6cUaz6jLTjh7N3hu99BHCAfS4dQsTdTeIsusqSgJMGJKbRgq0vQoh063jzc
	pM581UkVF9hVMpnN1LZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGib-0006ph-PI; Mon, 25 Feb 2019 13:54:53 +0000
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGiZ-0006p9-0Z
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:54:52 +0000
Received: by mail-ua1-x92f.google.com with SMTP id z24so8360282ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GziJ3EFuDLGu2W9l4GBWorWhHzBpk99fC2re92G5R8o=;
 b=qnsOhErvX4TX+KNzewhiyYOh8EzLqzGnmDRI4KoKyjO4vrZBcuOgkV/sTeuaG0AJs7
 81Cqm7UCbQtl2EqM3aD4CBQBKEYPz54Eg1mcudp4fQkYlbfUuMKhKHB0OIP5/cKUwQSd
 jhwZlgp0oYDuqvb2ggP7loAiqLiwVD0DW1SvZpZ/tjybwcWdKUOxSjXiKn2gSN3VHVwc
 7I2FPMVfstZf1S+g3cNQIbomspx5A0kIa4dwm8f4IbMf6hbn98mYk+GcvndB67O1NMwX
 caEQvrWXjciGdIW7bGKkMD9QJ7cBXRYdSAQI8l8yMJMn0NTlcOivfZ9kbfFnKchCIFlB
 CW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GziJ3EFuDLGu2W9l4GBWorWhHzBpk99fC2re92G5R8o=;
 b=YAO8YKEHjc5j3sIE3x09Z2HBAbYZFUunk033k8rUGyoz2lb7EJ85OXuDJoG8zfRw3p
 De7GemyWeL7aPfWQFnXCgKLQowhX5H6xcL6hurozXiU4n0XPLX99oswxQXTJTYMgbeGa
 3xtJSiMzCCVXbdzYDdMpSOpUpNuY3L8INeP67iqMT0tdByp+aU9bwkFQsGfc4s3yTevE
 voR22Lk2gpmHZNAYIYMgMnctfMjFnST8K7yP/yagMqYqV3ZrVj2VJiAEM3WyjdJgCVL2
 4E82Dp7xpSohjQCFuM9rvt1KbxPj0LYmlZdhMkXNjl1a9kpR9GdvMaF1QXMwm9gHNoNP
 8wmA==
X-Gm-Message-State: AHQUAuZ+XhkCV561b97ypE6SZnQ4Z611SVIEqhtjHj6+PbF8zxIeIrpK
 qAK0LqHaaPjaHA4lWB7YdIQUWjORfECqX5PR3rcS1542
X-Google-Smtp-Source: AHgI3Ib3x8BxLL/jSlhOthuHadtmGXvwt6gIvxYQpLeAh9b6hGBGywveBfAXNVPGXodmhsjMppzx2BdxvPlKq3YicBk=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr8953736uar.39.1551102889211;
 Mon, 25 Feb 2019 05:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20190212072528.13167-1-hch@lst.de>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Feb 2019 14:54:13 +0100
Message-ID: <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC v2
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_055451_066663_C5D2EF8F 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 at 08:25, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi everyone,
>
> this series converts the remaining MMC host drivers to properly kmap the
> scatterlist entries it does PIO operations on, and then goes on to
> remove the usage of block layer bounce buffering (which I plan to remove
> eventually) from the MMC layer.
>
> As a bonus I've converted various drivers to the proper scatterlist
> helpers so that at least in theory they are ready for chained
> scatterlists.
>
> All the changes are compile tested only as I don't have any of the
> hardware, so a careful review would be appreciated.
>
> Changes since v1:
>  - fix a missing kunmap_atomic in mvsdio
>  - fix a stray whitespace in s3cmci
>  - add new sg_kmap_atomic and sg_kunmap_atomic helpers
>  - set the DMA and block layer dma boundary
>  - use pointer arithmetics to reduce the amount of changes in
>    various drivers
>

This looks good to me, however the lack of feedback/tests worries me a
bit. So, unless you think it's a bad idea, I intend to apply this when
v5.1 rc1 is out, which allows a lengthy test period in linux-next.

Make sense?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
