Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E24214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQf9PDYW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBd8pBbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E24214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lr24gBDz3XYsBdEB/9dkt79EAifUkJ73tNA8+Q7GDKE=; b=VQf9PDYWnt6l3R
	bKI8Zz7oGshxqQQgykZlsNyZC66b5WM9dmTLZ7hslVtjcRZGkiV2UGT4gPoDua5t0V5BtO6ttpiJ5
	ypEegB2RyiBk9qBxwGzW9vlwr73uv1aIuPQVv3WyVMA3Xfo8y7bUiFy9QMU9HVMdB60HGMo9FymHb
	15WnvJfDIEvBg2u77f+63l/ip0NKs1N4u6f3BX2yLpVlTUwD0Abn8JAnwWdnIii9xSfUPFrmQZ3I7
	4mcvn1cKHN7lqs+08uvaSuqTdRVKZ5cGfuXZszneb60NDIqdJ5PhpiEhCwphx++1BoaQWnLMckM6O
	9Vxh5IaiIMll9qTKJCBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnfn2-0000px-13; Sun, 27 Jan 2019 08:27:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnfmy-0000pe-DY
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 08:27:37 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 90241214C6;
 Sun, 27 Jan 2019 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548577654;
 bh=oex/PD4/53qKXoUYp+S5TDZhscZw9hWPV0A+oNZN8n0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YBd8pBbjN3nRwBEx96mw5JFp7sIsyKyToHp4eqBHI1CwW9lsge8QwDwO9FQK3pgNZ
 fzXMxeUC//yw0P1jSGv/UlV+g9LRR/44fe4WBEnrfYLv6ubZzo+YB4NpSQK/GCm/AE
 ipFnhOrZsSzX8vz+jksCeZHipXbHlTP80BEQcyA4=
Date: Sun, 27 Jan 2019 09:27:24 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Message-ID: <20190127092709.3863c954@bbrezillon>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_002736_477930_8696B7C4 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 15:10:28 +0000
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I found an unfortunate issue while recoding plane handling to use
> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
> which is not correct. I simply fixed it (patch 1/4), but maybe that
> will cause regressions for unsuspecting users who simply assumed
> that the clockwise rotation was correct? I don't know what to do
> about that? Adding an option to get the old broken behavior seems
> useless, wouldn't it be just as easy to just fix whatever app to
> rotate the other way instead of adding an option somewhere?
> 
> I have only tested this series on sama5d3, but I did check the docs
> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
> and sam9x35) supported by the driver (relevant to patch 4/4).
> 
> Cheers,
> Peter
> 
> Peter Rosin (4):
>   drm/atmel-hlcdc: rotate planes counterclockwise
>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>   drm/atmel-hlcdc: fix clipping of planes

Queued patches 1-3 to drm-misc-next.

>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
>     frame

Still waiting for Nicolas feedback on this one.


Thanks,

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
