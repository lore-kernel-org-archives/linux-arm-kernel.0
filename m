Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F3CC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5801C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZaSAt1k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bg74843n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5801C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9OlRQx6Wax6gBfdYbvIJ6ZTANnsuPESH34u9VjGKUVU=; b=OZaSAt1kQMcLMw
	B7eJ1CAXFXT06HuHubEjm2DcHDCGmoL2iqIRR5BGc6zl82hgNz/fyBtbSntFz/GgjvJ37Ib9yZJmc
	fR5KhRKvYKdMao0Dh0SzpuSskTdR6J1yluHhMasrnANAqL7OiOIj8+2cx+mh2MgGw4FdapZXKb1P+
	8n4aJC634ImYB8OzAo2KwgZh29PzzGXzQuJIbh2rQtSmdf+G3uaeEjmJQ7w+Dq4EjwbJH4s97vxOz
	AW0iwcYQTQEVnqbxmNWRDijFK2ByI+w8nRcw+qmTUppc4ow8lPMybqujCMbr3MN34UuTZEFqAFgrl
	JSJo6h+W/wwu65dwJw4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSRRv-0002ct-CZ; Thu, 29 Nov 2018 18:54:07 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSRRs-0002by-2D
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:54:05 +0000
Received: by mail-lf1-x130.google.com with SMTP id l10so2248935lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JrDIGvMFZ61P7XwTjN+VVrxZRozo8qUinJjUBiQ+wXc=;
 b=Bg74843nWWHD1YXFMRpFOEVId3CigmBTYWk97VTcqHNX8thigu5UZBMANFPm6658ZG
 9gBULGWSjyzDunuSSIyCiEzHwB2IBI3s3sHc2Shjx/NhwAFGvrSWRwWkxY/sbk0AhAhH
 ItXS8zjlSZNUQgEDHFgBfOgroGuk35J4gRqUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JrDIGvMFZ61P7XwTjN+VVrxZRozo8qUinJjUBiQ+wXc=;
 b=f2f6l6Mk3Ekj8UbT4PFCBA9IwxwoCwB//s4o34kqSg+KSTXKSpyTMJkUXaNOhv4etw
 LiuauPfy+raWYmz3ur3IzkFIOpJrW6kxvzU/C7pv+IZIvGWM/G4UQ/MIQ19MPOzdxC9F
 jrPKJq/gvSkZ+KmBn7iwfE767WVDdJyvpTGINP1kjtGchJMj2SGELHJpNMOAuN0SxIme
 zEPp27gnY0K57y/rlRLWaeQgPuwhzetGEPmGFNnyKn7qia26cmaNmTTW7sQuehuU1bq2
 7Qn5Zw6nf/0LX3CLNMnh/9W5syCl9uS3Sy75zJZZc7iD840kswTDiuCITp5hvt+iStCY
 F68A==
X-Gm-Message-State: AA+aEWbLkuv36QUyRJqipF9bW50rp27cKzCoMSw03g7usB7D89uvYjWq
 ZL2sSpUQ/PhkxVJvVtyfvzLpCWu3S7I=
X-Google-Smtp-Source: AFSGD/Xms4yJ9Nm+u0bVqUoMNEr+sXT/jwd3lSpPtT5lcMrTzXO4dL/3FbVgfNuwTwfq9CFSC6z30g==
X-Received: by 2002:a19:aace:: with SMTP id t197mr1749990lfe.7.1543517631404; 
 Thu, 29 Nov 2018 10:53:51 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id 11sm435024lfq.89.2018.11.29.10.53.49
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 10:53:49 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id i26so2275145lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 10:53:49 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr1899446lfc.147.1543517628990; 
 Thu, 29 Nov 2018 10:53:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128180841.GM30658@n2100.armlinux.org.uk>
 <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
 <20181129162323.GA27068@lst.de>
 <CAHk-=wi2K7_+dgCbc-sAK9CST5Zh+pOuH7sVT9WW-kqs50HSzQ@mail.gmail.com>
 <20181129183132.GA30281@lst.de>
In-Reply-To: <20181129183132.GA30281@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Nov 2018 10:53:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjmtZAAGvB8c6hyKvABPHNTfE+b+eHu7iktdogDfTgMw@mail.gmail.com>
Message-ID: <CAHk-=wjjmtZAAGvB8c6hyKvABPHNTfE+b+eHu7iktdogDfTgMw@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_105404_104490_7386BEF3 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 xen-devel@lists.xenproject.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 10:31 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > Or, better yet, plan on removing the single-page dma mappign entirely
> > at a later date, and make the issue moot.
>
> What would be the replacement?  Build a S/G list for every single page
> mapping?  Not sure that would create a lot of happy campers..

It's what we ended up doing with some other cases, and it didn't
really end up hurting as much as I thought it would.

I'm thinking of the vfs functions that end up turning "buf, len" into

        struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };

and then passing it around as a single-entry iov instead (not even
that - they end up being an iov_iter, which is not just the iov, but
the whole "what _kind_ of iov" indirection)

Maybe a very similar model could be used for just simplifying the core
dma mapping setup: sure, people will want to do single-area dma, but
how bad would it be to just turn them into single-entry SG lists on
stack, and then the dma-maping internally would just always see that?

Most of the high-performance IO is already using SG lists anyway, no?
Disk/networking/whatever.

But just an idea. And the "map_sg()" error handling isn't actually any
better, I think. It returns zero on error, no? So it's not improving
the error handling.

The whole dma-mapping layer seems full of those kinds of "inspired
error handling choices" ;)

                  Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
