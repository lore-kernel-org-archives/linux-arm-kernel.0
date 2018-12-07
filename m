Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D09C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:46:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E582083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="inF84lVB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZpnHsgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMYf7QXn6+iIVdzRAXy/ujBUpC3lS9IZF+DqI3hNphw=; b=inF84lVBqmJXH3
	3+Dj8QXCLWPEmL9Z6woFwwp2kMRjZNRN/VFXXQ11ztvNk5a1VYs9x5cOG5HduVQ7HuQVtPKLU/11X
	gf0h3t45I01i9Y0ksp6MdzegQc5P17YdTcfdKNPuTg0mr6RHauGIZJ8ndTC4wmeQx2V2G5x3DfkTR
	GjA0D58oydXHczAu3m3IM056Wd8NrsGwJG7omnFgjvCn0/78ZiS9oltQISDAfbxoQdziM+gpnx5gL
	Y+nWPO1co4OvMyDr6Krg1jL2O3DNYR45TR7o3q+Ry2hmxNnjgUOWEWLz4W4aV8lPPVSyfGNb9qJgz
	n5chXrWxtUu0tZgtl1Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCik-0001UK-Ba; Fri, 07 Dec 2018 09:46:54 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCig-0001Sl-2D
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:46:52 +0000
Received: by mail-lf1-x141.google.com with SMTP id a16so2568315lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jHFzK1kA205KsPcDSSgpBTJ2wwL+eQOeFE1VMWe3mBA=;
 b=hZpnHsgmjta5vss2x7dc2xlO7wb+CJ4XXGbvUTjeAAC31awC85WCQdFeWIyb+bn452
 V2XhKJZEi3iv9vLjQJOrRyCFC5WTO80OL7XlrZvjjKGquFQbMdacX+5qBgLQddJnKVXz
 2t7pGkVlJb87mmla8I2SZ5K8qArZP1xvAWovo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jHFzK1kA205KsPcDSSgpBTJ2wwL+eQOeFE1VMWe3mBA=;
 b=OuEiIcGkerfoEPI54WRJwhr01ZQEZK0zHyz88UVwp33uzZOUxTqlPN3a27kx23R5po
 eA7MY7WKdQZo/yahPRI4tYrC1mL9A2+pomYCvJvQTBaVzS9/6SSbNzVimanus7nng0XS
 WvU5eqdc9Yv88C7q5E3sGR/Zx4EVKTDtyKsPh6TUC/CVYJitxqQWCL0mMOHSy8GUBzZp
 BXNbrZLFBEhT4HZ58atgLM5nXYVap29EFgPuDqYcS1JEOzmCaxauiYrl0ZioPWwNV78k
 vACXzpSw4Ga+AycE7D9wcYhj0HzYLHVzJT1SvGzKW3AoWqDn0fx1GqOabUxnQAIi/iLb
 7+mg==
X-Gm-Message-State: AA+aEWZkHoeN1wq0qanyM6H/yGjBeTkCNY6RShTz+DjpRuXvezYEBbr0
 Q4VNtZ0ZneAswERCq1OMYiXuafbhGiWNmNC4gMbrlg==
X-Google-Smtp-Source: AFSGD/WKpWdhsfTk/yslSmFbJk8reKO3YhH3cOmh1dj2xlDkz6BSlClMYWdAOe6/Bwuik9oSjrPPtMjEUAqyqFjPCyE=
X-Received: by 2002:a19:4849:: with SMTP id v70mr893570lfa.62.1544175998063;
 Fri, 07 Dec 2018 01:46:38 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 10:46:26 +0100
Message-ID: <CACRpkdbsXHj=5uZNcJyxYNGhTeF3KhOyHaFgC8_DtTD8mRwynA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mt7621: report failure of devm_kasprintf()
To: Nicholas Mc Guire <hofrat@osadl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_014650_111855_6D3D313C 
X-CRM114-Status: UNSURE (   8.99  )
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
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 7:12 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> kasprintf() may return NULL on failure of internal allocation thus the
> assigned  label  is not safe if not explicitly checked. On error
> mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> (unlikely) failure case should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")

Patch applied with Bartosz and Sean's tags.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
