Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:41:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F1B2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rbyqC+f6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIEq9qSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehaQWXzRCFgbIv5FCreom1dW0jRPbNcawmAgJTYcLBs=; b=rbyqC+f6KVf8YK
	s0juYuixEArVwIJ6Jm/CT6Shyc/CpMHAA8pg9yNr07P02CcRLW397rgsp1pS4pQpjAEm6lHf+pU4I
	KlWub1xsu9szfsqr7iaMv+CDah76xCr4IxWdDb04VQwHQkMJSYoKQeejweBEkltTDimevkMd859ym
	ps/TZlRpfMh6nqKHWeonW4tPjvf55XW5ZcQsfDJ44CSHe+qpZ7J870fB7Og2hC0XwRY1tpd98qezW
	4r0DiJQym921S6gi2VfCHBsxAhh1eF2GsYCZEbGdUAqoLtTva/j4ozgI2VuF0vgIFUyrAg0IuRQIo
	MwhRKSCDrjAA5kx6Gasw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVlHe-0004d6-Jb; Sat, 08 Dec 2018 22:41:14 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVlHa-0004cY-T8
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:41:12 +0000
Received: by mail-lj1-x231.google.com with SMTP id v15-v6so6451277ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6yflozu/UHOPbAK/HmtOVTq3aALTm+DO2J4VmJBlny0=;
 b=cIEq9qSmr2ZdObihRPMElNeGh4EiPdhgBNGDzhSNajmo2SGxVoqOrSOXlaSZkLIFOr
 JSo/zgGPHSi6hbx+JmjdhA3GzAv/e3RTxJvav2ewZP33hQh0bmX9c65fjcCRPVvL8+Yz
 rcUPGOwMeIF4NnMAe5QzgrKl2Qn4QYZ7cfZAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6yflozu/UHOPbAK/HmtOVTq3aALTm+DO2J4VmJBlny0=;
 b=hvoBiN6iFwQ1IEIHc4tFcL0wfuJsVn3KN/Jj4z8WmjLdFbBCQ0354/1jwcrdJA3u43
 6FP+KLII7tD4SSwxI8lu27sUwoTDR+pLlDlZurwV3KAgec41AkqeP8O8H7vuS3PTO2cN
 GrG5MGSIxLLJLHBpAwUbAlzECFduPvTNieoSZR8Xge+RV+M0YeUpFopydwYzd/dC8YY+
 QSgtsjHuR5x9UHwFZnqJg0Xk6MJmUUa0uQKJUbxPNNiZ5QsNIWzJOjSwalrnNS7BCqul
 T/iOIUmwTxTpQ3zj7vKC8lO/PuKzYZYlhYIpsw4x0uEbffNp9jXcI9+iy16Qsw3FtzwP
 4P5A==
X-Gm-Message-State: AA+aEWYY0SWgjljg8ex0+F63bS3Gtl2VPo6EAAOnNtTJQMBp8JAb6AOM
 Nei1dPmXfXPUlnq3ElcCrpByFjZI+UH2jYDvae/E5Q==
X-Google-Smtp-Source: AFSGD/VZQnVSfMxCaIsPiIWkpa2dCR/HiAoMV4R59eLmlYBn8+Qk6TZGkWn3ggW/A4E0yaKnz4yS98cUNCgl3V8qQVE=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr4046788ljc.97.1544308858546; 
 Sat, 08 Dec 2018 14:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 8 Dec 2018 23:40:46 +0100
Message-ID: <CACRpkdbVdVyOBMDsqHxFuONVo6qD20OGecVjpAv_LtnX1QOqPA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_144110_948020_B1AED102 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 ext Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 11:33 PM Rob Herring <robh@kernel.org> wrote:

> Here's an updated mapping filled out with the rest of the platforms
> and using SoC family names in some cases as discussed.

This looks really good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

>The move is
> completely scripted now including include fixups (though any new
> includes could break things). So mainly just need to bikeshed the
> directory mapping.

I did have a serious minute to think over whether this was a
bikeshedding type discussion and the outcome is as unimportant
as the color of some bikeshed. Went as far as to re-read Parsons
(hilarious!) original essay and the first chapter of Wittgensteins
Tractatus. I concluded it was more profound than that for several
reasons.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
