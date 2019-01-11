Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3127020874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nZZt7Kic";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="widZMkTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3127020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1CVH4RFq7bhyVvNwCJOjnfohzBlywJ+273AODk8NOU=; b=nZZt7KicEmqA8m
	l4LvLR/rlvxKaQpp/b0iIKljIqItofnoY2+awhnpKTa6AW3a63dx42seSm0uX5y91nRYnUacVJkPQ
	ROKCknIUAZvFQjt7B5Sd+fBcSuOA9xK80drof02klBD/E958xmkqumLSJP+J/3LwpqMqcm61JcJVN
	8RyGgcjLmikYBWqN7zuioeYKfin1+4LClMzjoG96GSELHOttPffDf/zgX1e3iH7P8/izCpYdMzXqB
	Dudo1aBFHsv5dZN5SlipqHkT7SLuk3spPaBAJjdBEgzmlCCkGURqr6gCY70vV0tqQhyGoPsDHbF2D
	7rns/tjRS9CDNujYjYUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0rJ-0004yl-Ul; Fri, 11 Jan 2019 17:44:41 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0rG-0004yR-Ay
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:44:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=0bD/6fn7Q+KxfAycAKv2cI4cVSk8itVXjSfNxDHugQk=; 
 b=widZMkTy2WBxOwHqnM4dVyoMDBG2szKfTIo7wRCyLLnixQO0KnFwktrarmebiuX7u0L0pe1H2rgRZwHFLcHLYGcxUG1FPxWWWnK8uQoHNNUnzCtHJc0gVNiNI1a4qP/HUOetRZUGLhFioEO+WPUwzqcnryc4nZbc4T1LmhT5n0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gi0rA-0002gz-Ld; Fri, 11 Jan 2019 18:44:32 +0100
Date: Fri, 11 Jan 2019 18:44:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190111174432.GH20924@lunn.ch>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111172055.30451-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_094438_523176_6CE74D9E 
X-CRM114-Status: UNSURE (   8.65  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
 Paul Arola <paul.arola@telus.com>, Luis Torres <luis.torres@methode.com>,
 Scott Roberts <scott.roberts@telus.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +	sfp_eth0: sfp-eth0 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c0>;
> +		los-gpio = <&gpiosb 2 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&gpiosb 3 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&gpiosb 4 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	sfp_eth1: sfp-eth1 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
> +	};
> +};

> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c04";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c04";
> +		reg = <0x50>;
> +	};
> +};

The SFP driver will export the 'eeprom' via ethtool --module-info.
Please don't add a standard EEPROM.

       Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
