Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:24:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996EE2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oc8zAqFy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXmvUkXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996EE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jLiCjU5pxLPWUX1ZcO+y5Ky+cwnV17yJLIHKJyk9TcQ=; b=Oc8zAqFyurfQtK
	2Z9OSkHeGGb85np0iltIW0xh5rb7j16xuRF3th1DdnPGe9rgKxMaDt0h/yCcX8ZgLs0GXE21S3tYs
	mo1vff0KwgeFE9OxMORUP9c1L6/PmhWC9Plj+9FAw+vuOtXBAZS3Ro6YEYMdaihN9Jz1UXOduaS/A
	U33PCmEoUfcpKsngob9YfBCbNBxd/iRrcgNYCI1W2j/daWvJO14rHqM+JN+XgAXJSifKZFEQnQJXk
	1+gfDrZNhPjKRtGkuoIwh1YKXuv2XjgZ26PYpeajdLMRStQrYllGyY6AbMYru2XND+Q6FxoS3wq9e
	krE0/wy3/Qn3Iqi/KBHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBON-0001Kf-Lo; Thu, 31 Jan 2019 12:24:27 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBOJ-0001KH-SV
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:24:25 +0000
Received: by mail-vs1-xe41.google.com with SMTP id t17so1811076vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M/+bZ6/6gdCEtdJq/xtB+MgxD6XcWlf41pwuNrFTkFY=;
 b=JXmvUkXS6Mz/5tdEQ6eVYd6MTFHQ9/LADGbIWxZRKwwmFRXevzpc/DrKcqFq52Tn6C
 D0B3EV1ad6bZ62vM3d1PSgfhNpYDiT+lp21YhCfrZ1UTQc/YevGM8i1QIiwBV2wIAmdu
 jr5hWn2M5WlLz1oeOCPJATtcKJxchPE7qi7jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M/+bZ6/6gdCEtdJq/xtB+MgxD6XcWlf41pwuNrFTkFY=;
 b=C2FK9sWXYcDhlDcy6bggJ+zeYEcHRZNF1ZElIJ6Z9koinYdyxDA0M5Z2h8QzWrRTXl
 obnvHtFxNPWBbX0QFHgt89JY7B3z9pPGHfitmcia0ueldfAGB6eHvQNyA3/Ruze2nbR6
 B4NLSWB+Ty1DUoIGTb9iWmjoFBs+vJX3IwLBa1G+XsssmQwrJXyN0FvvOzVzmOun4uFb
 JxLnESW2pm2DzLfBV/0MpuXE/tINipfOKsNeox333B4M2lnGguQSXoepqPCkwdt7O3P1
 6dO2d+ySnzuQNFus9aBNxjmOqLIThAAvVFwdjc4vZcEbWTHNunVqD+Vj71xWnESeTcze
 6B3g==
X-Gm-Message-State: AJcUukehDM54WEep+j1bN4HRzRA14UnAek9YXC6HDdY0yeOB7InhhNkQ
 rUL76CGM7qeTH2wdmtqOfq1sCruvcUHKZCDmWgLz/A==
X-Google-Smtp-Source: ALg8bN4tQraiSEht+qB30uLbffXlsPwL4UOTjIMOSqEyrELw9nfD5lvQPEzCgBUnlG6P/qNtwRyPBbo138r/jXXjDi0=
X-Received: by 2002:a67:1b04:: with SMTP id b4mr14287891vsb.141.1548937461981; 
 Thu, 31 Jan 2019 04:24:21 -0800 (PST)
MIME-Version: 1.0
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
 <20190131084142.GA21196@jax.urgonet>
 <20190131120542.g7wtnhzuz5nuqbcc@gondor.apana.org.au>
In-Reply-To: <20190131120542.g7wtnhzuz5nuqbcc@gondor.apana.org.au>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 31 Jan 2019 17:54:10 +0530
Message-ID: <CAFA6WYOHX7JKGALhV6nKRH18MFpgMc2g+2J3qLO5PH=sYNhKDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Introduce TEE bus driver framework
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Jens Wiklander <jens.wiklander@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042423_926781_AA965AD9 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>, michal.lkml@markovi.net,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, yamada.masahiro@socionext.com,
 Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Matt Mackall <mpm@selenic.com>,
 Olof Johansson <olof@lixom.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 17:36, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jan 31, 2019 at 09:41:43AM +0100, Jens Wiklander wrote:
> >
> > I think this patch series is good now. It has received comments which
> > has been addressed and have also gathered a few R-B tags.
> >
> > All patches but "hwrng: add OP-TEE based rng driver" covers what I
> > normally send pull requests to arm-soc for.
> >
> > Matt, Herbert, are you fine with the patch
> > "hwrng: add OP-TEE based rng driver"?
> > If so, is it also OK if I take it via my tree which I then will include
> > in a pull request to arm-soc? An Acked-By tag would be nice to have.
>
> Sure you can add my ack-by:
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>

Thanks Jens and Herbert for providing acceptance to this patch-set.

-Sumit

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
