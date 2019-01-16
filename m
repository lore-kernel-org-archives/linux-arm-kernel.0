Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:07:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6D02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9MRE5z3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRYsuG00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6D02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FvnywdrozI+a2FBFGy4ybIyduZ5Vs/RBO3SPmfJW5iU=; b=F9MRE5z3NDT6tA
	OYn8sI9fKmAO1AFwSD9cFZuKc0mHGJ18kixkvQR87dsgYB8r1xE37iAMf+VrYXPs3mu+KF4O9HI2H
	Xttrpq9g2JzCDnO8fqoqCO7A8SEIeIRWeuksnvA0Pb4rQKFPDwnWPz508BOlBBB5mhUwIS6RnzO6y
	bDNeGpT1E+KTy7HebuFb0xWQkqUIoAL2bbEp8gX5dsYH9KnYzmz2+QSPZ40XAN3LJ9dylgDqAQ3Qb
	94BxAIemKOFBR/3Fbd3OmnFD4Fqa+ipMlcpGktGeXb/1sr5LaF07Il8pH9QJdD7967lTIOlnGgjhu
	JY1MhgQwDExzhsoOJhZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjcUD-0004PF-6I; Wed, 16 Jan 2019 04:07:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjcUB-0004On-0V
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 04:07:28 +0000
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 828BC2082F
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547611645;
 bh=2HlDFwn84+HFe+4yBNCkldUE7+7VKyYJQ2UorUXUktI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fRYsuG00CR5eQPKPV2q221wxX8fEcjL6EWTdEwR4BDPIr0WrMaUn3EMx9OvySWslT
 k+n7rBN3sAU8+RED/R9OD9QcEhmlj8gjkBYAHg18n1Y1/I/wdRwZeUn2hsDAK30itb
 fzkdjNtH73Y6ckaGpLD2G9y8wyKSGLjVj0X5CItY=
Received: by mail-qk1-f171.google.com with SMTP id 189so2956885qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 20:07:25 -0800 (PST)
X-Gm-Message-State: AJcUukd6xh+HiaEKpc0qdszYnMBIxbA9U91YCWQhZuEEX4mcSKZ6REQU
 glfgSxIrDUM12r259ya3SxMzll0Y0OY5Ia3+Ig==
X-Google-Smtp-Source: ALg8bN7OhhgKLjFlQNntw++eOnNgjBDqCJchN8L5+YbQl3pK+57waLH4sp5M0umV0VvGjHGvM7U2XJAp/ZRBPq3P2I0=
X-Received: by 2002:a37:a483:: with SMTP id n125mr5080568qke.184.1547611644713; 
 Tue, 15 Jan 2019 20:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
In-Reply-To: <20190116022100.GC15808@dragon>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 15 Jan 2019 22:07:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
Message-ID: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_200727_101836_C2A3EEB4 
X-CRM114-Status: GOOD (  20.54  )
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > that, let's fix the description for LS1012A also.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index d34fe0749199..0f30142fe316 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -173,12 +173,13 @@ properties:
> > >                - fsl,vf610
> > >                - fsl,vf610m4
> > >
> > > -      - description: LS1021A based Boards
> > > +      - description: LS1012A based Boards
> >
> > Well, yes that was wrong...
> >
> > >          items:
> > >            - enum:
> > >                - fsl,ls1012a-rdb
> > >                - fsl,ls1012a-frdm
> > >                - fsl,ls1012a-qds
> > > +              - ebs-systart,oxalis
> >
> > Sort alphabetically.
> >
> > >            - const: fsl,ls1021a
> >
> > And this is wrong too.
> >
> > I you just change it, then we will be missing an entry for LS1021A.
> > What's the status of that SoC because there is no board dts file? We
> > should not have .dtsi files in the kernel which don't get built.
>
> Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> just a typo of LS1012A.
>
> @Leo, do we have a LS1021A SoC?

arch/arm/boot/dts/ls1021a.dtsi

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
