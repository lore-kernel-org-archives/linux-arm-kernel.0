Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70749C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:12:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5F0217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="caujfHTy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyDdC/7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5F0217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yyj8ZPnpYR6mlNtBLMpZ24oiNh1mih7gwcjduLd/0JU=; b=caujfHTyxuKeof
	xka8/AMOBR1n7UnR3P3dXRE+PhKMwIC8FlM8pbIZJBwXpX0+YzIK+KDlP7vLUT+hLA3UT8VuwTn7o
	nY6Idj8fIwQ0kDWF+bkt7mKz1O+MeZ60xq8JBRZHDJ9eBOXTUlL00A3dYkwb4Fq4bCTQkHKiFA7hT
	oZ0B9HRZrBOVs4/Ic6bucNVmu1o6tHoe9/r1I/i/sziJDQfikcXOMG2z9IcInzE5TDbAZVd9El1R4
	/qkIlt5YUZmJSwOsH5m8AblnuB1PbDEbpQeYyzTPeTfdMYUL2eAEEfTEFhbw+9Euj6PadY1WzlrMd
	yjmzh81gmGVY9vkWl2IQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs51Z-0000PA-54; Fri, 08 Feb 2019 12:12:53 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs51U-0000LW-IA
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:12:50 +0000
Received: by mail-lf1-x141.google.com with SMTP id j1so2341718lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qfhTtiMDaKURe0aPAjfU33h8QzgqP7sz0JOiIA836Pw=;
 b=vyDdC/7xXJqvvnbBU7ak1cq1nz0n8/Q1I5s5wGAZocOYjLtLvrsNKvYjJFGXBQyxU0
 aJJrfX6CBpZOO4nazDg7VY1tZxuIAIbjtwRglDyyxUhb00kyy0gYmNkhmD9JosENrkDH
 tomUBXhTjZfe7/k6L+YbAIJFHTErk2Y+nFG5cchDHFbGCqq77HSHJOSKd8KA5o0CGrK5
 1NG/ObB63ofAM6xN1bUqhzBdsKX7bUw49DkaG9YRij4THu9n/i2BnmzFCUxfCqZJeO+M
 Gq7gOXn6MmBC0vB2tcrak3dqtW0olI6TgJLQqtH9XJZX/b02x76uR7Nrsq7tE8tGIJnF
 vP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qfhTtiMDaKURe0aPAjfU33h8QzgqP7sz0JOiIA836Pw=;
 b=KW3n46prExl8O3FXaS6s2DYSitFdUnGQX1wAdDcgL6Opk1LIQnMZhOo/Bo4ei7P4sT
 bPsZiAe+ta0/nEQJHcNGWCcFSNL/xOYw43bix/wm+tFaJqlUSnaEgAUdf/V/SqyPxRQG
 jvW/6Ttuf6qd6Ui81oLDeARb1lWgEPxlhGlzcaIvMe2RVoSDF7irdklG63XG+zt2nTHc
 OLwEMemUzzkqcsuVkUuiWJaTmLRB19HTiI9W4CjkB2B77sW4LtO20PP0PpvkJWwM77lI
 NTyM+xJO2JiJ6eNKjUEjUdZdCgYGkT1CTgiBWS4PmUqojeE1nnMK9J6ngBvrSVEB/XjB
 SMAg==
X-Gm-Message-State: AHQUAuZ0O7eQNXjjIxBn1FXMIuh40wIsngpKuwII/A7RvhII0cFnG1hB
 5oZefeLohb61Co+ufbv5zvKrl0T/SeGD2Ds2sXbuBQ==
X-Google-Smtp-Source: AHgI3IbSSUzbwgsSx/Yrrhvag6JYXDQtoOD1qLU4Mot44kqyFzhUd3DBrUJrFxv4cj1ArBsmXqBA7DI6QxfgvY6/oPk=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr12129920lfl.129.1549627966313; 
 Fri, 08 Feb 2019 04:12:46 -0800 (PST)
MIME-Version: 1.0
References: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
 <1549198954-4711-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1549198954-4711-2-git-send-email-stefan.wahren@i2se.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 13:12:34 +0100
Message-ID: <CACRpkdZSURNfxgYGMU2tC7rKMzMEQQZcEV=MVJMpPLg54hzKow@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] pinctrl: bcm2835: declare pin config as generic
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_041248_608899_F644AEB5 
X-CRM114-Status: UNSURE (   9.48  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 2:03 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Since commit 0de704955ee44 ("pinctrl: bcm2835: Add support for
> generic pinctrl binding") this driver is capable to use the generic
> interface. So declare this accordingly.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
