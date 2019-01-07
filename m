Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC771C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B483206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FIXiCskM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IxzeObZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B483206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EpIQ6T2drf72TXVf1+FFLb9HKT8IHGOadYFBMHL52wU=; b=FIXiCskM/so9XN
	Bst6MapK25iKaxbhVGrhZcrHBtmMdgSwR8JvxAnPTGA64RR4FZFTjmXfCocmxyrxEIej2AfAkNqdN
	RVWaTTtRRTKHq+/m6Ufey4oh0IJylAhQmvWniPK4YYh028SGwLwVxMVUEZr5E/2nK4hnwJ63j4oEx
	WWB6qCAzhSr7vmsKiRLZXsrL30/qGDNInlUtSViThZDp8/LunO/pTzYuk/LLyQ2uIOZ96tRGQAhlo
	yOFu9qb7spDki/E6ucnY+zuTMLSZvQGy/X8bvHqacUEGQNGwLv/YNY/jpApi3omSBOfn0tZFT+yzO
	2mwAPb1jgT0Rv3FWOVEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggaQj-00035u-Kw; Mon, 07 Jan 2019 19:19:21 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggaQg-000355-OO
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:19:20 +0000
Received: by mail-pl1-x643.google.com with SMTP id e11so586380plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RdY+FQ4vmBWmv7Uxo+1l55P42pudhz5vFXJr/uJbib4=;
 b=IxzeObZqagNtcozqqsAjTXKQ8Pdkf/VSX9tIThcApRmY7BsYYtDId7CY8RjXcF0CMB
 zj5DoUpL2CCnp9sRtz1pvHXxgfJcp3J//QJ9BBPAVtwhRdnKrkA9zy7qhhut9bqiK54s
 5ajIUKtHepfUoAGDyrzQ+dYwLtvYXI01w0bVC11tO8G3BWe+GyOH8T39QUzlxDEHHiCY
 4hlM4dM1YYc4KDxi9kV18FAxamVgxbiibcatVWoxNaL1L2PSeThGzAemIvKiuJ/eJUGH
 Pz9BdjVZ93dh8ANH5w3NYCE4/JfDRqk1jEnASfeGrVxrSBVzLXfzhz/A0FjD5cwAACpZ
 bmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RdY+FQ4vmBWmv7Uxo+1l55P42pudhz5vFXJr/uJbib4=;
 b=HkFF4xdxEOcU+dZcLW0Cjiu3XMWKRFRH0Xld+Hiqt7tL5OyHeUvSurBsAgJU/Hm8tO
 VrVrrij/WrHok5hZS0ij4c0keqimRu6HaLogRIGdv2S/CnGs/xrzEIzILdMnbGPBgMc2
 CFE+26ggL6wuJXmJjKIO75JpQ2jrX0DNj42Pfc7033YwFpDxkn5FTSjJCz/Unol3Fa5u
 cYav38uJA22W5LM11IRKR2NtwVuxSgRi6W7fxdNh/i4LVBZo24dVUTT7lLjd9T08lw64
 WNLkqfY3tpsKy6VASp/4Nj4o+DJVv2xJbr/6Axi4sSE0aANJogEsTCsrNguOmtwea8n2
 qO9w==
X-Gm-Message-State: AJcUukcKxP8piQudLeL2gDB7T7c9IGHbDu9LRDo8s1tpgqG6vdJgditC
 KwVigJElGuK5ZEEodjpBG4JqKQ4mhFfTs/gjOSoFEA==
X-Google-Smtp-Source: ALg8bN5wQZsDoSzm6MwA9uImpmyLMmj0qXxb4rPQv7wwqLwplXAEKkaEwKSHBuAlnZU2EVkXS7zbZ+rvolutn8SyoYw=
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr61962557plb.238.1546888755716; 
 Mon, 07 Jan 2019 11:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181231181209.28695-1-natechancellor@gmail.com>
 <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 7 Jan 2019 11:19:04 -0800
Message-ID: <CAKwvOd=NfK-P_Z=W=h5-5c2Jv3vfB0FsmdHcZeWEN1y_Fg=YAw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Remove '-p' from LDFLAGS
To: Nicolas Pitre <nicolas.pitre@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_111918_815020_934EE86D 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 5, 2019 at 8:34 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Mon, 31 Dec 2018, Nathan Chancellor wrote:
>
> > This option is not supported by lld:
> >
> >     ld.lld: error: unknown argument: -p
> >
> > This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> > that tree). Given that the lowest officially supported of binutils for
> > the kernel is 2.20, which was released in 2009, nobody needs this flag
> > around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> > linker flag") did the same for arm64.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Stefan Agner <stefan@agner.ch>
>
> You may now submit your patch to RMK's patch system:
> http://www.arm.linux.org.uk/developer/patches/

http://www.arm.linux.org.uk/developer/patches/info.php
"""
Mailing your patch.
Mail it to patches@armlinux.org.uk and check the reply.
"""

*sighs in GitHub*
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
