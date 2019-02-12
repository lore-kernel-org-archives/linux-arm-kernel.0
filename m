Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D442222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puD+LTK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D442222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S9XMMv2ACUqlt1Sbjj+7CyRiq4PTjoXyHqkqG6uBDQA=; b=puD+LTK96dqy8Qrwlim9GyOSF
	MuXP5IOmOX6SFq1BrORVk3zFwmsjigg3SLGskQc5Ngcj0NqnYyvgyQvecOXf6UNWZChyjoL9u+jQB
	R4C7DiDKBNa0wFtG59tcB5+NjUb7wsxioV5PvCfO3YYnMiARxim09xRcZhFb2aF5RGJbPzPPzGdJ8
	RFOYJLP1m5Fe7nQ7Pnn15UHpmlBDjEQI/7BNra0+YM/E28oWaucfR13mZsRGvhfhyx7CGBlLUOryS
	sbO/ok5Ey0Ogo1277jjvnBU22YNSNMKAe89ru9xH5jbsW/k+CaRtVx0rQpNulOXwq9U3GHun8k2Dp
	QRQZyQrXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdBI-0001yG-7x; Tue, 12 Feb 2019 18:53:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdBE-0001xp-Kz
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 18:53:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35DB5A78;
 Tue, 12 Feb 2019 10:53:15 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9193F575;
 Tue, 12 Feb 2019 10:53:12 -0800 (PST)
Subject: Re: [PATCH v3 2/7] dt-bindings: bus: Add binding for the Allwinner
 MBUS controller
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
 <43f965dae8b0ba8dffd3af478c2836c17feaa18b.1549897336.git-series.maxime.ripard@bootlin.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <76a7fe92-6847-b668-2d0e-1eee1d291fc3@arm.com>
Date: Tue, 12 Feb 2019 18:53:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <43f965dae8b0ba8dffd3af478c2836c17feaa18b.1549897336.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_105316_690691_BA866B5D 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: devicetree@vger.kernel.org, Yong Deng <yong.deng@magewell.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Dave Martin <dave.martin@arm.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/02/2019 15:02, Maxime Ripard wrote:
> The MBUS controller drives the MBUS that other devices in the SoC will
> use to perform DMA. It also has a register interface that allows to
> monitor and control the bandwidth and priorities for masters on that
> bus.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>   Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt | 36 +++++++-
>   1 file changed, 36 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt b/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> new file mode 100644
> index 000000000000..e72b7ac9e359
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> @@ -0,0 +1,36 @@
> +Allwinner Memory Bus (MBUS) controller
> +
> +The MBUS controller drives the MBUS that other devices in the SoC will
> +use to perform DMA. It also has a register interface that allows to
> +monitor and control the bandwidth and priorities for masters on that
> +bus.
> +
> +Required properties:
> + - compatible: Must be one of:
> +	- allwinner,sun5i-a13-mbus
> + - reg: Offset and length of the register set for the controller
> + - clocks: phandle to the clock driving the controller
> + - dma-ranges: see booting-without-of.txt

Nit: this is a standard property in DTSpec, so it's probably better to 
refer to that rather than Linux-specific documentation.

Robin.

> + - #interconnect-cells: Must be one, with the argument being the MBUS
> +   port ID
> +
> +Each device having to perform their DMA through the MBUS must have the
> +interconnects and interconnect-names properties set to the MBUS
> +controller and with "dma" as the interconnect name.
> +
> +Example:
> +
> +mbus: dram-controller@1c01000 {
> +	compatible = "allwinner,sun5i-a13-mbus";
> +	reg = <0x01c01000 0x1000>;
> +	clocks = <&ccu CLK_MBUS>;
> +	dma-ranges = <0x00000000 0x40000000 0x20000000>;
> +	#interconnect-cells = <1>;
> +};
> +
> +fe0: display-frontend@1e00000 {
> +	compatible = "allwinner,sun5i-a13-display-frontend";
> +	...
> +	interconnects = <&mbus 19>;
> +	interconnect-names = "dma";
> +};
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
