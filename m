Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C052C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C48D20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSFX8uwC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z27qnR4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C48D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fpvDWujKu0jqKZBayzwoxZ69eOQ0YBJO4dF0UT7bVJI=; b=hSFX8uwCuvfU6m
	Yeg/T9KfFo3XTi4dj+tiIoslNGuatOGK1Z2BmLwKbiLkD/JjYLi4Z12kZba2+Jny3hJpCyq05wVtr
	6U6u1mGilNBM23OO/hIqmhmelLEKT0EiiwaP17hT1tImRxf6ob2rrTIeDMDgtasiksQa7waJYf+Ac
	hh1JhtXjC8IkgMENL/CTW9ESdt5LsFxeG8Xj2ClQQAlrxPJzNSo+Npp6Td3UW3iyaIhoaLEVB9F3S
	tj9QTPn8WTwk6/RQFCSpQcXpIahPoxn+d0P3NaE4/SF6L7IGW7tGhogMhMLgf3IQXY9K4n71uObK8
	iqdIIai04UC4eJ+IjoSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glX3B-00078F-4w; Mon, 21 Jan 2019 10:43:29 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glX38-00077o-Dt
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:43:27 +0000
Received: by mail-it1-x141.google.com with SMTP id b5so14485921iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BQXb0zgoJ2mCoNOejW9tOHoVJWqC6dyFJgLtkR+K7VM=;
 b=Z27qnR4dsnp7AYzCCgtZ6dyL9Z3KONJQXeXGIMAaSDb/UtUnfoc6A9Az381jndlEi0
 dlpiMFeA3VGF98Hgi5g/povXhCcUKmDD7DLoXbnvUvYgQZzylEZFQ97WPvZhS76jhicN
 FFhdd9OE7BUkW3dt8hlLF5aDJX2U9opvYRryA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQXb0zgoJ2mCoNOejW9tOHoVJWqC6dyFJgLtkR+K7VM=;
 b=gHJRLYAKhcK80AjCeWS3ZfvhRWnJwxQgFoImiK/Nv80bv3iuo8K1S+G3hkRlq2TvWk
 4oG/4IuswqKn05FUDr1zKncvOjd3b9l1depnddCUOZkIqYJA8G9yaeaHWRpF5VJggrOf
 Ef6nCoxsH4QP4nKERyGR0L9ZEVNUXjTHAiaenpRW6jAp3ehq8MGy+nW3wzWBnR70chnx
 S6VGM3ef2W69difslg1vCz4xfL0L2q4pWrJWrKm+kQof1CuLGXHHCn+IXd1Yq7ArGMG0
 MAMWIvEKpyZYNbp57dGNtZVqOJgN8/P5xxels2PHYzyY7QQW49QXWS3iddCzLjN7o1ry
 BPKw==
X-Gm-Message-State: AJcUukenTIbJBm7QBMGxfqcLTjGTVYYIZMnmKSEtLPfiPj382VSTOGmL
 zK6nPfrDD4k5J/p+t2Y3jip2YSwy0tZJV1bG4MFsB8FjVjA=
X-Google-Smtp-Source: ALg8bN5WGvBMiF44LaTui5bstwU8eNuQkUryJQpFe200XNIaEcVCdAWtEKNAxGYKSfMBhwSsgSfsyx3F1Sgg+th4rPQ=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr18358127ith.158.1548067405296; 
 Mon, 21 Jan 2019 02:43:25 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
 <20190121103026.GB15590@kroah.com>
In-Reply-To: <20190121103026.GB15590@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 11:43:14 +0100
Message-ID: <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_024326_486422_41DAE98D 
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> > --- /dev/null
> > +++ b/drivers/char/hw_random/optee-rng.c
> > @@ -0,0 +1,272 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Nice, but:
>
> <snip>
>
> > +MODULE_LICENSE("GPL");
>
> This string means "GPL2+", you need "GPLv2" here instead.
>

I think you need a space there: "GPL v2" or it doesn't get picked up
correctly (or at least, it didn't use to)

> Yeah, it's a pain, and everyone gets it wrong, we need to add a
> checkpatch.pl rule for this to keep it from being added in new code.
>
> thanks,
>
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
