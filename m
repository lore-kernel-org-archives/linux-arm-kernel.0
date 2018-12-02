Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB9620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMU3UIIM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="X745B60b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB9620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6HM+BAdvjJM6ZBSmHBYsKf7nIgHN+HN5UFeyrnDJFs=; b=nMU3UIIMKItERQ
	bgONXxZS8wnS6DR4812LrbaGGAE7/ai8BWROhkChlRzcv0o7cwdvp+44KyjPc9bhbqlKUtBK1EiGk
	XwYPJYDK8E+MRyPk+ubqMGDsIAeh+IswxNsfebdNQEtE++4e2TqaJHTxDfD0BWQTktcfZsDMwtGfJ
	fbaMsp54YbjykLuXOqNmdGqvCZIBphEdYFa49z6anEFnnXXzwML2Yaivzc0zShfQ2lR+00hMcR3KV
	992eXsolcvAREpOPf5/I+HiPLYrR3wHmRe+NrKMKzjLhR7H7ksR8WorExZDNoX41UBA/a771Wjhl9
	FY1Mvi6qGBdFPyRhHrpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXxt-0002Sl-Af; Sun, 02 Dec 2018 20:03:41 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXxp-0002RL-5v
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:03:38 +0000
Received: by mail-io1-xd41.google.com with SMTP id n9so8697218ioh.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CLGcKEygPrM1x+RcE56w2mEPkTzR+dx1vQHaBqZTcys=;
 b=X745B60b5/ktkU903MlWSJt++9v8imDHs5VU79MVQQKX9JdNmhJT+xfZZehBq6J4mN
 ZlGiDcGANChAoyGiZCOePgDlfq6Xu0CSIvwyG4bJAgVRDGkYYjAcNPQFxjbOHm5M4d+e
 V4gnfqgvqSPmk1YecgZkT7t5YThbcO3X2LZ/9HoLKJvwEUpyYbR/AnL7Rbg1mPagOOK9
 OPgaGsVE3hscdLxd2Jse33WccvROvUoNXT2Vkwh6plZrc2Dwgu4Axgq6/u7s55F0p4qA
 5r6vd/e6GB2hpuv107pL6yUBt4JcFSbji2oCB6g3UdmGfq4oA34CH9hxjVERcuQlfcqC
 rppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CLGcKEygPrM1x+RcE56w2mEPkTzR+dx1vQHaBqZTcys=;
 b=oBQ7Tc/xCNhGf8ig1Ay84l+zgS/wfdv+HK+nu/qn8WHfQaR7rg3FSGNNxSRIhJUdBJ
 ORMEGZsctu7n6N8J1ngj9VqVB7JNWlCJ2+1BGlKjpnZzc6H16QNLLhOSwb4x5VPSIRYG
 HmDmwPppqjeUdttztlFoCm2Hv382SjHcp2m1Z+KIadvlpB7onhPr8F8CwBrzMcrd9B6i
 x3SHKNK4F+BydTjy/gqnsWk36q+W8TfiDUjKFDdasUkHeISBgXnuV0ftWcJxQ74YRP2N
 KF5H21EieiDmXTkuvgq9Fj9rZpM084f0RXy6L/383bkk5IPQyP/F/JUqOIY7HJcfgjvx
 AM8g==
X-Gm-Message-State: AA+aEWa5wpwIUc4SO0sgLq8aolCvzJVJIiyAgehmXFACaF4pvipy7u2x
 iWxb5G8/dRUAVuz4HQWFdkmw6HmY8XCGMNQkCQt8HQ==
X-Google-Smtp-Source: AFSGD/VkuxR4saps5fhdiGOpgXVJk/OMVaVW1PHmc+8jlLGd+hswx/7ab2kcTFW0dYp8PxoDGYCC1BfdT8bC50MWang=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr12656624iol.155.1543781006394; 
 Sun, 02 Dec 2018 12:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20181016145758.12995-1-matthias.bgg@gmail.com>
 <2529be64-7737-6237-7558-fb15dd22b513@gmail.com>
In-Reply-To: <2529be64-7737-6237-7558-fb15dd22b513@gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Sun, 2 Dec 2018 12:03:15 -0800
Message-ID: <CAOesGMiE7M_urw2wyeE9gsv6C5xGnFG9uuT+z9rDeoed4mHSUA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mediatek: Update SoC entry
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_120337_271605_863F3F53 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 2, 2018 at 11:41 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 16/10/2018 16:57, Matthias Brugger wrote:
> > Add IRC channel and URL of the wiki.
> > Also add soc drivers folder and regex to catch more
> > mediatek components.
> >
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
>
> Any comments on this patch?
> Through which tree should it go?

We can apply it directly, I'll do so on next pass. Patch itself is fine.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
