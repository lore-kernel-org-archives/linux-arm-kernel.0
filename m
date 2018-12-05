Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A035FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0BB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEdC/Up/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0BB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OVo1nkWWWB5nq2ets++dMRNlwKdJTGwiHDctvKS9TDA=; b=hEdC/Up/hmNaxr
	OX5aOhx5cuXaEsasaSJb5lzdvL0vBJWLK0c7iJrSGY+PTnNj3ePw/fCtMDD6KBrX14aYYpJ9xcfWr
	uK2krV4AOhOMdtKlPInnJvdMHqr/7xSZMQzWGZ0FcOrC90si/TziWJ7Ldtt+vB01EX8SebRpiMdhd
	IF/PzE5Y4toXQa2CkAdoUnl9oK2uHG4JIDieDlVi/OQ+dIPeD9IleSI7Lq0yb/GySJfNeiPIZd37i
	h0WFFjBVjSv4gUQ2t87nfmW3kVwy1IVMR2qQ8RnE5mG1EqLf7h546g6zWtZW7b+rBNNiec+CDbqDa
	/WJwUHOAD4QXxbAPPqvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUU6u-0005eu-1f; Wed, 05 Dec 2018 10:08:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUU6r-0005dl-Qn
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:08:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4832980D;
 Wed,  5 Dec 2018 02:08:39 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 178B23F575;
 Wed,  5 Dec 2018 02:08:39 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id B870C1AE0BA8; Wed,  5 Dec 2018 10:08:59 +0000 (GMT)
Date: Wed, 5 Dec 2018 10:08:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to
 json-schema
Message-ID: <20181205100858.GA14619@arm.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-9-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-9-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_020849_873101_48E14CFB 
X-CRM114-Status: GOOD (  23.09  )
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Mon, Dec 03, 2018 at 03:31:57PM -0600, Rob Herring wrote:
> Convert ARM PMU binding to DT schema format using json-schema.

Just a couple of things below.

> diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> new file mode 100644
> index 000000000000..3ea4abfbf276
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> @@ -0,0 +1,91 @@

[...]

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apm,potenza-pmu
> +              - arm,armv8-pmuv3
> +              - arm,cortex-a73-pmu
> +              - arm,cortex-a72-pmu
> +              - arm,cortex-a57-pmu
> +              - arm,cortex-a53-pmu
> +              - arm,cortex-a35-pmu
> +              - arm,cortex-a17-pmu
> +              - arm,cortex-a15-pmu
> +              - arm,cortex-a12-pmu
> +              - arm,cortex-a9-pmu
> +              - arm,cortex-a8-pmu
> +              - arm,cortex-a7-pmu
> +              - arm,cortex-a5-pmu
> +              - arm,arm11mpcore-pmu
> +              - arm,arm1176-pmu
> +              - arm,arm1136-pmu
> +              - brcm,vulcan-pmu
> +              - cavium,thunder-pmu
> +              - qcom,scorpion-pmu
> +              - qcom,scorpion-mp-pmu
> +              - qcom,krait-pmu
> +      - items:
> +          - const: arm,cortex-a7-pmu
> +          - const: arm,cortex-a15-pmu

What do these last two mean?

> +
> +  interrupts:
> +    # Don't know how many CPUs, so no constraints to specify
> +    description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
> +
> +  interrupt-affinity:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      When using SPIs, specifies a list of phandles to CPU
> +      nodes corresponding directly to the affinity of
> +      the SPIs listed in the interrupts property.
> +
> +      When using a PPI, specifies a list of phandles to CPU
> +      nodes corresponding to the set of CPUs which have
> +      a PMU of this type signalling the PPI listed in the
> +      interrupts property, unless this is already specified
> +      by the PPI interrupt specifier itself (in which case
> +      the interrupt-affinity property shouldn't be present).
> +
> +      This property should be present when there is more than
> +      a single SPI.
> +
> +  qcom,no-pc-write:
> +    type: boolean
> +    description:
> +      Indicates that this PMU doesn't support the 0xc and 0xd events.
> +
> +  secure-reg-access:
> +    type: boolean
> +    description:
> +      Indicates that the ARMv7 Secure Debug Enable Register
> +      (SDER) is accessible. This will cause the driver to do
> +      any setup required that is only possible in ARMv7 secure
> +      state. If not present the ARMv7 SDER will not be touched,
> +      which means the PMU may fail to operate unless external
> +      code (bootloader or security monitor) has performed the
> +      appropriate initialisation. Note that this property is
> +      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
> +      in Non-secure state.
> +
> +required:
> +  - compatible

I probably said this before, but I do think that it's a shame to lose the
example binding, especially for something like the PMU where you can
pretty much take an example and bang in your own IRQ numbers to get it
up and running.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
