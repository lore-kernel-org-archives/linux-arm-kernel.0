Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952E220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tS5bGnMr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nOlliuJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952E220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ts5IkA2PrvzIYfNhODwkuYliSuTNC2RkZ3/23FEUFOc=; b=tS5bGnMrHbDW/C
	N/OTUrhh9PXeX8tRjDoeAF/zZrU43RYMODNwm1dIIV4fyHtAVl9XcwXk7uRKzoEt3Y2xt6ahX7/qG
	A0eqGrmyLnpJUV7QWjYXTPyb7m4NaUL9+1Ff2HxZcm031HOGnwDQBFJO/7U0n6zlbs8/02nEWm/LR
	rGF+uKNYWsR6jhwxrts57BLTkm2ELa2uy880z21Nw3r7jzJb661GMpraAQC8a0O/pM790Dj1B0QpH
	OCdZmgTyeCA/zZ9U4LPSXShlucP1e4Bbt3u7fLF7zLBXxD3Exqjfu8HyHpKMNcEdsWmpG2VE4oyHq
	9T86TXBhjJZOTiDkno9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVjJ-00035U-9p; Tue, 11 Dec 2018 00:16:53 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVjF-00030U-H8
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:16:51 +0000
Received: by mail-qt1-x842.google.com with SMTP id z16so14552995qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lUA5hrXlIPzcqsAb57iWBPxcQU9q1UY/9t3+Q87F8rI=;
 b=nOlliuJ+36iQuU8OyLbis31HPU/sb2nLYzZ9hHzDOEO+u3XNUw8OTtydijAS91iocK
 NVK9TbvC7l5Bv7TvIES2Udpka9zWj4NDapUkl6cyR/D4Q36JHN8icbA3+sibTHfhzp4+
 38gZ9A/Q/SQ/V2iEIKhUYb7cbPOmfyJpEjdMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lUA5hrXlIPzcqsAb57iWBPxcQU9q1UY/9t3+Q87F8rI=;
 b=SpGnyuXtxsubIJnKL575okFLAYl4FdQW/shkww9wAmM0IYXnEAGwygYQvvCu8oqYKJ
 vDCUrv+DXfPHOlcfklM8tqNLELh6ZP4ctQ6cUgO51t6U23LO0dAzUpem1oHMDuMGYZET
 nl8+izvNO9gIhf2B6ONZed9iglrsu032zfdNqWcY/76TYBgKHT/XZzgaHBxJTQb40+Us
 JAuO50y6241qEz69ZDE28YQwxWwlEQE3fBOCHM89cNHvztVUWuGgTe5A2OTwMpJ/n2mI
 /Wif8T2TuGtvp4vtqxOtIS6w2jGF9pE0206ir7FaGJZ3rYLrXbwGyswGmVK9pMHX4ynq
 blzQ==
X-Gm-Message-State: AA+aEWZvw6yDUv0VH2MTG8Xw8Hc10orQmAsl1E+YvzPXC+WXpU9OIHf2
 1DRWR47/mTV9tXwsNYUeZRFr43GtKLK2fW2FjC8=
X-Google-Smtp-Source: AFSGD/W2IxTQZWkg3O2ArVt75llI5ya9ZbFYqNdFskY03Mlejkj1bvvwc4EyOowziXdz34nBySd29IrMvlnrpvG583s=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr13878203qts.266.1544487397841; 
 Mon, 10 Dec 2018 16:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20181211000506.7559-1-natechancellor@gmail.com>
 <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
In-Reply-To: <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 11 Dec 2018 10:46:26 +1030
Message-ID: <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
To: Andrew Jeffery <andrew@aj.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_161649_751994_5C85C783 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: linux-aspeed@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-gpio@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 at 10:40, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> > Clang does not support this option:
> >
> > warning: unknown warning option '-Woverride-init'; did you mean
> > '-Woverride-module'? [-Wunknown-warning-option]
> > 1 warning generated.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Thanks Nathan.

Andrew explained to me that this warning helps find bugs when
developing the complicated (some would say crazy) set of macros that
this pinctrl driver uses. It would be good to have this warning
available in clang. Do we have a clang issue opened for that?

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
