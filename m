Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C5FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E763D222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RDvEytNV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udO5+wPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E763D222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rnh63XHdYaV8PJSGBd3MyLQryxPHMQjF6XBDBd5Q9N0=; b=RDvEytNVK+L//1
	VMMBMoS9k/4cu2vbCbRBbJFLkDlB0SwN6Cq67d7Fa2f9N+lthGG4QsKwsN2EKVr6bjmQLwJc6cFnX
	fDY5StqRVODLYKD32Lziup8L/iq026u5Lfz6kgo8CantXZTW+GUp4FIcelhN+nybZuIUdm7T6pCqO
	1dAVNjNP8jBGReZsnVFpucWlmTBQGUqomNrAAlCPRnpU2PnZieHwQpJu+nmJg2+cEivtk4E9wQNTs
	xOuGlBG5/cc1eo4bOFMMdmhBoqF1tRB6gT4ucaTDIXGwQfYHuni7gday9wATa9leSgBSMXWPH6EwP
	jiNSp2Nn5noeXOpCUawg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu6Ga-0006RH-Qr; Thu, 14 Feb 2019 01:56:44 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu6GX-0006Qs-KV
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 01:56:43 +0000
Received: by mail-lj1-x244.google.com with SMTP id z25-v6so3779205ljk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 17:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vE7YI1+jpF5FB3wbYkt2nJv6AYL+YBfSQ5+TzTwVsl8=;
 b=udO5+wPIBTYdeajBV3p4KSC/1FuLKSpWJCvhBUHybjbZb3ocibgFiZ4Joxz2x9Hqw1
 yptzru6jRDGlhRtSICAV+cKObWDdzc/EOJoCBnFV1QfBarZIKbpQFqjeKnbRkHNqRfry
 w93BZv5DjX7kZ0aDDMa1njMIpMD0okjODVS9ozP7VTzavUPkDaf4wtUFYsNfhL/aS12V
 jHoOimqFtP5wc6toyUaiuvs7oillZKsunxW27SXflyYVJqCxc9i/gh3o4r6cqfkVT5dX
 Pfl2JpEADQGhAMIZb2qYEEhBeJIm3+svBlTKa+IksFvtoL4oFl7mxU0FWKjeJP/AFR/e
 AeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vE7YI1+jpF5FB3wbYkt2nJv6AYL+YBfSQ5+TzTwVsl8=;
 b=DYW5dl9RFRd3pLpORV2ozEF/+B9ScBSRHQpbIjA1r5pJkZyDIW6f4leGvN4s+rMPgO
 1MjWueJyyT9/mhjC88NcL4Xi26iGEvIWNcGdsj3fdHWi3OlrhgMPfm+fCyLcYzlL1Ggw
 M/KU/C/9IKjwELsoTqAElox89AKn+AipcEbjk6iQbApXXAPXmTvrTqRCCo5cS2W3UjwI
 F6CdZRzy19jkGHE/H/2lXqpdB8FPWxYpIrYVGdV4wZC+qQjBjDfSQS+4xJXFMOR2o46w
 Q1lGRCzFZxDsgZcKNDYWrXQ1BuzY2JsxNX4AnF0OOdGqKVZ7eOW9eQllOjysSwFhcZqp
 8x/w==
X-Gm-Message-State: AHQUAuZNr3jWKcfPRgdEg6nlwi0sEY9TTxpQ7jQzt4i2rptghLbAEs+K
 nqum1cH//rKquG9SsdPEszySisx5YCw7TEktseHokQ==
X-Google-Smtp-Source: AHgI3IYknKajOolFCf7n/uhfd3liGBSlNzqLUCIzka1X1PZK1LiUPGgVFObyELcOutHdWysAZsIKXEG6xUxmkmgcwWk=
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr693138lji.90.1550109398924; 
 Wed, 13 Feb 2019 17:56:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org>
 <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
 <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
In-Reply-To: <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 14 Feb 2019 09:56:26 +0800
Message-ID: <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_175641_794475_D73DF349 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 13 Feb 2019 at 22:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Remove wildcard compatible string.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
>
> Looks good to me. It does break using the new dtb file on older kernels,
> but I suppose this is not a case we care much about yet on your
> platform, given that both the dts file sand the drivers in the
> kernel are still  work in progress.

Right. Thanks for your reviewing.

>
> I had started the other reply I just sent before I saw this new mail.
>
>     Arnd



-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
