Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D5F2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ayPgYx7Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVPuTtR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D5F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kn3hXkOGaIx/9buAUgMKAI0jE2BxLx8MRkDZo8RdMjw=; b=ayPgYx7Z8/MGmc
	yXRlojdCIz9qI0JGCyc4BljDLnSPfXZAR3RPFunEXhzfRzZRHy0He3GGrOkF7sYOveyckmNG67xCR
	49Xqg2zIVJtj4zUpqExugsb5xiy44keLQoRVqVbtNLCqLEpEblAd3t279Iz8txTR4faaxGKq2iX6f
	dQkBWUQfpMF5aVUhNjcPt5k7VB3IR7GLELpCCnxQmpCKoj7ZgBsxyDmp5Yz1BNTW5CeXB8gl9q70u
	lQTNtBUvanOCdjUpvXOrdWvFi/a44SrYVcowfjEb4ZiACj6/3IHBKHOZV37MN6V3ZLSO2nkAInJve
	/SLYBUdQKeXXTZ/yWOcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxw4-00036h-JR; Fri, 11 Jan 2019 14:37:24 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxw0-00035x-VJ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:37:22 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so13148289ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iiz7Wr5zV9F15CaqgmTVT3cwFrrlab1AeDN8mYEG4jo=;
 b=WVPuTtR/ndViS6PFHzXI9F1Drm5p2L4SAy8RtXsWyB+IcFpKeV/f1qWP9JMP82GGw5
 RPW+cQWj5JQxdsJ+3HbaYZUgmZl7C7N4Qt4NLFQX+oriYnlFY5bvDNiu9AQ3wCMeBlGW
 h9n68eEY8zgkvZdiWaHvAaKNV2MWJcZxjXxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iiz7Wr5zV9F15CaqgmTVT3cwFrrlab1AeDN8mYEG4jo=;
 b=dGDx5KNuWWe3bwqhHgH+eWFuW5Z0BrSRWDhyhS5bJDk8FO/cnWlqyTEZ+DkhObyfcx
 b4zM7yj06GbhqTllGBKHw6wk4126YoRgxyHr16/yArxVQDPrDkg8HLbm1/oVNeqMA6v6
 YPc3yFV2pyvCzk9D8qLLHRVlUliNjPAOalGV1gQvu9wzXbmNO5FQo60/PuZO9mKlF5XW
 KTWhjEIYpU85sn3R2ReYUlv6OvASaKR/+tMzhMAVe413f+kxuCvj3tSdbzASskPOoYEv
 CnB4tByCb2IMgWBRBeeaV9NpbV0NkdhBVF7yszwgchknZ1LsUf9OXXzrGNeAltHa7jeC
 bQ8A==
X-Gm-Message-State: AJcUuketsfEMzMqwxmc8TLHLwdxtbvT2NdJ3fOamlZCw5Az2qmYxclCo
 xik4NAgiw/BuCbf6UGjLa0oG5BPB2YlO4g3E8KCn/Q==
X-Google-Smtp-Source: ALg8bN7eohjr6xkd+13r3SWcDb/8yGYqS1LG43RZFSuqfWoXCaXwLMfVkvAytlhCZ8ADpSaOyOAkaJZwRmsxv0jMZvY=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8758978ljc.97.1547217438950; 
 Fri, 11 Jan 2019 06:37:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
 <20190107164210.3ecf37e8@windsurf>
 <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
 <20190111135413.73dad0b2@windsurf>
In-Reply-To: <20190111135413.73dad0b2@windsurf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 15:37:07 +0100
Message-ID: <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_063721_008872_984E86F8 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Josh Cartwright <josh.cartwright@ni.com>,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Nava kishore Manne <navam@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>, Borsodi Petr <Petr.Borsodi@i.cz>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Shubhrajyoti Datta <shubhraj@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 1:54 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:
>
> > My stance is that the driver is responsible of enabling and managing
> > runtime PM for its hardware block(s).
> >
> > Runtime PM in the core should only be added if the core needs to
> > be aware about it, such as is the case when e.g. a block device
> > needs to drain its write buffer before going to runtime sleep.
> >
> > I fail so see why the GPIO core need to be aware about this.
>
> In this very same thread at
> https://www.spinics.net/lists/arm-kernel/msg600515.html, you kind of
> proposed to handle this in the core in fact :-) Though indeed you said
> that the core could provide helpers.

Yeah allright, I have never been good with consistency but what I guess
I would mean to say (today) is that the driver needs to be in the driver
seat (heh) and opting in to any runtime PM support.

This is in contrast with "midlayer" where all drivers are forced to behave
"as if" they had runtime PM (i.e. calls are done to the runtime PM helpers
even if the device doesn't really activate runtime PM).

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
