Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8FBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B70620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L106Eqxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rD+wuszzRlGDABR31zEC/0lloa9ae14xuyCXLqMaOXc=; b=L106EqxdwoIura
	SKTraM9Qq6QoMl2q6UZL6ta03uMQiWuHwge5ZlxdgLhP01mnIQRlSTC38dSTpOLd4jXbF5NfZjE0e
	0Xj1JdT9lsHj1ioisOkAFTXN+SacBegAx01aUOVMLrvTzJvuQOP3GbvI3IomTbqFPTMw/Elb0CR2K
	iHwtqfcFfGqX75fnJUxNiqfPYGT222R4gX33foGtM9pHh+A6iPzHDvm6A4ceMfFeLTHzATa+V1vDW
	3Hz+/majfWwznNaXuz3YW9/hP7nvbvcwbq5nGQ5gd4KNRzMFOENz1sQuAXL5yeOWaY4ICxrvDbcl/
	7D+FAyZUVUNzTHdVsRgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUaw-0007NX-J7; Mon, 10 Dec 2018 23:04:10 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUat-0007MX-V6
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:04:09 +0000
Received: by mail-ot1-f68.google.com with SMTP id 40so12180988oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 15:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BU2AHK5MEIkJG5XtjM9gcjQxc/Xj70bZDzmmMmViwkw=;
 b=rvj0S5ygakFhghsK1/zsPE7EKYuTzPbgKFSEQld6Zb5EcOErETKo9nUNJlyq0PxXJ7
 QLK9U0ZDE15GrchOg/TtLmXD+cvY8Co1EySXqEg8TbjmpWBB0prUMacd8aIxSeLqHLJh
 puRr/9F+qAAWZIvumKimCW5/hRtmI2Jah2YlYCYGINiQhS2wmlmL1TBgdAZOhzC+cTJR
 Q6frrx5S60bwXCH+nPMu7zQcJGLVXO2ocNfeYsqkMWRN3iOF2uucuM1SYLnHs2itNm0s
 XcF66pnb+190wyq1RZWa/xrLaGXHcoyKeyN5lmI/3f9hXatWqhIH3gSwiMsR4u5fM//d
 aIKQ==
X-Gm-Message-State: AA+aEWY6xRvDklBRxVTSDETbdifEIELO4FOon8U+cIoIlLFPNPGOLvwm
 JqHLybJ7n533Xyl+bGViYg==
X-Google-Smtp-Source: AFSGD/XtijStdq5cHiVw/94QIS+xHIWj6QwNHLr6+9PJKQv7XjEr9xzyPh+EhChMtSUUspeVWRdvHw==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr10380914otm.170.1544483036219; 
 Mon, 10 Dec 2018 15:03:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l6sm5553927otf.56.2018.12.10.15.03.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 15:03:55 -0800 (PST)
Date: Mon, 10 Dec 2018 17:03:54 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: ap806: document the thermal
 interrupt capabilities
Message-ID: <20181210230354.GA1503@bogus>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
 <20181204190332.10351-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204190332.10351-4-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_150408_006753_B9D3DB96 
X-CRM114-Status: GOOD (  21.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Eduardo Valentin <edubezval@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 08:03:29PM +0100, Miquel Raynal wrote:
> The thermal IP can produce interrupts on overheat situation.
> Describe them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/ap806-system-controller.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 3fd21bb7cb37..35e8dd2edfd2 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -114,12 +114,18 @@ Documentation/devicetree/bindings/thermal/thermal.txt
>  The thermal IP can probe the temperature all around the processor. It
>  may feature several channels, each of them wired to one sensor.
>  
> +It is possible to setup an overheat interrupt by giving at least one
> +critical point to any subnode of the thermal-zone node.
> +
>  Required properties:
>  - compatible: must be one of:
>    * marvell,armada-ap806-thermal
>  - reg: register range associated with the thermal functions.
>  
>  Optional properties:
> +- interrupt-parent/interrupts: overheat interrupt handle. Should point to
> +  line 18 of the SEI irqchip.
> +  See interrupt-controller/interrupts.txt

Don't document interrupt-parent as it is implied and may be in a parent 
node.

>  - #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
>    to this IP and represents the channel ID. There is one sensor per
>    channel. O refers to the thermal IP internal channel, while positive
> @@ -133,6 +139,8 @@ ap_syscon1: system-controller@6f8000 {
>  	ap_thermal: thermal-sensor@80 {
>  		compatible = "marvell,armada-ap806-thermal";
>  		reg = <0x80 0x10>;
> +		interrupt-parent = <&sei>;
> +		interrupts = <18>;
>  		#thermal-sensor-cells = <1>;
>  	};
>  };
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
