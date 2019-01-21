Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F63AC31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:10:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AF8217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyClyxFb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZ/RorbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AF8217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SnVfPDCWeva+vYCfuuGfGYhbV/NceI5a8h8zwWBvXB8=; b=MyClyxFbfjb7nA
	lrldrpn6Y6Qjt0x+EyCO75ABBuovIJOvD5dFmRCZm2PL8SlSDR0yyfm54JygYlG659++J1nmUayW2
	K0yjsI+e0sKv7PCfNb7Omv+A5QrEt7cL+K/sFPFpUPWoWEhg8oen5GuFchh7/qJ+NA8F0mqBUblFt
	Nx2b0RVA/jYFExw85HXDshFHOMK383I4WTWweq6AkZZ3t7+ze4RihTG3gI/OJmIs+f5yxcr0ZZ4eg
	3EIxD5WwrBkqUWCIHuYGtowOT+6dAKqOp0xQZMO89KytRB8QaNvWZaW0yFJbqauR9+VZotlT/Ehc9
	u98eWxxnSm4Ku2d9gUxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSma-0007UR-IU; Mon, 21 Jan 2019 06:10:04 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSmW-0007Lj-SM
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 06:10:02 +0000
Received: by mail-pf1-x442.google.com with SMTP id w73so9608261pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 22:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KOM/uD0QCo+R8A70jLNHCXKLD6NDSRQnu6GicijX3uM=;
 b=KZ/RorbYqB6p82S5YpiClVd/+5Uz+NUJcryFloOg44jqPBITRgYtnEbxjakwy7V9EF
 oLLehle6x6lODRX0i1emydEOoV7Wi73TctV4ahHgLt7yMok3e7Ti/CRrDPg4HaO/yi0t
 SNguuz/pTmEgy+2nEFA+hn9LFFLU3Wvkxg58Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KOM/uD0QCo+R8A70jLNHCXKLD6NDSRQnu6GicijX3uM=;
 b=Wihe1Cgp2UhLBbBbA0jEmAwZj96WlWcP+Wh/3vaHSKwrZx0fwFWDydLW4EVdmoxh+z
 1MKpyjuzUHEXgdL0uRzMr4xnsWnbkekml4Ukj/P7A8F4FXX3GeaonyrKWy2cqcFd6Co7
 8yv76EULW83aDo6dqvd+GvnpUQ5L4SujdxBlHuXslpwi+XV6Q7v0pfHklExu9nYOVAKb
 JAkDNUCU4pjS5jDcVgfVEZRLMCQdU9SBOYpwlBb6X/l92KZ71YGwLyqQiEtLYZhvi0vS
 TWS15+k2uwt7umstbrliMNNDswkrWUqdnLTHldaQ86neZQIEOI7VCq8JYRp8Yhyj+MAK
 6zFQ==
X-Gm-Message-State: AJcUukcfwcsCqruuzQbzYD+WWyLKHZGLRC1XW+OzMUq12/IaWZWLGOiK
 AS+5DdyO7RWuIAk1XBU44lNx
X-Google-Smtp-Source: ALg8bN5tEuiDvy/7UjSiOHIjPc1PRhcF/jybPjBK96SHNgTi6RXlqFvivbKwuNKTKBfHsET2NRZ5LQ==
X-Received: by 2002:a63:f65:: with SMTP id 37mr26796456pgp.238.1548050999815; 
 Sun, 20 Jan 2019 22:09:59 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:620d:6d18:8cdf:8a2:4d22:45a8])
 by smtp.gmail.com with ESMTPSA id 186sm24903247pga.36.2019.01.20.22.09.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 20 Jan 2019 22:09:58 -0800 (PST)
Date: Mon, 21 Jan 2019 11:39:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190121060950.GA8713@Mani-XPS-13-9360>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
 <20190116101441.GH15808@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116101441.GH15808@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_221000_926745_0D7A9F14 
X-CRM114-Status: GOOD (  23.30  )
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
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 06:14:43PM +0800, Shawn Guo wrote:
> On Tue, Jan 15, 2019 at 10:07:12PM -0600, Rob Herring wrote:
> > On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > > > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > > > that, let's fix the description for LS1012A also.
> > > > >
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > index d34fe0749199..0f30142fe316 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > @@ -173,12 +173,13 @@ properties:
> > > > >                - fsl,vf610
> > > > >                - fsl,vf610m4
> > > > >
> > > > > -      - description: LS1021A based Boards
> > > > > +      - description: LS1012A based Boards
> > > >
> > > > Well, yes that was wrong...
> > > >
> > > > >          items:
> > > > >            - enum:
> > > > >                - fsl,ls1012a-rdb
> > > > >                - fsl,ls1012a-frdm
> > > > >                - fsl,ls1012a-qds
> > > > > +              - ebs-systart,oxalis
> > > >
> > > > Sort alphabetically.
> > > >
> > > > >            - const: fsl,ls1021a
> > > >
> > > > And this is wrong too.
> > > >
> > > > I you just change it, then we will be missing an entry for LS1021A.
> > > > What's the status of that SoC because there is no board dts file? We
> > > > should not have .dtsi files in the kernel which don't get built.
> > >
> > > Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> > > just a typo of LS1012A.
> > >
> > > @Leo, do we have a LS1021A SoC?
> > 
> > arch/arm/boot/dts/ls1021a.dtsi
> 
> Oops, I only searched arm64 folder.
> 
> So it seems the compatible of the boards below are missing there.
> 
>   ls1021a-moxa-uc-8410a.dts
>   ls1021a-qds.dts
>   ls1021a-twr.dts

So how should we proceed here? The above mentioned boards are lacking
compatible in dts files and I guess that's the reason they didn't get
mentioned in "fsl" binding file.

Should I just go ahead and add the compatibles for these boards and list
them in binding file?

Thanks,
Mani

> 
> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
