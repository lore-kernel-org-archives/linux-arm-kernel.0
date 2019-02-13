Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49077C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:30:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165872082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKHvkNlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K+U4CqOoc6NJO4Dfua8jQuAg7h0MQlCS32gg94Tmrqs=; b=TKHvkNlJ5VfPtq
	J8VVtC1X8Q7H6d6Pqqj2a6TM549J9asGWtcRP6IiVWvvbfs1ZTx41o9/Oov1ANqyPgoz4mBTc4OoB
	3NcdeibEoELw+erHltpLfhvLQL9L5CRySg693vmTD7+Ca5ct3wdirHPhZ9hkMXzk4D/IGGCrS7Z6r
	WzuqoFm9mXLfv39e64cFII/S/w5KR49IgvOWGxxt/gWbe2s3O3wc6aVZW9XV0VWOT8NLnBe1cs7g+
	mk1elaGI7InnQ2yFGU7uSVOPLbUGzeEywH8KAJthOwVvB3pR7m1iA1juvKxvgSDtxrjsrljvKqyDC
	xTiR1zGjBHqpHpXjM4Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu32V-0000z3-CQ; Wed, 13 Feb 2019 22:29:59 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu32R-0000yT-65
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:29:56 +0000
Received: by mail-ot1-f65.google.com with SMTP id i5so7144099oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZOO8W4sPhEmShu7hGha8/Nl7mLjvHcJawMwQNvDVgVI=;
 b=PDgWb3ZUL7sUziyhO60piJHTB9TYC8DvWzcCLeDgXm1Hf+73YZdfkDUKsu5X5vvWoe
 zELRmgtBEQStoMELhjmssYCzZ8zH/7FHLOzdn9h7pXPGOIvNoqRMizToiZf89j0+TF0k
 t+eNM5pohCC2EnmFqGTfdsAc87Nl6oXx71ummq5pL5041QmWtdavikxzU/6v4030pO7h
 Fe+Sf94ViFmEyQjMmUNcL4VDOzUK1WXR75hKjZkDUDysEpAaqhkhoLI9cKHacFE6gbAE
 R9yBF4EIgJo6JzfvvsuGmTYt5/6V3h6j0xI0NxqM0L7rJX4iyb8wFl4f5kJR0LzpLOqc
 KI/A==
X-Gm-Message-State: AHQUAuYPqh2PA+2GnNRmPiM0BRCVAgYL8e+Ek8dof8okVYjX9b09W/in
 ljZMF1VlRnSdP/yQwbZaTA==
X-Google-Smtp-Source: AHgI3IZcl27xOnyAtGs6JS+C2FHBrJftx6A7Stbp1qG3cn9Q+uZpwZ05ftqwdFUhhjB54wP1IK6kpg==
X-Received: by 2002:a9d:760f:: with SMTP id k15mr280478otl.149.1550096994368; 
 Wed, 13 Feb 2019 14:29:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q26sm240441otf.73.2019.02.13.14.29.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 14:29:53 -0800 (PST)
Date: Wed, 13 Feb 2019 16:29:52 -0600
From: Rob Herring <robh@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Message-ID: <20190213222952.GA4814@bogus>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
 <23f5f2f0-79b8-b9f7-9f46-972966563596@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23f5f2f0-79b8-b9f7-9f46-972966563596@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_142955_251720_877EA4B0 
X-CRM114-Status: GOOD (  19.55  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 03:34:23PM +0000, Marc Zyngier wrote:
> On 31/01/2019 08:03, Aisheng Dong wrote:
> > One irqsteer channel can support up to 8 output interrupts.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v2->v3:
> >  * fix a typo
> > v1->v2:
> >  * remove one unnecessary note.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 6d0a41b..582991c 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -6,8 +6,9 @@ Required properties:
> >  	- "fsl,imx8m-irqsteer"
> >  	- "fsl,imx-irqsteer"
> >  - reg: Physical base address and size of registers.
> > -- interrupts: Should contain the parent interrupt line used to multiplex the
> > -  input interrupts.
> > +- interrupts: Should contain the up to 8 parent interrupt lines used to
> > +  multiplex the input interrupts. They should be specified sequentially
> > +  from output 0 to 7.
> >  - clocks: Should contain one clock for entry in clock-names
> >    see Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  - clock-names:
> > 
> 
> I'd like an Ack from a DT person, as this is a change to an existing
> binding.

It's fine as long as old kernels ignore extra entries and new kernels 
still support a single entry. Otherwise, it needs a explanation.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
