Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD74C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5EE2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QyEoiktM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twHREtIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5EE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TTeZt5I2XyrOiiWprhWRE0jzDOX1faWPdF1KHiqx8go=; b=QyEoiktMK4yA6s
	MhccbTmrSYI9LfmXBfWN91Lwl8TTlxTKBijfO9QzFi7J+FEKJCW4nZAQkh+/Z1rxNZHccdP9a9mu/
	6d2yhqbkAMuk8uHcNB1bF9cuKSLWc4HC9xTKzWN5Xf/KYG/i9Ws5lvRxcsxYk+R2eTzVhLjJalS6k
	AxQihiQSaPGbSwLZVbBv3E34YDq2ifZFfeHKGNVE1uqsDRKMXja1wKJTfOWfd4M24qLFs3InkrJKJ
	o4hdsSTT4mftFtydp8qf7MglgTxkwZdLOCi7+dgC2+SEB2c3tKKJowiQlJoB5jM0FnLiWLwyUqAd6
	HZlufHByPMQR51AAScxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwOOA-0003IX-L6; Wed, 20 Feb 2019 09:42:02 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOO6-0003HL-8L
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:41:59 +0000
Received: by mail-lj1-x243.google.com with SMTP id s5-v6so20145948ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=coW99miv52Oebix0UpxqugpmQqA6e89avvbbbDjxFyE=;
 b=twHREtIo4ImtaX/cgoO1GofFO3Mv3V2td0STXWoNTH6MfzJgQFY1EgUoEc/E6YRf3A
 +oy7QZLbd/8YXVqodIsf+MkfoLauf6jDvStSd5HQRPVCSJxYZvbzg+AMjka1MD5fLpBH
 1AZe0Pbx0ACYsLs54ZY3G2H30cmSvb4LQwstsxPnR5+Wt8ijIR8bTLeZ9T4qIVKt5ucG
 Wn4oCz6FOrAlpQvHaoz7URC1OJtPjHFQx+KqaGdDGKFDQ5Q7Gd0jJ4F6pXMsLr0m56ui
 vcEvC1KM8fwcdqRHMa7EN4BvcIe24hYo4D4gmxmE73fwX5vIEZdOLSgF4ZlEB+IhYvk1
 fxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=coW99miv52Oebix0UpxqugpmQqA6e89avvbbbDjxFyE=;
 b=BJoDqsjKoZb9onr6MBKAgsNT7dD3F5vyWB2qokiOCDOthANuimhxunYI9v7SDIKDVH
 RanMdi21rnOGEsA0CVMrFIec90cxkt0wxthCF8C1W3mnWjDGQ+RMNiqg93NrC0598G5j
 FwHi8nKFZIbaXbhb1Bc7aoRdCsVeFEbk6R3AFrmTPpUIZH7Mrn56bBkGYsD2pm/nFHqb
 Qv2yEuKC7Wc4wfv3NE3ST2aXg8MJW0Zbfdvd9MRkGZhiwmJbYx3eWB/NbiomRecaoYaM
 QzXfO//zkDQ3utSGel3R3q7Ts8PIoDve+2Z5fY1EJca97gZooouVeVGnBHX6V/l8BVsd
 A98w==
X-Gm-Message-State: AHQUAuZyevpLu2K2BEu0diXhiYKWiGo7Xtft/1O0WuH0lQ9BoGKMk9CL
 la+smxcWsWG3Wni5qD3oMA/YgU0KqMJnTLoYFMVC5w==
X-Google-Smtp-Source: AHgI3IbUqbLT+SRx4BO45Bm00sPCeH8GZZhxXBS14tqNdIXqzSEl8UfNJ21vroYjYvAFj9IW9ozMDa4HJ8otsw1IF8k=
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr19804106ljb.126.1550655715094; 
 Wed, 20 Feb 2019 01:41:55 -0800 (PST)
MIME-Version: 1.0
References: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Feb 2019 10:41:43 +0100
Message-ID: <CACRpkdbaBzRZTea4nmm8b-wt9iUipPLaY1MbaAKEPxoY+HFVjA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl STM32 updates
To: Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_014158_367910_C66216D6 
X-CRM114-Status: UNSURE (   8.05  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 5:54 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Please find 2 updates for STM32 pinctrl driver:
>
>  -Fix a memory leak issue present since the beginning of the driver.
>  -Handle error case when a hwspinlock can't get locked.

Patches applied for v5.1.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
