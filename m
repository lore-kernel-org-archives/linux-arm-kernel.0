Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A000E2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gpSGlPfu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YurVLAZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A000E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/5o7e3nShQknzXfUCC7vpVHjQivW0TjZLDV3PqDcUc=; b=gpSGlPfuyaf0k5
	Bgeq4GqJ4z7GYwr9sLogrGrqs9Tr+qQXjLTSHYIJpfZ7Vx6lEf631gnTfppkxSi/Ebkqn7fM+ntXh
	W4ZFLYj0AyUxBLDS9EJc8eVa5VV04nTPeEqH4uGyf0jF1L6E2gEdmI6K+fmQmGphM9tfY2KBRPQgh
	FipRiFSxlUe6zREZ06f0RDJ9qdjJTYgucZg3VbVIpj1evMDj2ztNtv/9XWSvKmEHTqPCODR99qUy0
	/ECIhgEqeCFWduFxlct+UyDMRyVpKdY7GGQ82msLBNiwYFOYReWGC0LL3YvdYpMHv8/9to036RNgi
	oIeQrBhf4UZHOaUGOS+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYKEA-0000zf-72; Sun, 16 Dec 2018 00:24:14 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYKE6-0000yc-DO
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 00:24:11 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so6903749lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 15 Dec 2018 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x/wXWijC5sXloSVHQvvLkkFGdyUckN6W9iO16EUSGP8=;
 b=YurVLAZ3QPt+RUAeLQqynWN2d22ySzTvG8Wa8q83VWnhASro/75edN0T2Nub4iecEl
 NWH5cywjkuc2Tkq8PcEnDN4hd7jClYJiqjX3a33jYwqj/mei/IlEy8KysTv3sXgZHIGC
 kCOuSwFk7h9Ox7BVD3IyN4vDQ/Gax6xKbm3Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x/wXWijC5sXloSVHQvvLkkFGdyUckN6W9iO16EUSGP8=;
 b=G2nzKSGsNMv9D7GfxASaL3bvnrZ4HUI2xrc22CE6aAe3S1MEMBrRsY42az8jy+i+Xn
 UD8pgaaHmcrJLczYoKUKGcJYvEDX//y9P8NSN/jfvlp94tDqg2ZC5myeLfO7J1W5J0DG
 waxNQTTLfLTHGr2A+ogYhqBezsJQIMU/hhR3lRDXFh8jELcRsC4fgE5Xogow8eAjC3gC
 syhv5gozZGioF7olYhbHbKUlqMtOuZNg0x0oTx7NVUa6UDPLcXIKZc2aEpendgLHLvTH
 YGk9qA7kKEe48JD69WfGlOmtLR6XU5DhYUVr5UNhKe0cHm8IVhWtLoW7QrvdBdKOeey4
 kRiQ==
X-Gm-Message-State: AA+aEWYZOK57d7JM5g/obtqe1Ed2eIfRXXgU2D22cZOEeqBRKy2+jLw2
 K6eFuwGwbpmv4Qcd4zu/+i22E2/R/5j99OUatzwPdw==
X-Google-Smtp-Source: AFSGD/XT4DcCs4J5DYsLcJjspPIaeJRfDEOYdNVXff6Xs0Xkm2SzbCfjKkdTKC2cGUDjaLbFS9sgO6EXHFgb5DQl3+M=
X-Received: by 2002:a19:4849:: with SMTP id v70mr4377570lfa.62.1544919838333; 
 Sat, 15 Dec 2018 16:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20181211000506.7559-1-natechancellor@gmail.com>
In-Reply-To: <20181211000506.7559-1-natechancellor@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Dec 2018 01:23:46 +0100
Message-ID: <CACRpkdYH9VDjzpH90X=gTKAnw1guGG3uUjDmUXcSkBxg=6LgyA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_162410_452414_02C59DE1 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 1:05 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang does not support this option:
>
> warning: unknown warning option '-Woverride-init'; did you mean
> '-Woverride-module'? [-Wunknown-warning-option]
> 1 warning generated.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied with the ACKs!

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
