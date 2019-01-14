Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:11:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280F20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gux+LW9n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdKMZrEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280F20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j6qXA8jtCKRdWQnlI/fDnDR2yCIquqXqneXM8qQyWDs=; b=Gux+LW9ndLpSlP
	ldoymIDwaWQd7f4T2RkfC2CNtbgK/4PThvOYGEGEWbXQLQNhapgm8TQEWeKGVcUAuY05VT7IlMSny
	396aLL7O33SBHkfQX2VMp3LeyHPMpH15O9Em66kVSmvtt47hzYXFcuG1u7f9Sf0P9Av/70XyBYGec
	KPLKw9/rKaA+5K8cJtf5iG1M68B3xR/+Hp2XaqLYaDnJKHFkn3tt6rcDd+SbJuzzNTO1QVZMna0io
	G6byRJOIz01F/wYQ1qlr1I84PYadETRde+GkWYx/hOtIV4+rAevpsY+GT6UyrVDJUvip0oPthkVB1
	iFbZBCHZUW6URQAyI3qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj6hZ-0002TK-MJ; Mon, 14 Jan 2019 18:11:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj6hX-0002Sz-6h
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 18:11:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so9809873pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 10:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6GtwG3HAnkm37nX1xim6b7DZEer8Rmsl7NV2xIs5MOA=;
 b=kdKMZrEUrv93bBJrjGm/PP4q1YZxZVND1YoUArnL7rSFbBVUV9pCf2/n7LFiE6OvdP
 tCP+ATBkvB8G2ZE7iz6WGsoGKOcbOtDRPn6HOeRJaYC3ihwk0q48YdOlyb+dujgQfwbf
 01mpMLTkO66GBfEUdZ2w9RUwGdZ40JCk6h6qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6GtwG3HAnkm37nX1xim6b7DZEer8Rmsl7NV2xIs5MOA=;
 b=bFdWTEQ98HO6X63sa31jisEa+OHcNBaFBAZPPAmg7tD9z23w8EUflEirvohYmvMz0t
 dYZSYFKJT9lItdo+AlGIiC4tYMeyNp5EzSQO8wKubBWeiLiOD04AkJDQlTHhdzlHKlLA
 Kb+RjyR8K7uLbNMM/rAnqos6n1emlxXZcaMg963jVGTcbv+dnlxIREuQEzHtSqIhCsk1
 Qh9aBMtEL+j639NoPORfBBWbVVmftczNLegLjTIqajLh7Y8fmuYFfhwkBBauDAwfMGnt
 I5jTbdkKgN3ffzTjjK25QOR98GpTVW61Wv0D++j3dkUsB7/mQa3rnpzJLKvTux6EycQX
 VZKw==
X-Gm-Message-State: AJcUukcavyaGIyxGDPbReFKvZzYiEcEOLwZdKYOHRp4YxuhvTRcnHcFf
 JmOjctK4+ZhpzRNQ2Jx8vG4B
X-Google-Smtp-Source: ALg8bN74ZX2uUEWOkAMgpG0Kpwim7SBVthxcD3LPwAPRJXtBtGVuwNfpRYbJsO7AAuCZB2K4Tr1bsA==
X-Received: by 2002:a63:104d:: with SMTP id 13mr24091353pgq.303.1547489466279; 
 Mon, 14 Jan 2019 10:11:06 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6388:942c:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id w88sm2973528pfk.11.2019.01.14.10.11.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 10:11:05 -0800 (PST)
Date: Mon, 14 Jan 2019 23:40:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190114181057.GA6636@Mani-XPS-13-9360>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_101107_256163_75B9C44C 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add devicetree binding for Oxalis board in JSON format. While adding
> > that, let's fix the description for LS1012A also.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index d34fe0749199..0f30142fe316 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -173,12 +173,13 @@ properties:
> >                - fsl,vf610
> >                - fsl,vf610m4
> >
> > -      - description: LS1021A based Boards
> > +      - description: LS1012A based Boards
> 
> Well, yes that was wrong...
> 
> >          items:
> >            - enum:
> >                - fsl,ls1012a-rdb
> >                - fsl,ls1012a-frdm
> >                - fsl,ls1012a-qds
> > +              - ebs-systart,oxalis
> 
> Sort alphabetically.
> 

Okay.

> >            - const: fsl,ls1021a
> 
> And this is wrong too.
> 

Ah, I missed this ;-)

> I you just change it, then we will be missing an entry for LS1021A.
> What's the status of that SoC because there is no board dts file? We
> should not have .dtsi files in the kernel which don't get built.
> 

I don't know much about LS1021A. Shawn should have an idea!

Thanks,
Mani

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
