Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2433CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:04:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A122082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFSLBbLY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtmdYMIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A122082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hfebwgdCiZ0xVmL+1jqWxyPy+Upjy9ji7gWXeHQfIvY=; b=rFSLBbLYCTwLgm
	P/Wqa3puJUyjjHAYsAeVNWxMQdhwg9cmG6jCt38y+93Yf4QvypV6glBuUpaSAYGrtHlCIF4PAoewE
	hhmP9aEdMsxOT+yFDD13gE32Te7OOs/8lkOdpahA4Ei+aheg34y9+nvJAlaNG8rInQ/t2/2uakrf+
	Av32/Utem0h9AF88vc5aTaqBr0IpE3rfW0SJFDr0yalU1MKCONToDloQmpWK35vKSsioEQp/SjPeN
	rmAWBuRTkxn3oTyylnPj9MIBBgmH3TM86cSTJM47qVZo0biJXcxMO7bE9EXXp+JKpZ/jRq/7oiAqc
	FGrnYt/YUKtOcuZlBjVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeL6-0006Pv-UW; Wed, 05 Dec 2018 21:04:12 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeL3-0006Dh-LZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:04:11 +0000
Received: by mail-lf1-x136.google.com with SMTP id z13so15791112lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BDocB82a5DX9SNJkvtkw9I7rZtirRs1Yp4NtDpjbKT0=;
 b=YtmdYMIN6g/+POZuSuL+H75ugukRnnXkDptCR5QKdsvLaZE81wh1cORrWY/CAW78Hj
 U2pxlLXo9BjWU2ldhL1KkajZKIie1c09DBpeG6L3YBTrRMGYmrYiQITUC3bFNt8vmDfQ
 5lHYjGjWWvvdBmxNF3PZhwUjViUEftV+4Ibkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BDocB82a5DX9SNJkvtkw9I7rZtirRs1Yp4NtDpjbKT0=;
 b=Tv8hm4nz3Q9vXW8YcyyP+5cJKCjmXpHVDZLIbj7DGVyV7uPW1RVe6DKlWKqQzu1090
 2oOnQohulBOHG6HvPq4T/ITQHuGemdW2rhLFqmJb+P178k//pt5FV+oBMlORO4jNucle
 5c+eK9pLcm6hZ78B5+12LbS/PAJabKtGqZyzbMB/nV8BbXbdD3GGrn1fhuwGF6pduuh4
 zU0DmmgAS0nlAEa+g5Ho2dXJ9lrcOP44XcRGYpBMuggaRupwglFhj4Dor1CPd0uLTn78
 /HSceKXj1r7zsSPwB1Vjx0qrPQbrryKiB1uBvyMBumLaysIvYw08X864N/Z6HoRwiTdU
 YQNA==
X-Gm-Message-State: AA+aEWacgAUc11hoWrD4Bn54OCMn4OH8U1ueTpINQ1LtYjkCMOuGtreF
 uipXvxuqzVxrVR6gBfGmvV3TPK+YrWC7Tf7fh1PJ+Q==
X-Google-Smtp-Source: AFSGD/Xw8I+oRzv8PGYbqHmje7WJWTG8x+fi1WDbeZ+y2XejC7HKERk74KcvWwUEJxKXISXtkxbniCta5NiMM83dbnI=
X-Received: by 2002:a19:789:: with SMTP id 131mr12197631lfh.11.1544043837366; 
 Wed, 05 Dec 2018 13:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Dec 2018 22:03:44 +0100
Message-ID: <CACRpkdbFnPeDeZyHRP5qOuoafDbE1bW9s_zB3EzXu8tb=kKdVA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_130409_708531_229B5B26 
X-CRM114-Status: GOOD (  13.83  )
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
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 4:02 PM Rob Herring <robh@kernel.org> wrote:

> We are already use vendors for arm64 (except for the oddball exynos),
> so if we change arm, we shouldn't do something different. EBBR is also
> going with vendor for firmware directories in the EFI system
> partition. Speak up if you want to change that before 1.0.

I don't think there is a silver bullet for this, except "use vendor
or whatever makes most sense", like if in doubt use vendor but
no need to overspecify. Rough consensus, not perfect consensus.

> All I really care about here is things are organized by maintainers.
> Someone care to write a script to ensure all 1800 files have a
> maintainer attached to them (that is not me)?

OK why not let the maintainers choose the name of the subdir
rather than insist to set it to $vendor? Just consistency?

For the stuff I maintain please use:

    'arm-' : 'arm',
    'integ' : 'arm',
    've' : 'arm',

These are fine.

Drop this

-    'gemini' : 'cortina',

Just use the "gemini" prefix.
Because this was three different vendors so let's stick with the
SoC codename.

And for 'ste' I would use 'st-ericsson' or 'stericsson' (also a valid
vendor) so it is readable.

It's no super-big deal so if you think my view is just annoying I
am not going to persist, I will just get over it.

Thanks,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
