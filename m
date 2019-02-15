Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FF5218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xw7Tu6Q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FF5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=diF5qQNw5dcAqD+dCyB1d6Q2y/WF0t+Oa5CijZPycLY=; b=Xw7Tu6Q3afXYad
	NKz3emvhjfctGgd0D4Y7hqczc3rrw8H9nKMElXw2YEHquvPoAqo/xggZvAe0L5ECDLS2N8sq4PFNj
	R8I8h0kHhHSe9ANMs63iOGMZwO5Aq89uo3NJ+HVXFN+7rzOzvMED2WK8y9QnPH8hx87ZhoUHD45p4
	fez34S1rJGBDeWNzMojcc6BuSa9+jVLpMxWJlDR1/nbDyIQnvOSFbq7s6saaBtbt+1K1PpkvqC5JS
	ZFdMgtC1dwSuOmnSYsvcIJEqi9/MxLoARX382iEROhEneu5ctVW2+SYpBuawJfTrWV217hwmyK/39
	hZo4cAO2cfTrF7ARe1wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gue0t-00087N-V7; Fri, 15 Feb 2019 13:58:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gue0q-00086K-9l
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:58:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCD1CA78;
 Fri, 15 Feb 2019 05:58:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C87F03F575;
 Fri, 15 Feb 2019 05:58:41 -0800 (PST)
Date: Fri, 15 Feb 2019 13:58:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH V3 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Message-ID: <20190215135834.GA55505@lakrids.cambridge.arm.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
 <1550081533-25000-3-git-send-email-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550081533-25000-3-git-send-email-Frank.Li@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_055844_342260_0289922E 
X-CRM114-Status: GOOD (  16.88  )
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 06:12:33PM +0000, Frank Li wrote:
> Added binding doc for imx8qxp ddr performance monitor
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

As a general thing, please put the DT binding earlier in the series than
the code and/or DTs using it, as per:

  Documentation/devicetree/bindings/submitting-patches.txt

> ---
> Change from v2 to v3
> * ddr_pmu0 -> ddr-pmu
> 
>  .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> 
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> new file mode 100644
> index 0000000..9d55182
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> @@ -0,0 +1,22 @@
> +* Freescale(NXP) IMX8 DDR performance monitor
> +
> +Required properties:
> +
> +- compatible: (standard compatible string) should be one of:
> +	"fsl,imx8-ddr-pmu"
> +	"fsl,imx8m-ddr-pmu"

Please remove the "(standard xxx)" bits, they're just noise.

Otherwise, this generally looks OK.

Are the DDR PMU registers part of the DDR controller register block?

Thanks,
Mark.

> +
> +- reg: (standard registers property) physical address and size
> +
> +- interrupts: (standard interrupt property) single interrupt
> +	generated by the control block
> +
> +Example:
> +
> +	ddr-pmu@5c020000 {
> +		compatible = "fsl,imx8-ddr-pmu";
> +		reg = <0x0 0x5c020000 0x0 0x10000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> -- 
> 2.5.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
