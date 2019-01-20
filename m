Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE348C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:51:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6752B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZKGG2FIU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C54ILMlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6752B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bEYhuHmzc8F3+1NNRSA1y6a8wvLlx3lP/q8RXQETDxc=; b=ZKGG2FIUmXN1Pr
	AWYPCdqerv5xcKjG9Yjk4tH1YJmz6+ZzdLdUIpFaL9fr6rqLFAoS8WkRvNP1iZjh1QhVG3nuolhw8
	91zyKwAExDYjPNErDQnGdXHvVjZwM0s1nO7h8/UwahaLnARQKwxA0Ws8Xqk2xNJPcL4hOeYwpA3h4
	yxrAvBnOTJ5H6lYfVFuFKNQfD5YZXFEFguzAAcZ1xawxQL320+lV+BsDuKXe1t0qwjaU9lC/st6ZY
	GcdN40bYBOPlTzUBkeKqq3phAplb/jFxHPzTKufpwYbUeVEbRw7rM9lZpkiDWvO0zhczLazulZpYG
	hbtNj1guvps/JZwFCZXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2Gn-0005ca-20; Sun, 20 Jan 2019 01:51:29 +0000
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2Gj-0005cE-CX
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 01:51:26 +0000
Received: by mail-vk1-xa41.google.com with SMTP id y14so3919129vkd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d7BbmGr0HTL3SKEnOU556dNzvnNLbzxMHiMhLjnBKNc=;
 b=C54ILMlN0B/CmULRDKjLs+2SS+11vlgTyMT0woHHxtNKrF7j+gexrtRHiYQcFiaEFf
 Y/CFhICif2VBLHCTSmIUlfPzpqhrUTQ/TU/xl6Id14HvCj6mDBiKjAosqGzkak/sx7jk
 y4FSCo75E3N2I4eJ34wie1YjaEAFmd/S7uOUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d7BbmGr0HTL3SKEnOU556dNzvnNLbzxMHiMhLjnBKNc=;
 b=n5hT/OsP3FGU0j19Bp5zDDGyGCJyG/Ud5n+Mbu2mZGZobzA4+CY3GyqE01avxj+ejK
 CgxnW/EBOiOapd7ZuJ51mDswReAnxLNs7cSy6SWWouLMUWTcTT86muApy2DgINw+FeNQ
 QfJZrxjuA1wGVTbh1rkp6jlMgupm0QPcZi4+D8K+h6/97jLXPWbnx6HThQvqqEp6imIJ
 kNKrBsVusNoiyxcmecomYei+INJfFFO/i8wku1ihJU/OWJIRaVnPLFp9m9mvcEAndeKE
 aA96QLqLzUVpKf5n4NLOYBraZVWIoG9I6mjg8h/NS5Ux+6B0tOd/cWULmYUzMscGwWmf
 x//A==
X-Gm-Message-State: AJcUukfR2WwVnLC+dc844ZpFmCHfOJ1JprbSEfVRHH43PBkEYZAUAbjG
 HrNb18QKwR4Nr62MdF0i/bl2i4FtbNE=
X-Google-Smtp-Source: ALg8bN7GGGKJn4RZrgGiFNWW3gCJV5CJHycRtB6cE1RsR9epW7a0GEvoc6Gz3bf+1TfQrIH6irlvNA==
X-Received: by 2002:a1f:f0d:: with SMTP id 13mr9788694vkp.21.1547949082005;
 Sat, 19 Jan 2019 17:51:22 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id n206sm67397586vkn.36.2019.01.19.17.51.21
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 17:51:21 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id b74so10695392vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 17:51:21 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr10540778vsc.48.1547949080517; 
 Sat, 19 Jan 2019 17:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 19 Jan 2019 17:51:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
Message-ID: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_175125_464130_E526BE8D 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 2:58 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> A couple of fixes to permit newer versions of GCC to use the stack
> protector plugin for ARM.
>
> Ard Biesheuvel (2):
>   gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
>   gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

Nice; thanks! It seems like these should go into -rc4, yes? I'll get
them queued up for Linus...

-Kees

>
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>


-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
