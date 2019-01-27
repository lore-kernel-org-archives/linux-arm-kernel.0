Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA78C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199772147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyGCG8/7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Q/OGFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199772147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A2yClmXA5YMaUZsMhv5+nLMw0FB4yxAsw64JOmY9ds4=; b=dyGCG8/7uCD4B8
	EZgGsgac+8vVbscYlz/aRwinafSEeqJtsClpee62pjN+d3TbbATAMAMkIKnfMFwE2sFfnkfjCGetD
	3/sBzumC1nWA47udDZmEiPorg4zYMLw+RQtnVfILyVakxAS6x+hjGuxw9QMb4+70AeKUudLK2QpT0
	yCYcI/hofxyI8ipyQzueUkUkqAZVEDrFz9sdRY2m0buD0m8qqTRrYaeTMCJjbu+5OFDhedO7WUgh+
	l8OJbP9JtZLUbK9zQRSLz40EPokrGVSBCywESHhXc1hDCD7W4O0v3ptuTyxxZLeEnw7ge/1y71IXH
	UxW13B0DwOvA6qVS4wOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnl48-0004jl-2M; Sun, 27 Jan 2019 14:05:40 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnl44-0004jR-AP
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:05:38 +0000
Received: by mail-io1-xd42.google.com with SMTP id c2so11311406iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eBDXSPPE8rbUIbTQbMP7QKuhbhBWsipIQGdKvkjV/u8=;
 b=a4Q/OGFfu+oaoFzwaKj++e8BiN9GJ+tuKIUNTVpx//3IhJzHdm8o4UBVO+v9Q1VzPe
 LUQcDUjr+WVQEyk4CSLdYJrUfmVhNxi43qN08YfTSbadB/uZBo0jmQ1Ritl8sP4ns+SV
 xwkxrYlVN5q2t22rrMx9sIyBIUExhmYdB/taAcRTA5PEWjCm0fYTGJSz0JnQ4suCJCz3
 GUqLet7BDk3ORlHOEQ+xJk7703m21LnIArnbfgfAH2xJ6o8czu1YdohGfS/hwyRM83yS
 i0r/cF2nnYj+tO97/jHlwgIT40jPR8cMZINC2BrgiWHBfCo4AP+TSG4aD0AttLLOwOyv
 /jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eBDXSPPE8rbUIbTQbMP7QKuhbhBWsipIQGdKvkjV/u8=;
 b=nETbdUELd6sXelwwz2wI4VTG/+5LArpnxxVNBI+Ba/o1jVZk0fIN33qvxoOCnnbORZ
 zmLf2m7JvmTrTV3E9RELNj+cDb34TGNyGciZd0oszGicDwqMsF1V2EdScy9MERNEnKwj
 o+SYyUCeapoapoN8Zg+Aa1l48YSGT4khElgMwuUvY4ovaWn3lif7V/Q9eU/vepkZiQVI
 UXe0kPiG2gjjaIdrvTW2hsFC88qMAKaz0LhQLevbKm1IMW7hF1/tMNrEoyzWRWPNYWoI
 n953CvGTppUAWjMEaDGGGkZt1N0nKfA02qtFEuQAWl/s7jOUzeiJXuMzcczm8EeESq+o
 OvLw==
X-Gm-Message-State: AHQUAuZbN4kQFqNiqbvV+851v3Tqb0xSphaxkdInJ+tzRMIGZGv3Yni0
 9952cQ6c1eM4ITQp0yp1taNsINjCe7654w07pk4=
X-Google-Smtp-Source: ALg8bN4u5a7DdbPqpWKdyk4/kXY65NEPnJsUJAcJF+K4XKWXYxu2JDBLVdQkuXhnqH8p/9vrx6G9p/SwqYMNgk2d1ao=
X-Received: by 2002:a5d:9913:: with SMTP id x19mr9070391iol.99.1548597935061; 
 Sun, 27 Jan 2019 06:05:35 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-3-git-send-email-aisheng.dong@nxp.com>
 <1548413169.28802.43.camel@pengutronix.de>
In-Reply-To: <1548413169.28802.43.camel@pengutronix.de>
From: Dong Aisheng <dongas86@gmail.com>
Date: Sun, 27 Jan 2019 22:05:23 +0800
Message-ID: <CAA+hA=QsbQ7k-5aXyWCM+Fss5nc7yr5=CRC3Uo+5r67Da5Pg6g@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_060536_357430_A7A2BEC2 
X-CRM114-Status: GOOD (  16.50  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 6:47 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index eaabcda..beeed4a 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -6,8 +6,9 @@ Required properties:
> > >     - "fsl,imx8m-irqsteer"
> > >     - "fsl,imx-irqsteer"
> >  - reg: Physical base address and size of registers.
> > -- interrupts: Should contain the parent interrupt line used to multiplex the
> > -  input interrupts.
> > +- interrupts: Should contain the up to 8 parent interrupt lines used to
> > +  multiplex the input interrupts. They should be sepcified seqencially
> > +  from output 0 to 7. NOTE at least one output interrupt has to be specified.
>
> I don't think the note clarifies anything. Given that the thing is a
> irq multiplexer I don't think anyone expects that you could get away
> with no output irq.
>

Sound reasonable to me.
I will remove the note and keep other as it is.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
