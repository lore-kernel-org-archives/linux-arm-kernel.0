Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9CE21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mGL6MPBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9CE21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BlJ5Dgx+Pcw3daUPbCP9RW38sbcnrsdMNMzbl4wQqyk=; b=mGL6MPBsQWP74j
	0PPlJEglXsuYTsDc/C10LWu1RMhREfcb0iF7ejAhiCjkSaxes44HoAsS6TeXtHu+sjAdDPODL7nHL
	K9xlCmy0JRLuBMkSD1+X3ZleGexwPXkb2g1hljBZF6X1Qy6yUCcjBRoVbBJKlws0AiTsb4VFYvRpZ
	A9Ekn0aBAhKWJ6GokwyyHxEz7KV5A2ddjOtfMc3TJVlzpdjHip75dY1ZQI0LWf2vYu4qXBSMOY+/h
	JTI+3z3M48vX1Yhv7ANfIXfpNVs7W27q+M1oCsixGjGxn9N0Jh8myy1ATdGOKVmuSLvU0Go6o3P19
	APzPazdIdHR9/RQ8q+dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2zi-00081X-1L; Wed, 13 Feb 2019 22:27:06 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2zf-000814-1C
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:27:04 +0000
Received: by mail-ot1-f66.google.com with SMTP id b3so7176025otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zAn8RFeQYoLA8lxdBOQ25WWJzWNjXK8/90SeqULz5do=;
 b=Af9wfGFZq15haEvHqHGH9OinRCIQELhKPEqPtCVFSco6ZiYlsi1kFzuPZvQVwybJx7
 PSRwLSZZhqwZ6qvtDOEc66r+buoj6DrZ8nXpqiwCr//6TjfGvklodr1fZKpPqKyVE1DC
 3ditfsC1OLcuRBuBtgvaFrhf7bVlyNEaJmN3g3IUVN9rKArL+NEThwnkNln9UIdCwKGx
 LUEKqozDPZvYDCclEM3COy0NOHrtgGoBODkz7D9QqV+nHQiVkKIX1uVxV3TE/PwgQxjO
 8CI6a5j7S4h39pdLIgBjY5sUifGHgujtIPbBQN5ArH/AzO8HFH7nJidXG3WqPfY/Zqkq
 Vh1Q==
X-Gm-Message-State: AHQUAuYeQnKexOkKkBgJLeTdUMY2u1aAzuwa1bAddLBSO8Rru+BUx/r9
 NDayC7MSqpXvHMs+kS83Ig==
X-Google-Smtp-Source: AHgI3IY1w0jGZPfw9gk40cpNCv0rluNp25L/EsIfQHhfwG7lBjisOVZ5fKSIdWO0x6Ix13pVtGjftQ==
X-Received: by 2002:a9d:6954:: with SMTP id p20mr267567oto.261.1550096821987; 
 Wed, 13 Feb 2019 14:27:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d7sm215956otq.27.2019.02.13.14.27.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 14:27:01 -0800 (PST)
Date: Wed, 13 Feb 2019 16:27:00 -0600
From: Rob Herring <robh@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Message-ID: <20190213222700.GA31052@bogus>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-2-git-send-email-aisheng.dong@nxp.com>
 <8db40cd7-7695-0267-c626-26ebe086b2b8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8db40cd7-7695-0267-c626-26ebe086b2b8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_142703_074536_9AB1A164 
X-CRM114-Status: GOOD (  22.79  )
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

On Mon, Feb 11, 2019 at 03:35:40PM +0000, Marc Zyngier wrote:
> On 31/01/2019 08:03, Aisheng Dong wrote:
> > Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> > imx8qxp and imx8qm subsystems supports only 32 interrupts.
> > 
> > As the IP integration parameters are Channel number and interrupts number,
> > let's use fsl,irqs-num to represents how many interrupts supported
> > by this irqsteer channel.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> >  v1->v2:
> >   * change property name fsl,irqs-per-chan to fsl,num-irqs.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 45790ce..6d0a41b 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -16,8 +16,8 @@ Required properties:
> >  - #interrupt-cells: Specifies the number of cells needed to encode an
> >    interrupt source. The value must be 1.
> >  - fsl,channel: The output channel that all input IRQs should be steered into.
> > -- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
> > -  Each group manages 64 input interrupts.
> > +- fsl,num-irqs: Number of input interrupts of this channel.
> > +  Should be multiple of 32 input interrupts and up to 512 interrupts.
> >  
> >  Example:
> >  
> > @@ -28,7 +28,7 @@ Example:
> >  		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> >  		clock-names = "ipg";
> >  		fsl,channel = <0>;
> > -		fsl,irq-groups = <1>;
> > +		fsl,num-irqs = <64>;
> >  		interrupt-controller;
> >  		#interrupt-cells = <1>;
> >  	};
> > 
> 
> This is a change to an existing binding, so I'd need the Ack from a DT
> maintainer before I can queue this.

The DT maintainer doesn't care as long as there's an explanation that 
says it's breaking compatibility and why it is okay to do so. This one 
doesn't do that.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
