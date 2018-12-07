Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42431C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="roTby2w8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAA44A41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bGwiXsqgOutMhfdMsrdFPJVCW884x4TP+cJNNoIUEEM=; b=roTby2w8OcVU8i
	sNZDjL5QTMLjJ4bHBpDbscu7sfQzniphJdx98KygjqUBBLzjIL/WV3wzGicUdjTQ+ZrQ7QLCdK64O
	YjGYXaN6/pvucFu7tltSRC0jZxlH7OylNtFewugE1SMUxsJAhZqS57MgrjjsbWTVYRlx1J97FwHWa
	kdvHr/J6GgphuHxNNWZbEglus/OZTL/B4PHxMsnOD+2EXJ+KsxNg7xs/yRJYDB/fzdiiHxCxqMqkJ
	dOT3rjtuGs3m2sXngpIM4kft+isJkyn7GxBBsGlAfKeaVNnx3iD6riatvizPX/xprLhq80fWaxPw4
	TIbnmh7jFAC+HUqwtvFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI6o-0008Am-GB; Fri, 07 Dec 2018 15:32:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI4y-0005FB-Jt
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:30:25 +0000
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADCE520673
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  7 Dec 2018 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544196601;
 bh=sFLTWfaY5J9p4hL3leAGyBYEWVq05zeSIzrmA2RR60o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qAA44A41JkBoyjbWThUJj00x1Wd4h6IKceQn0NY6hVLBLUuolehewofsx4aTJtAsH
 VDsiy9CwSrfu2dG7pIzXEfum/dHB649c/TnjI+aon8p5LLyU/F+DAP1bRpyZyDEvj+
 b9cikLR+gdhWpEvrtaw99zj6CJTdKRUDjn5ePm7U=
Received: by mail-qk1-f174.google.com with SMTP id w204so2628379qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:30:01 -0800 (PST)
X-Gm-Message-State: AA+aEWarom3KItcIt09lna66YfF/XlQSQMJ+8LblKhuYMMkETaQZEmrF
 Q7nOwgn9Of6geza45CkUFGiXV0ElhopDrcjWtA==
X-Google-Smtp-Source: AFSGD/Ww5AcRyWgKJ6aHgdTS+VdU586SeGolcUq84NAyV0MHUgU51zqRhGkdBJFwj6Z4Bbri3yJQRX4SnrpNPRUsOqg=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr2184403qkg.184.1544196600886; 
 Fri, 07 Dec 2018 07:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
 <20181206200652.GB3084@sirena.org.uk>
 <CAL_JsqJuH4=Bq9ok3Trz4GgLam7gqWW5-gyHpG1XbShtQQuSJg@mail.gmail.com>
 <20181207151625.GC6510@sirena.org.uk>
In-Reply-To: <20181207151625.GC6510@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Fri, 7 Dec 2018 09:29:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXQQZtOAZymvJZxLY-hjOqA8Zb80uHua2ps+LwTz3w0Q@mail.gmail.com>
Message-ID: <CAL_JsqJXQQZtOAZymvJZxLY-hjOqA8Zb80uHua2ps+LwTz3w0Q@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_073012_972858_E3CC974E 
X-CRM114-Status: GOOD (  15.27  )
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
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tom Rini <trini@konsulko.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Alexander Graf <agraf@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 9:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Dec 07, 2018 at 08:57:06AM -0600, Rob Herring wrote:
> > On Thu, Dec 6, 2018 at 2:07 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > The issues with the existing install_dtbs sounded unrelated to this.
>
> > Maybe, what are the issues? We can't change the source layout
> > transparently if dtbs_install is not being used.
>
> I thought that was the thing with adding -@ so overlays could be used?

I don't think so as that is during building, not install. Any user can
set '-@' with 'make DTC_FLAGS="-@" ...' already. The issue with that
was changing the default globally and no way to set per platform. Now
that I think about, moving the sources to subdirs may allow setting
DTC_FLAGS per subdir which may be good enough.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
