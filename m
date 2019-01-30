Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C942720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S9chtZ/D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag78r9d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C942720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DdnN4+2liMPrb9ns4WIOzJU4Grn9tyU4CZaZxIuBPrM=; b=S9chtZ/DLWdRb9
	nnJBifdwM4PoPAoPh4G+U2uo80e7n1M9b1AHmi2ROS5HkOB9Jr4rYLMKKDdZSdxxK6Vykg4DJoZix
	Sxirc6+xtvxBu4VXT09q/6PDVWM42GmMUB2TJd7VR4k2QIhai4lYQqNO6ZhO4ZhXRHUq7faszPnHL
	zihIUTwpMkhEtPGsekIWOqe2CdxQ1QInoIhYKD93sOQntS0eHTfE5Zl0oYcFEPiTjYvrX+AxKj5rI
	VwJeOR/uK2J46yNGsrThmSCTD7IOmJLIqm77SDoTsUxu/Y/tCWuETvkh7TeNFrSN7de7Gma5Jjgft
	pkTRdiHb+vbW7k6S6IJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goq09-00021W-GW; Wed, 30 Jan 2019 13:34:01 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goq07-000211-18
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:34:00 +0000
Received: by mail-it1-x141.google.com with SMTP id z7so10256229iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S5cdkgdNcTluzV7ErxQTrVc9Y3rcoh9266HOxln35YM=;
 b=ag78r9d/QsJ13JJIVBoHbqFQpbVFDFl6I7YTCK8t2LwUWuWvCWExXiS6Y6gEILKlEy
 IyDOHYwM5LVl/9isIBc6o9OnU9420uaohazlV9gjSFScT2EXtVAry1uuxDWlY5X8baPC
 Qc8cykr2v5OargLzg7Plpr9sjTIYYIuja9I8f/ja0XbM6RFc4Qh5ArumUnPWGhHL9/P9
 jWuZR5PGq697Y8BNneUMnG6JWGAv2z1o12hII2tnxVkfGGDnwcaSWnRDsNwZxRSUVSnu
 yeu7xKJL/PJD9UEak2rKzlvTFaoWFqUI/eeIL3n2rNcIt9kMUX5miDQwQAyiwAuJCgBE
 BJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S5cdkgdNcTluzV7ErxQTrVc9Y3rcoh9266HOxln35YM=;
 b=TRgJlI2OMEQ5gZGyyECt5M7hJg+UB7B9tlfYf3F9CuV0ok/G1ouZh4RMxkVk/5Wpyn
 FBbWzDtZa5aZmDTp3+fVJiaDyyLixP9CgLjiNOfUrNm3RA0R2hr65AtRcHd/5wVoPf1B
 4TKTL+Z6DGylM6wehUTVMQM8PzkrnQq+fa692hleLwzmj+zQ30ezoYM5E21DYdOHiBvt
 5Fjq5xXW5iTmLWjovUxpmoKsABqf9GaoS0XR94B0CLp3SIlHSkzL2nyp5/1IyQoPsM5h
 YjK7bBmSALv/XltwTA2Ld3UcrzT6fEr3CftD0uqa3Jq03Ybsihxeh4iJmL8Iz+zbzNSM
 tAdw==
X-Gm-Message-State: AJcUukchmb0gM2y+Z4BoysjR6Nf4SQiC4gWfxS3kCidV2eJnZQ6d1qe3
 ttEf5o3pHN9Gf+iQt6ncQI/X2f8u9Re6vSwjsXs=
X-Google-Smtp-Source: ALg8bN5UPHF/sDemIE55aSZwXevNPHFIXLFyyWmVN54K+NSHh49RGEqQo+iQK2Q8wJdAysID/FdesUqUDyCeIT2tXmI=
X-Received: by 2002:a02:49c9:: with SMTP id p70mr18999360jad.40.1548855237942; 
 Wed, 30 Jan 2019 05:33:57 -0800 (PST)
MIME-Version: 1.0
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-3-git-send-email-aisheng.dong@nxp.com>
 <1548854330.6869.22.camel@pengutronix.de>
In-Reply-To: <1548854330.6869.22.camel@pengutronix.de>
From: Dong Aisheng <dongas86@gmail.com>
Date: Wed, 30 Jan 2019 21:33:47 +0800
Message-ID: <CAA+hA=QCYzjqDx1ELSu4dbrwy8JNr4TUr8N1fzKunjT13KEvYA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_053359_081942_5449FF6B 
X-CRM114-Status: GOOD (  16.04  )
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

On Wed, Jan 30, 2019 at 9:21 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 30.01.2019, 13:05 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * remove one unnecessary note.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 6d0a41b..984ab92 100644
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
>
> Typos here, should be: "specified sequentially"
>

Nice catch. Will update in new version.
Thanks

Regards
Dong Aisheng

> > +  from output 0 to 7.
> >  - clocks: Should contain one clock for entry in clock-names
> >    see Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  - clock-names:

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
