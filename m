Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02EF20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeeHJqrz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVvxRVJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02EF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ti4Mh/eATzxOyxmNnZmSTAWZVMXMuxb80O0jHJno3L0=; b=BeeHJqrz7QizBb
	5HLSI5RuS2G1No6u6pjJXbP/b4UkTFtd6iW+oyR2/PXC4nyyLT3IadYjHqcXcnk//d4v/qv+RkHyd
	F//T+qfOqzzphgE5JdmtCS3+fjMqg2sVb5hCvd1xTB0heMRXkLAl+dNaW+Agk5bw1dIW9sgHlwUwn
	tw5uFs2fkrTC5F2AIxQh1+cVrQVrLkYYbS3rNPbuM69dLMpvS2uSK+avc4F0gHX/e/LmbFTUDALbK
	5D5wjLzLU5xGjQB3o/t6iXYc68Utv0alr9qAXGavwFQs0+hg7BjUMpUGLqQulhvu+xczL3vYLSk7a
	vhgsUgDWN1GgnG38uW6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiE4-0006QY-Qi; Wed, 16 Jan 2019 10:15:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiE2-00067F-35
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:15:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8FF9820840;
 Wed, 16 Jan 2019 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547633709;
 bh=YEROV+6MnUwf6k5Mty8tQcmS9XNDA+2/kv68s0kIq1I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RVvxRVJo5aYsOxVEqKFbZhXds0p/xXJD4YcnnOnzWrEtCP3cgBFGJOynn6lhsUs7X
 +UXqtXA/tiqDRVyw+bxh49+ecqnAFUCfACl9ofMkKYIGVmVd9NOfFCXbunDGq4FQ6F
 FNGCbbz0Q0MWFsCNsEFvqgtjmFR+g+U/rcvu23mQ=
Date: Wed, 16 Jan 2019 18:14:43 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190116101441.GH15808@dragon>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_021510_251807_E9966A2D 
X-CRM114-Status: GOOD (  19.60  )
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

On Tue, Jan 15, 2019 at 10:07:12PM -0600, Rob Herring wrote:
> On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > > that, let's fix the description for LS1012A also.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > index d34fe0749199..0f30142fe316 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -173,12 +173,13 @@ properties:
> > > >                - fsl,vf610
> > > >                - fsl,vf610m4
> > > >
> > > > -      - description: LS1021A based Boards
> > > > +      - description: LS1012A based Boards
> > >
> > > Well, yes that was wrong...
> > >
> > > >          items:
> > > >            - enum:
> > > >                - fsl,ls1012a-rdb
> > > >                - fsl,ls1012a-frdm
> > > >                - fsl,ls1012a-qds
> > > > +              - ebs-systart,oxalis
> > >
> > > Sort alphabetically.
> > >
> > > >            - const: fsl,ls1021a
> > >
> > > And this is wrong too.
> > >
> > > I you just change it, then we will be missing an entry for LS1021A.
> > > What's the status of that SoC because there is no board dts file? We
> > > should not have .dtsi files in the kernel which don't get built.
> >
> > Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> > just a typo of LS1012A.
> >
> > @Leo, do we have a LS1021A SoC?
> 
> arch/arm/boot/dts/ls1021a.dtsi

Oops, I only searched arm64 folder.

So it seems the compatible of the boards below are missing there.

  ls1021a-moxa-uc-8410a.dts
  ls1021a-qds.dts
  ls1021a-twr.dts

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
