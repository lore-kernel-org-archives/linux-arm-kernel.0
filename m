Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CBC2F3BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA3E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WrQHFPWk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I96EHk/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA3E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TmI+lbNHmqL8mRpisKTlh9COKRjyGYQ1jNbIS19rcLU=; b=WrQHFPWkbcKdFg
	TVcGngIQttH6iQjTMuuga6HzcuY57h2bgE2dBd4MlFrIRARzzAk78ydTv1jQY5Evd7vWaGZ/eiIoh
	Y+7UoyI/81lG+l2fHUlh5eE2abz1Tsu8X3p0QzaLpTP1nq2Xx9PCKnQJHEzyLhNEpr4Y28vwpPWnu
	DQXLlWNaJlye0/lu9vRA19H1LI94L57u4ZtM6TtlKT02z/7T3eRijD512IB3VstytKA/oYiZKwY0Q
	uN41/wf8vIQXsdAthSuK4aA/JGE9Z1/h5N+DcSx3pr74grJpZ8+hUo9zOYl/wUiuq/ob0WqG76Mms
	v4bKsfIU1WHVE9WQoQlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZs6-0007Mb-6b; Mon, 21 Jan 2019 13:44:14 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZs2-0007ME-IR
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:44:11 +0000
Received: by mail-lf1-x141.google.com with SMTP id i26so15565485lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ralGJWswd1TGtJaKt0bea0r26/pHuHMB0v/9X22Diww=;
 b=I96EHk/ncc3VBmOVUJL3KGS98g8IAyKqu2LuLuVKMPlIZRX5h0XthcO4V6nyY2NUvF
 UKMR+XtJ2HAprjqgzVI/jAkJ4atKirmnVo9OR9BzfRWiiwGnNW9pdyoybpcKkam0bQi+
 FiFeMQnfN5Np2BDet21OGgZTm4i8M89ublADY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ralGJWswd1TGtJaKt0bea0r26/pHuHMB0v/9X22Diww=;
 b=VoGa1ccKehxaVIUew3ForFu+XS6YZ8/9eWHz5EgUdkwSs+ZL+3rsYqkEYAHOLVhDjj
 YsxvtD29GzdtjNa5zpm07ZHf8oUYVoGhv+mf3+lH2qbp2eOReurEhYlDQcX6b2DzNu0t
 hCQ05HI3LcPcW4iLgp3zaowXI6YMljXxhKnQRXfkuhttMELiLp3lMMhGQBT0XilIT/j2
 +u3rpd8G8KxjJEULlza9GgmYdyqC1JOqQyni4a+0e6WUIOnLRngWoq9HZTuJvxrMnLi2
 8BOrFow+Ubga7/MPejpkt+sbKG1Kx6hH8lmnb1geDmWdgaRhIXT/4+RWHFDLkIZ6/amA
 8n+w==
X-Gm-Message-State: AJcUukcRtFBWos3noijqzTbqlPrLSM7H+NxcESqwht7Fh4oAev6/3ixu
 uhVBLq/MF7kfCBq5GfMk5xcGP8Z93JOUquo2bQji2A==
X-Google-Smtp-Source: ALg8bN4av/J9eySUCzLNc5WL1DbXEijnajHS5mYVUr97SnXAodt01p2TWOxvaUVDfj5Z1gXJEOnIyTMFFWKMSOIwCdA=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17879386lfa.62.1548078248449; 
 Mon, 21 Jan 2019 05:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 14:43:56 +0100
Message-ID: <CACRpkdbKuAgG95ZB7-nuqPE4-gVdRix0tq0L8_u9UhS5G8xFGA@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
To: Souptick Joarder <jrdr.linux@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_054410_635791_FBED1B72 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, brajeswar.linux@gmail.com,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 7, 2019 at 6:15 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Remove linux/gpio/machine.h which is included more than once.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Patch applied as random cleanup to the GPIO tree.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
