Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74091C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5E6218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/Dv1FDT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gndZI216"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E6218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g1vcZZiLVYrYHhw0GjF0GI9Hawrbak+TGIooEDIxIQA=; b=D/Dv1FDTF4EpYA
	STvjPsvIWo/18nEG/8oegdhqKTRBp8Q+vhN3A2rYSs/YF+Y6o9VkK67270viinA2maPogzOwC9avY
	W9ExJS6/AOSejNZawapDg8X/j7654fCoHfCK4a8SsJpKag47vQcCT4fF7VcnAjN55V19QDGIi/sBz
	6Sruf7cHuTo3YpNLYgRT0TTD9GO3ohNwTQY2FqVxNyjgpXMSiJeVx7PL8DB5DhHyHCKAAPzTWeQZq
	sJnLqxiKVaGD1pN0ACcH0sfK7UOGjh8nWUpthcwCdyE6hv9Q32TJZL52rRxaTN2Wm/Casxl4kAtn0
	/SgPJgH8v2a00WJvd12g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs52Q-0000nu-5r; Fri, 08 Feb 2019 12:13:46 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs52N-0000na-BH
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:13:44 +0000
Received: by mail-lj1-x243.google.com with SMTP id v15-v6so2745015ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N/IG/9wqZtS39xJlRa38m4WHs+osHMphVTDahg9SM1Q=;
 b=gndZI216swTQB1tPggVX67N6F2mI/Up4SCE4LAeQaDebDrYZYrH5H2O0PFr0CZ5xYt
 schdq3tDTdwE7uooFmzOJLBtgFPkAkhnwwgbxejnOf/+eIf0CHJemwEzR2D7rrYs/t5f
 kOOoFrMX6m3JxdmCcrWXwDm/oMSzL+EodG0fPGQQVgCBoEJ4sJiZHa8vrJq8N+ocL5xw
 Fvu8NUBnVaXJn9JGgsjPagFctS6aYDQ3phqTeyIMOw8a08oqW0X9TL+xCxP8wKEmUWxb
 IwNVZh4rQ3a2gTenB1KP1CBQ29/7wPFCBjSDJ8Ya337r5Z/OoMOKKbdZsXPxa4uepFeu
 ksQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N/IG/9wqZtS39xJlRa38m4WHs+osHMphVTDahg9SM1Q=;
 b=hXpDcwoRsWoH/Zx5zvf9CNfxmoPHZIG6Iry36NlazDLJbfGldPr158tBUb6Fz6xwkW
 nx5bvWfLISfwk4Z6ajvRi736fDQDwodQI2gYKxPvY1Lsg2zi3mlT3FkXQt9fdcwUM5uw
 MTLbVosL354hlSy8gIwwPJwL85EFBP5/awajyJ1WufMyeDjPZJ8nJbnEW3RjVxa6JbCq
 YT2Eydzz6hppHCt6MQT5KJqmj+wGGJtUJoDo2hf16OOhc5vX7m1eeSBDH1VYZiXTYSDM
 m1up7hckBKa5hE66yE/sIpKLtmBI4Fopqn/cs3VwDncO6IRb7hIqbgn5ngaqOjgvtc1D
 bTjw==
X-Gm-Message-State: AHQUAuYNZ4IKbqQFfyApSLnfQMM9VG1HDnWA2JEctcEfgHOxwl5bYN4I
 IfaTiiZfigjhtebM51MnKm18qfJCRNS0Zy6Gbz5hX6ky
X-Google-Smtp-Source: AHgI3IYFIomAvrNEWylbG1EzyVuDW1x1Vw6Ue041+V5n023evRXuZwNVy1DTe6K3W+BVhhv8TcgNrppxUyVBHVHQVU4=
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr13505023ljb.153.1549628021704; 
 Fri, 08 Feb 2019 04:13:41 -0800 (PST)
MIME-Version: 1.0
References: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
 <1549198954-4711-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1549198954-4711-3-git-send-email-stefan.wahren@i2se.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 13:13:30 +0100
Message-ID: <CACRpkdZzywMnP49pyUgobr8YmiyoV6g3Jiq1ft+NEQFnR3gbEA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] pinctrl: bcm2835: Direct GPIO config changes to
 generic pinctrl
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_041343_380337_BFF180AF 
X-CRM114-Status: UNSURE (   9.35  )
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

> In order to support GPIO config changes direct these to the generic pinctrl.
> This also requires an adjust of the return code for unsupported parameter
> otherwise gpiod_configure_flags wont work as expected.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
