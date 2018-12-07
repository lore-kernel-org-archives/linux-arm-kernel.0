Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BC4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D3620700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ddxOTeIt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkqX12io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D3620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B1jzAFI/A/I2EO+/A39vdKSh8KXJf6nsa+qQLM/vtqs=; b=ddxOTeIt7UAUEb
	IDwA2w6LSZGKPFrZpnHV7tOPGv9XIU1D/uud1LUzFkNUmvRAJuWeacjRBAKlVvRmg7Ls2VBhMhrin
	vCt28HAEjrWKomvcTwsx6sA3JHhvgjn0caebcM9ZKCNTa9w420MdqcV3x/o2Jt4dCTYkuGdoZsVx6
	gL8blJ4Q3K1WZ/xSFAHadle/AfMQGeTjvWiAlkfgkXjTLD3wNRBeTm2S+Yu6lreNetYbSQK4hriy7
	fvI/X5x9u1Pxxo0qN5a8j5T1oWy0ExKiUatBJ1AQ8MC+8yv3oCB+wfKdIasWT0w9hrzq88yJ0F06C
	eiT7BJFMvrwRQrJ0nrsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDAI-0007Cg-Uf; Fri, 07 Dec 2018 10:15:22 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDA7-0005f6-F8
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:15:16 +0000
Received: by mail-lj1-x241.google.com with SMTP id 83-v6so3048953ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=peLIgHYKKTA7dIqpQ26Gw2DjM++Zd4zFlvCxar8cRYc=;
 b=EkqX12iov10HSOjhssc4KP6Ie9AeHwoR2YdqyLIkAKNsn+VKvC4bybPzHaOvguFsRa
 +Vz2xAnAQpubZGil2I9XqwIy31SaVhvEBcUre6kB+BYMc9y8f+E0k3v/4CBn/EvdCzmh
 90BsjRB/qtqzxZZ1cQjE8okW5ie82f91FkqwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=peLIgHYKKTA7dIqpQ26Gw2DjM++Zd4zFlvCxar8cRYc=;
 b=R4oUgvcBwE/A1F3bicT7YQzjcXrPdfboQ2GYMVac5dGwVqL2tTBgETA0ldX3V3TScW
 zVl/j+ZFdamlEscIva8hVIGKB05GEj4C6SL0zvH25GvpTDf5eQ7rQ0np6370VViOZl2U
 DpEQ4qT9RrX35twV6RH5oVYyPaG9OGZ+YZvS1W+PZ3/yzIQyUo42tvMUBr/L3QiNFCWH
 mCpgnkWakh/JaZCP4V3YHWyhc0fGa5XJtsvTkaRErOZ/9nU5cw8x2qfkx/CfWd2+B034
 HLkF4qXHCH5GHFGO2d3+tZ2Az9iUr0GJxwu7NLW9vHxECkeGPPy+WZZv6yiPGFlh0LNr
 0vmQ==
X-Gm-Message-State: AA+aEWYCWJJsgGVp6RgM7lAwMaMvO0usaLKHz+QAMI4FFCAkhiwlPWUI
 +sWDfU9oRX0EYbBI0q7qLK4C82UgbPl/HiaRGSKn/A==
X-Google-Smtp-Source: AFSGD/WheBNyGjmroCARhdQ7mJaYuaJOU+buIUj0eizCTWr+nNfasEraccTyxHKER+HgZgSLfdb98uN+pmoYNOrw/8g=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr968851ljj.9.1544177699253; 
 Fri, 07 Dec 2018 02:14:59 -0800 (PST)
MIME-Version: 1.0
References: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 11:14:47 +0100
Message-ID: <CACRpkdYp8mT2cXVP6hKmopMmHrzugVjTS_0=-qLo8F7y7Um_ng@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: pl061: handle failed allocations
To: Nicholas Mc Guire <hofrat@osadl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_021511_763615_D384D92E 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 1:03 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kzalloc(), devm_kstrdup() and devm_kasprintf() all can
> fail internal allocation and return NULL. Using any of the assigned
> objects without checking is not safe. As this is early in the boot
> phase and these allocations really should not fail, any failure here
> is probably an indication of a more serious issue so it makes little
> sense to try and rollback the previous allocated resources or try to
> continue;  but rather the probe function is simply exited with -ENOMEM.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")

Looks good to me so patch applied to my Integrator tree
for fixes.

Yours,
Liinus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
