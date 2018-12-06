Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C590C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:37:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47E420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M4fWR5T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47E420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hDxS67gMIq/HvGIgK2lRaGRWMRIhXVcanmBDtIR3Jcc=; b=M4fWR5T6md7YO1
	ltt07lVOZejYd1O9U2HM95oHQWv11fo4PgsfGD74Z11wF+W0IFla9cGh8dSVW1tghjLoq5P4A+xKD
	T6+88MVDL8yX8H0xsfAwecrNZkve/Z67yszh8+DkNpycSxgLH9YFwLKQNJZlBg7SrNXFH+R4uonc7
	EY8MUWMp3zi3oqG3z4sHHB8JDGmo6yKQd8rSRWOxNvhU63kV10TAB7mGz4aoEZdnUsznnzqfVUiR4
	callJeWKXRyhm5j73VUxvTp40sKSqz9sOn32tBNb98B/YHb8vyPknlSVCYJqHSGTXLdBGBRYNlqhd
	j9dKxgLFf6jG/sy9nulw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUumE-000457-Be; Thu, 06 Dec 2018 14:37:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUumA-0003sk-PL
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:37:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACBFA78;
 Thu,  6 Dec 2018 06:37:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AE883F575;
 Thu,  6 Dec 2018 06:37:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 249F41AE0BCF; Thu,  6 Dec 2018 14:37:23 +0000 (GMT)
Date: Thu, 6 Dec 2018 14:37:23 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to
 json-schema
Message-ID: <20181206143722.GA14887@arm.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-9-robh@kernel.org>
 <20181205100858.GA14619@arm.com>
 <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063714_858347_7C33E819 
X-CRM114-Status: GOOD (  18.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 09:42:04AM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 4:08 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Dec 03, 2018 at 03:31:57PM -0600, Rob Herring wrote:
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - apm,potenza-pmu
> > > +              - arm,armv8-pmuv3
> > > +              - arm,cortex-a73-pmu
> > > +              - arm,cortex-a72-pmu
> > > +              - arm,cortex-a57-pmu
> > > +              - arm,cortex-a53-pmu
> > > +              - arm,cortex-a35-pmu
> > > +              - arm,cortex-a17-pmu
> > > +              - arm,cortex-a15-pmu
> > > +              - arm,cortex-a12-pmu
> > > +              - arm,cortex-a9-pmu
> > > +              - arm,cortex-a8-pmu
> > > +              - arm,cortex-a7-pmu
> > > +              - arm,cortex-a5-pmu
> > > +              - arm,arm11mpcore-pmu
> > > +              - arm,arm1176-pmu
> > > +              - arm,arm1136-pmu
> > > +              - brcm,vulcan-pmu
> > > +              - cavium,thunder-pmu
> > > +              - qcom,scorpion-pmu
> > > +              - qcom,scorpion-mp-pmu
> > > +              - qcom,krait-pmu
> > > +      - items:
> > > +          - const: arm,cortex-a7-pmu
> > > +          - const: arm,cortex-a15-pmu
> >
> > What do these last two mean?
> 
> The first list only allows a single compatible string. This list says
> there are 2 and that the compatible property should be:
> compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> 
> Which shows up here:
> arch/arm/boot/dts/sun6i-a31.dtsi:               compatible =
> "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> arch/arm/boot/dts/sun7i-a20.dtsi:               compatible =
> "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> 
> Maybe the dts is wrong and should be fixed?

Yes, that's wrong and you could end up with the kernel exposing the wrong
events to userspace. So I think we can fix the .dts and leave the binding
without this.

> > > +required:
> > > +  - compatible
> >
> > I probably said this before, but I do think that it's a shame to lose the
> > example binding, especially for something like the PMU where you can
> > pretty much take an example and bang in your own IRQ numbers to get it
> > up and running.
> 
> I just thought it is so trivial that it didn't add much. I think most
> folks would copy-n-paste from an actual dts file which has all the
> other nodes you just need to update addresses and irq nums.

True... even more of a reason to fix thise sun* .dts files then!

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
