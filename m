Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E0320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NpXZZQvX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1ughh9OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E0320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rsSUApLdN/b+zCMofJISiVuhvpmCGrBvoGzQ7/anvig=; b=NpXZZQvXvYtgLz
	eOOMwpbTI3sXaXByGBr/K2sKHQNkDe12DaQeHikB91fbdNsg3NTv6oN+fl7C/a3JAXqwpz2zOU8Jd
	mwNWBprNMVgxkp1iY55kP25EbKvBpN53Xwoztk2F+RVjA8GK1egzAanTE/2UypynaA+T0Su2PAGOy
	Id2+mVKcLr3vk9CQ5U5lgFOceGe/gbmE+SQIdRNoGAvVu9lk6yb/nOBRYFakjoNJ0kpJgDrKzJ/8T
	vZBHSdg4r1TumgfLw2gCJaqIWdnCSWnW1ID65cGJty/WHlarxO17pOCpXXmuZLZSH41JRm4i+iKYE
	mxe/LEAuw+QdKemwVNxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRO2-0006iQ-10; Tue, 15 Jan 2019 16:16:22 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRNy-0006hz-92
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=lEm3U+NlNVJbms/y3cTGT0Q3sLzO7Ayki6/oi3eCSFQ=; 
 b=1ughh9OBu42lOmLzsT5CIJrbVzl3wWFrc6QUH7uJvSPoaS2hEe0dcggMMASFwg7CNM9QmahfGS8HmO4nZYupi+MbabmdM5QMLM7UtAihhTzs0/w+Ws6LyBcg3W6fOC/a/UBRPjpUNuGdOHblEiiF58MpRgSs9UKC/LsuG8OwXtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gjRNo-0006rg-K0; Tue, 15 Jan 2019 17:16:08 +0100
Date: Tue, 15 Jan 2019 17:16:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>,
 Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190115161608.GA25888@lunn.ch>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
 <20190115144421.29968-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115144421.29968-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_081618_483607_B9391A3B 
X-CRM114-Status: UNSURE (   8.37  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Paul Arola <paul.arola@telus.com>, Scott Roberts <scott.roberts@telus.com>,
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vladimir

Ah, i did not notice early. You need to Cc: the Marvell mvebu
maintainers. They are the ones who will accept this patch.


> +	leds {
> +		pinctrl-names = "default";
> +		compatible = "gpio-leds";
> +
> +		power@487 {
> +			label = "power:green:led1";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};

I'm a bit out of date with dtc warnings. I think the @487 will
generate a warning because there is no reg property?

Gregory, do you know?

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
