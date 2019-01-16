Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2863720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDNUqkUN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoIIa8uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2863720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bD1+0Lyf0+YVL6t+NrMqnameVAcxIAcpx9wBuaWK8Ns=; b=LDNUqkUN+qW8Kr
	T1r8QlgTscMfgWdonZKigZ0Y1/Xe0UNQjUI82XoX/IlUauaO0bBwfB+eJuX+Bjuj8hLL7iEq4whti
	oY/MP9QX2Oo22TedkzHqXS1dRKjvL+fHJv1x/7vIcBrAtm+Jmkx80hT6tiX8ybHwRriYNbjoeJALB
	+QOccbp3PooEM9PO1UWuKy9J0UY9M7aRHV0pnzytBlEAdvWl4CMOcSxbMihxTUhhjGdJifl43kvuC
	pO8KoiHeilE7EIkHkJok/BOew05ljVy/caG9fVcI0xYgbjWOArQya6EQWYKp1KoS04qX7hhxbud0c
	AHku8LIYN5IOs1OBjvqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjapj-0007Z1-C8; Wed, 16 Jan 2019 02:21:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjapb-0007RW-7E
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 02:21:32 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C17920651;
 Wed, 16 Jan 2019 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547605286;
 bh=ovWCjT45h4WTfSnSYYNC56vKpypy8+XVsA6zwQ+eda4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KoIIa8uoKVz6lNzs6WW3eIWhTgNLCaI9bUc/dwCEJ2A30bnDhc80AkWweYRrZ1si5
 JPobZQ6rM7rJVe2SdyM6nUUwOcX58OqzOqcMG2SJ7Ehr1sz2K3Ewe7ZaLKnOTAHXxg
 z5m+T7cE6AwZ10SmJzZ9UIpmo9vlorVYwU7USeaU=
Date: Wed, 16 Jan 2019 10:21:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190116022100.GC15808@dragon>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_182127_945456_69D1B9A1 
X-CRM114-Status: GOOD (  16.13  )
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
> >            - const: fsl,ls1021a
> 
> And this is wrong too.
> 
> I you just change it, then we will be missing an entry for LS1021A.
> What's the status of that SoC because there is no board dts file? We
> should not have .dtsi files in the kernel which don't get built.

Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
just a typo of LS1012A.

@Leo, do we have a LS1021A SoC?

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
