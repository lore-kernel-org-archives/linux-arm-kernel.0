Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D8CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:42:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5028D208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b0C5phHX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQLZvSEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5028D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VpKRfC3uO1Hu0BVMe5Iv5klu5vqBvXgJtEHqz9Mi15Y=; b=b0C5phHXqBjn6Z
	7+RyWzxcKGAWFBwW3FNK1zkfPa9QCJ1/gqF1EgzASN2zKuVxz7wWNte8ts7QiqjnucJ+BZYihUuD1
	BxWTzCtPahswM+hUqla29LxN0irkcRGvcT3f31TubM9GCzVzDdYy7lrIcjhTifNQEGrY6zU52bqin
	a8a3+g3/oeuiDqXVsk0sfpQ1xPufmCDWPObTvdhXuFN5kNDRDN7OwAcRjGeN9P9xAcG+eDdUIOalO
	+AOQCqIuqucn9UqqDmqU08W6Xddf9q27juSmSjdHcjioHC3exOPB9nVozNSIdexcP3rQ+spUigCSu
	9LJ4Nusz34RUXB/XCO1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZJm-0002UQ-6A; Wed, 05 Dec 2018 15:42:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZJj-0002Tc-BY
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:42:28 +0000
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB4502151B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544024536;
 bh=IulgWewf4bQJh4lo1as4cTT1K61bw/afZxQORAPUcNo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bQLZvSEfi8uCbl/tiPYfCHl3EYwkazD2F2Yiik1s4izxB9Lq12Q90tac5HMtgEWkJ
 6mOR3TZzS7BCuJzvdffsfFUYUjDte93TURlbx6Igs/tJEFWimNjBd2buseXj+ZojJI
 JwVaxitMgD3IBLZ05DnZc4U5kIDGn6ZLecZH0LkY=
Received: by mail-qk1-f179.google.com with SMTP id r71so12082311qkr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:42:16 -0800 (PST)
X-Gm-Message-State: AA+aEWbiT0HgVdsSjqrTswmEb20za4wpPEISIybM5uR2hf6SFh0i9F4d
 RC+SAVK/yXueJ3XAHMh9VRrFIIHAJVa7/p/jeQ==
X-Google-Smtp-Source: AFSGD/UHe8LZSbS50ZccPUX2r90JrhnTfYfUqDOo4FNKj1WV0gvL0R53817rqB0atchtdH3ctLVO0SSj1KWRjHPmurI=
X-Received: by 2002:ae9:edd8:: with SMTP id
 c207mr22123542qkg.184.1544024535879; 
 Wed, 05 Dec 2018 07:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-9-robh@kernel.org>
 <20181205100858.GA14619@arm.com>
In-Reply-To: <20181205100858.GA14619@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 09:42:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
Message-ID: <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
Subject: Re: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to
 json-schema
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_074227_430096_0F77C10E 
X-CRM114-Status: GOOD (  26.32  )
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

On Wed, Dec 5, 2018 at 4:08 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Rob,
>
> On Mon, Dec 03, 2018 at 03:31:57PM -0600, Rob Herring wrote:
> > Convert ARM PMU binding to DT schema format using json-schema.
>
> Just a couple of things below.
>
> > diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> > new file mode 100644
> > index 000000000000..3ea4abfbf276
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> > @@ -0,0 +1,91 @@
>
> [...]
>
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - apm,potenza-pmu
> > +              - arm,armv8-pmuv3
> > +              - arm,cortex-a73-pmu
> > +              - arm,cortex-a72-pmu
> > +              - arm,cortex-a57-pmu
> > +              - arm,cortex-a53-pmu
> > +              - arm,cortex-a35-pmu
> > +              - arm,cortex-a17-pmu
> > +              - arm,cortex-a15-pmu
> > +              - arm,cortex-a12-pmu
> > +              - arm,cortex-a9-pmu
> > +              - arm,cortex-a8-pmu
> > +              - arm,cortex-a7-pmu
> > +              - arm,cortex-a5-pmu
> > +              - arm,arm11mpcore-pmu
> > +              - arm,arm1176-pmu
> > +              - arm,arm1136-pmu
> > +              - brcm,vulcan-pmu
> > +              - cavium,thunder-pmu
> > +              - qcom,scorpion-pmu
> > +              - qcom,scorpion-mp-pmu
> > +              - qcom,krait-pmu
> > +      - items:
> > +          - const: arm,cortex-a7-pmu
> > +          - const: arm,cortex-a15-pmu
>
> What do these last two mean?

The first list only allows a single compatible string. This list says
there are 2 and that the compatible property should be:
compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";

Which shows up here:
arch/arm/boot/dts/sun6i-a31.dtsi:               compatible =
"arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
arch/arm/boot/dts/sun7i-a20.dtsi:               compatible =
"arm,cortex-a7-pmu", "arm,cortex-a15-pmu";

Maybe the dts is wrong and should be fixed?

> > +  interrupts:
> > +    # Don't know how many CPUs, so no constraints to specify
> > +    description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
> > +
> > +  interrupt-affinity:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      When using SPIs, specifies a list of phandles to CPU
> > +      nodes corresponding directly to the affinity of
> > +      the SPIs listed in the interrupts property.
> > +
> > +      When using a PPI, specifies a list of phandles to CPU
> > +      nodes corresponding to the set of CPUs which have
> > +      a PMU of this type signalling the PPI listed in the
> > +      interrupts property, unless this is already specified
> > +      by the PPI interrupt specifier itself (in which case
> > +      the interrupt-affinity property shouldn't be present).
> > +
> > +      This property should be present when there is more than
> > +      a single SPI.
> > +
> > +  qcom,no-pc-write:
> > +    type: boolean
> > +    description:
> > +      Indicates that this PMU doesn't support the 0xc and 0xd events.
> > +
> > +  secure-reg-access:
> > +    type: boolean
> > +    description:
> > +      Indicates that the ARMv7 Secure Debug Enable Register
> > +      (SDER) is accessible. This will cause the driver to do
> > +      any setup required that is only possible in ARMv7 secure
> > +      state. If not present the ARMv7 SDER will not be touched,
> > +      which means the PMU may fail to operate unless external
> > +      code (bootloader or security monitor) has performed the
> > +      appropriate initialisation. Note that this property is
> > +      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
> > +      in Non-secure state.
> > +
> > +required:
> > +  - compatible
>
> I probably said this before, but I do think that it's a shame to lose the
> example binding, especially for something like the PMU where you can
> pretty much take an example and bang in your own IRQ numbers to get it
> up and running.

I just thought it is so trivial that it didn't add much. I think most
folks would copy-n-paste from an actual dts file which has all the
other nodes you just need to update addresses and irq nums.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
