Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714ABC2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:02:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B0C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sbmPJiCS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJ5tiIEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B0C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hOIET4EfezgZI8hs2Oab6LG9ASnHCqA93QneCQqEGNI=; b=sbmPJiCSrzZT0n
	VttCxuTo/deyljZvjN01joxKbvBKTGcMgQUknASVwJ2YYpGLTrArVqkpNkF1H/+6w1NpQAF9DFbH/
	j/ZAIjyoPIyoLBsSJsQQOlVZGDYjSt5XHYArpmRMhSYDz8Nq8qkx3CkcgcD5wTt6fMOcZMlIPUkbl
	iDk5D3SEgcN/stKQkO/qawoLVt9glfsgbRJovDbP6aVYpi3yzK5uZlijd4QFTpmK0oealCWACSoKe
	4SJrbbaDdmsmOY4rCOFAnB5H3M8jnPmB9Wm2SGhilCT9SwfBv6MVqVI6RLV74QymG4kDDRDwoZfw0
	Im4NTGo3N2Hg+SYfIC+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZDE-0005zC-0H; Mon, 21 Jan 2019 13:02:00 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZD6-0005yQ-SX
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:01:58 +0000
Received: by mail-vs1-xe43.google.com with SMTP id y27so12581988vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 05:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WcXKw3tln6cCIZGWmfJGYgvfvIKxnArHOSuU7Sy6vk4=;
 b=jJ5tiIEwojgea0IMirl4ZZ2klzafv8OxfUSpJSUMA2+BMCbOQyQecwk0VDwy6DfASW
 7Nu900FJaDGI5mLgsoYmGbUotiuMCj0qKvOUa6lkXPFOdsfa1KY6iNSOkdmtPW20UjEW
 0EOg0r8AYjpCWyYuiTIW9MigEFbWzq/MhmsSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WcXKw3tln6cCIZGWmfJGYgvfvIKxnArHOSuU7Sy6vk4=;
 b=LXj5sZWJWaa5oaJiy6sJI55hNirNhqsOxCr4RJ4uer/TxF8gqh9P4JEyyNVvm49M9J
 Y5GWoONhuHvzVykHIuNtF4wiS1Ih+CzRgF6tYM32jRnmBbldegdxebO6aFi1TofKwdKQ
 P8a09U5oEqYogwlMXnCur0Q+6GFD1E+G7cO8VOXkIDFTjmWTN4aT86n+cgpPXpjJz5R+
 XxtvqweKs2WM+5pPS3htKLsCOh+EqAH2s9dorcDlJZGOHn03IH8L2YViRW2CeJkooP+/
 hiOYiGhAMsDitmwZvqKKW3TAqu312WLq9FtWf6cXyfENcFBGgRMjvIi4aoo4VRa6I9Q7
 hiBA==
X-Gm-Message-State: AJcUukf7bXS55mlhG9jDIaxnw24puggGVYaNmy05fwmbEIWIkxEGB0VF
 XYVcNVYCpkK307uTvk7OIWmnWioULKeqie919bbiFA==
X-Google-Smtp-Source: ALg8bN7KPWGvFKB1VM6/Q6NVeLs952Cy8JgKYM9wr6XXv2/phFh3Ifgw5WR4JL0+A9HpJJahVYgK9TO4ie7/0x4HpMg=
X-Received: by 2002:a67:7614:: with SMTP id r20mr11902024vsc.89.1548075711380; 
 Mon, 21 Jan 2019 05:01:51 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
 <20190121103026.GB15590@kroah.com>
 <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com>
 <20190121104651.GA27442@kroah.com>
In-Reply-To: <20190121104651.GA27442@kroah.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 21 Jan 2019 18:31:40 +0530
Message-ID: <CAFA6WYNi9Thbnaq8TZbyh=dOzXLSKA3MtTLnDYM-=2fFcoKzYA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_050152_916751_7B054AAE 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:16, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 11:43:14AM +0100, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > @@ -0,0 +1,272 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >
> > > Nice, but:
> > >
> > > <snip>
> > >
> > > > +MODULE_LICENSE("GPL");
> > >
> > > This string means "GPL2+", you need "GPLv2" here instead.
> > >
> >
> > I think you need a space there: "GPL v2" or it doesn't get picked up
> > correctly (or at least, it didn't use to)
>
> Sorry, yes, see I even got it wrong :)
>
> The correct strings are in include/linux/module.h
>

Ok will correct license as:

+MODULE_LICENSE("GPL v2");

-Sumit

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
