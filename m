Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A8AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F51320844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FIM+bir+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9yia882"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F51320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zAvRbVakLJm3GUWim9NRIrxx3Fp96IogZZLJZXxXlHs=; b=FIM+bir+am73Fo
	nMoYNcGOyq9dYffuDAjSnRfVz8jwlE5mR3Ac6fzZlTBaAIcb4cRgrAg+hjGuTA1vnr4CBMCEmoTZv
	rWvQY95FXNljJUT8qlJ4S+ydvLRbjqRt/pGTywBsqqgnhulPMWSBqom4c9ENO85CV24CZOG7faUyG
	Sq4KpOkOOZpKKTvmryZO116FMeCZyIJI0VfXdVCQcZC2qL6lfKBus+FCaA7IiGMKGNDFy8d3jiNam
	WuMX4qx64faDQtINC2ioOZ6U26nOhSTW51xbYkoJJ7vBN3IkjzWEBIiKU6wS3XORmgVBJregPtsUK
	kspmwdhOdT3Knr2Yhg1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6Io-0007sH-4v; Fri, 08 Feb 2019 13:34:46 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6Ii-0007qY-06
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:34:44 +0000
Received: by mail-lf1-x143.google.com with SMTP id e27so2531097lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oVpF5CM4kmNqgD308Zd6OdbapiCMvc6nkYIh9QkfA1s=;
 b=D9yia882uReR1uWCds/eKVRffZcoVsnKUe8GFGv2OzDHs/BOzfBM+r/tfAJzXf1FN1
 97JBsaEa0RukmUx88UoHh9/awRA58L8slnXn83cRAaINkG/M6W2aMDeXVqBUSZRsFFtR
 +awEG3ilmGdjKl4UqTyAGVTQzs+/0z7rl2OVlev9AjjPWzWAUc3E98wPlDqTsz4vZ37h
 XCtjP3TPbtJd5XZnvpKJnXYyU+j2Lgmp4nY95EnZY8AZN210MBRd9rEIuPHaRq2KACCp
 1z3dpsXgmX4vBLcfrKvlGSdioduePRFg2F/Yh0e+bvOnwIAcWSOb78yVRgjxT2FDtGAq
 OiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oVpF5CM4kmNqgD308Zd6OdbapiCMvc6nkYIh9QkfA1s=;
 b=ZsO8zeeHkomroiUBnjtR2+u7d+5PaSh18wgFAGvjhqiULDyqMWh1X2TPN6mbRlrUpj
 X0oOmz49NrcmykA0ZvVg3cvPzAF0Cxwdo9L//pGUZywC6MLOC68Ai/dYqVOH68pG+0Fg
 aYnkXq72WI1bmmZdSaCFnVP9J3Rmv9dHLxL8QGS7Q78jQd83E7mosaqNyIDhmkFFeF3B
 gnx+LNoFiH12rsmYghwY/AyaUat1gxSlFW3HwSdyvthKGTXmTk0iiUJl74SvDtu15C4X
 Mbw3aVzafuGXUuCzum4W4Hj5qXxQEh/u9WhtEYbVyPGFmRullugB+JFL670jvcgoEQ2a
 //IA==
X-Gm-Message-State: AHQUAuYFvVGq/w6gHJ4TcD8gHzDrhClGLmd9FfAun5wDClZHsh10IbdT
 4/7fdYRhXCypIUaLApvTV4HHFc64TD836dmUzepcGg==
X-Google-Smtp-Source: AHgI3IZ99r3YTVCn5AyIyH5vFejioN4md+OJ7ebUTpZ8i/e5O9XdbeRnYkYn8YKjHtXkHi0C2wW0lJm1I3oyLgvv1Ls=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13206138lfe.168.1549632878369; 
 Fri, 08 Feb 2019 05:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20190205102546.29457-1-brgl@bgdev.pl>
 <20190205102546.29457-5-brgl@bgdev.pl>
In-Reply-To: <20190205102546.29457-5-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 14:34:27 +0100
Message-ID: <CACRpkda9M+MWxQnfkSbAXxdXjR0Ko41+rh+GbmNzJJTLn8Ptaw@mail.gmail.com>
Subject: Re: [PATCH 4/8] ARM: davinci: da830-evm: use gpio lookup entries for
 usb gpios
To: Bartosz Golaszewski <brgl@bgdev.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_053440_146983_92D620C4 
X-CRM114-Status: UNSURE (   8.56  )
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
Cc: Kevin Hilman <khilman@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 11:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add lookup entries for vbus and overcurrent gpios for da830-evm.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
