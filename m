Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FBC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4205620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZdDecB6o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAOhbBPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4205620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=skarYyCP7B2B7+aNdmdquJK3H1JLJGZR2PId9gnDBPw=; b=ZdDecB6owG+kku
	GfZi7/GbM3OFKt73tNGxqGoOYHhZ+zyFCDXpYrdliApI/+EFAP8vRUA1wWrSXZR/GhkndwXIRkWqc
	6+KJl9Q/2hl9wN7owE/Qeea5j/PfxLmy2+U7D+4H1Sc1oPNHo/T7X3vojbLLdgjmmCgg8whpDFpEl
	aDWKDNGOSveeImlkPRO0AJgxNFk2XwvB1L/01gzI7jN4/loQ6nuY1EdqXhLwEtF+e9L+Y+S2EtPyU
	EP6D8IjGAH7M/nLHoXko9iUzEpF4jxqApveN42Qi2Alozu0dn3HW3zFgyooQOp0nWgoddcDbQLbGB
	lEgBnPoFhvKdM0R9uSaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSds-0003TM-CN; Thu, 29 Nov 2018 20:10:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSdp-0003Sd-VM
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:10:31 +0000
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28BD020868
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543522219;
 bh=l3y/Pa7QbB/jxzNs6T36jjuYp2MsBXNCED2Af92s8iw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IAOhbBPAE563c5ixAE3VS2vyD6yA8Tf6K7kiOlGxCOs5qScvaUVDZO0gZQjTrxgCR
 S9+eBzbJwXhwNuHfCj+3q0WiKHt9lRVl8mARvDttAuCi4HocNHQpJEkRgtQHH7CmUP
 AcxJO5qSMr4BAgnMt60yrKtWPmDP9rr7PDlvGTjo=
Received: by mail-qt1-f175.google.com with SMTP id d19so3445308qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:10:19 -0800 (PST)
X-Gm-Message-State: AA+aEWbDi93/XhDv20vm5w1r+KKb2AwMkfTVwbhVQxNsZ/Uo47bY7f/z
 O8Ham/VjzE+ivCwfR5UZZ9/zm3z5wYyL6DpOhQ==
X-Google-Smtp-Source: AFSGD/XBRU+eQEJIm3AzvMNlD8GhVaIMnoX/gd2x66PrpbukkWstgCViLEg2KLd4FAxg7XBYyd6biIC40A8VmZS+moc=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr2836617qve.246.1543522218431; 
 Thu, 29 Nov 2018 12:10:18 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
 <20180912023902.GA28239@dragon>
 <CAOMZO5AgrUEqTUwXEm4vkkaDKZs2Yzi7gVYR4MXAN1KsqTz7OA@mail.gmail.com>
In-Reply-To: <CAOMZO5AgrUEqTUwXEm4vkkaDKZs2Yzi7gVYR4MXAN1KsqTz7OA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Nov 2018 14:10:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvwyY4GzNei-n945KywgoWgmNVCO8LfEF7XjZZAfQzSw@mail.gmail.com>
Message-ID: <CAL_JsqJvwyY4GzNei-n945KywgoWgmNVCO8LfEF7XjZZAfQzSw@mail.gmail.com>
Subject: Re: i.MX DT memory nodes
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_121030_030190_DE4106B3 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Sep 11, 2018 at 9:54 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shawn,
>
> On Tue, Sep 11, 2018 at 11:39 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, Sep 11, 2018 at 04:54:40PM -0500, Rob Herring wrote:
> >> It appears that many i.MX platforms have duplicate, incomplete memory
> >> nodes with both "memory" and "memory@<addr>" nodes. Are you all aware
> >> of this? Plan to fix it? I guess u-boot fixes things enough to work.
> >
> > @Fabio, it seems that the most of them are caused by the empty 'memory'
> > node in <soc>.dtsi.  Can these be removed now?
>
> Yes, I will follow Rob's suggestion and will try to come with a fix.

Still going to do this?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
