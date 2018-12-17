Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A67C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928B221783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hkGsfUDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928B221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wjHNGEpgvcITEfJ2IN67IFpd/dhQVyVZVXxd1bW2jEo=; b=hkGsfUDiX/mk8u
	9jWeyByzlE+rYGCSMfdeNFmqkE7p+BJiuRVvzdpBDxBbLOE7f5vnYHzi1lD9j5x9BcDDjT0gzy21k
	D9Z9s7031JAIkHHwEcZsR7ijoaYIU1uwHi7V04yRVDS/oqE1DfCGQE28MTlqVcR3FaHNdRiMMbzWf
	xs/yEVA+sjplHItpuC7IP0Vb24IDSHLAgyeVJGGMfKLCMTlrqgN9kK3mmRNSiuXb618bp09lPYmdT
	sH3zOlxfZ09ybWulMLleWf1+/GZaUjrbSwtL0nEysdiMUAja+P7opDx8pwsvBF5cP6GH+T6uThqFi
	MdcGcD9nXLh3lbOCDH9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1j0-0004xk-Ic; Mon, 17 Dec 2018 22:50:58 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1iy-0004vH-AL
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 22:50:57 +0000
Received: by mail-ot1-f66.google.com with SMTP id e12so13845670otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 14:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qq9RWe0o0AwcBrBkMiHV/TYpBZUXDqrNISSfY4PEHKw=;
 b=TgecykThEeV2U0HOg1BziJ0XYcSG5/oobzrqYQGmsUd8VdVL/R1ZIuyhwqRiZmYjkZ
 r80I0WsQgC/oXLjLCQxLXYF3qJVdDENOTlzwvNCw2DLJitMx2RAw3nPhUVLp+L/Vo3kK
 FKyVWujZJQvTDYOWYC7a9HM1CeCBoARwMSd157Y0cjALUUSKWoH+OcA6PVnQ6beYg5pb
 9AWn6S8p9qphsw4+HbH4r6gJSnO8ng4BjxV1aAZIKCUe2xiWZDdI5h3dCJu0F+pDyPtQ
 XTKog+xcXKZOiedJq7VPylIauarhX9T3BVw8YSJN9csp6iuFqPqB+QSYECE01H7xk+BT
 CqAw==
X-Gm-Message-State: AA+aEWYFWjLnrDxZVe6RX+3P+J11jrkuLrI8PEP/tYNaYua5TIzhlP9H
 3ZHY5mTLUtdCx+jMg8pbOA==
X-Google-Smtp-Source: AFSGD/Uy0/PDtV85R3dYiMENowAmvV0y/y+2yLxz3mUD12V1btwpToPPKOYDhysi0quw5ldDK1qR9w==
X-Received: by 2002:a9d:191a:: with SMTP id j26mr1577700ota.81.1545087045319; 
 Mon, 17 Dec 2018 14:50:45 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id v3sm14103455oib.57.2018.12.17.14.50.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 14:50:44 -0800 (PST)
Date: Mon, 17 Dec 2018 16:50:44 -0600
From: Rob Herring <robh@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20181217225044.GA25148@bogus>
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <20181216094147.6468-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216094147.6468-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_145056_355583_83B84932 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 10:41:42AM +0100, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 3fd21bb7cb37..8f281816a6b8 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
>  		#thermal-sensor-cells = <1>;
>  	};
>  };
> +
> +Cluster clocks:
> +---------------
> +
> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> +cluster contain up to 2 CPUs running at the same frequency.
> +
> +Required properties:
> +- compatible: must be  "marvell,ap806-cpu-clock";
> +- #clock-cells : should be set to 1.
> +- clocks : shall be the input parents clock phandle for the clock.
> +
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	cpu_clk: clock-cpu {

There's not a register address range you can use even if Linux happens 
to not need it (currently)?

There's already a clock node under this syscon? Are they really separate 
sub-blocks?

> +		compatible = "marvell,ap806-cpu-clock";
> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
> +		#clock-cells = <1>;
> +	};
> +};
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
