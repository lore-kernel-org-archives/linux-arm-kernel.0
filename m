Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C87C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA6920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SVoCOOnI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="AwxSbRTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA6920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XMuDJrEw+8DG3Pwq8pwttsAKyd6eysL8zV6BUBvEphA=; b=SVoCOOnIYeqpqu
	nEiBYbikl4CVrnuPIIcgkdpEhtp+n6EukA+aT8Mts+7ONIUK9UtVCdCXvKxzkHh4Mwsq1MqhCK/4R
	tfuaA3JhSb1LX8U6xo3e2RAYL19oTdnGgckQvxZ6NX2Zf/qaVC9MArB/oM/HeJsoGAhhuEaNgRRSQ
	GtLD/itIqpK2eP3FjIa14++RSS7KBx0SY5JdcLpyAfUebY/McFFS4v52ELeD+jxUt/ucSbEH1GNW1
	cOzmDHgoe3zB0IAuUFQiEGFy7hlZTq34PcKuGOR8+QJFKaY8SElFehSrfMXHotGTXFxhA2L0coxbY
	dBkp0gJs4NEENdM0L95g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsgt-0004Fx-IS; Fri, 30 Nov 2018 23:59:23 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSses-0002Jl-9e
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:25 +0000
Received: by mail-lj1-x243.google.com with SMTP id t9-v6so6470719ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R8dg54ykK/+h+02bmkBpdQMFlN/31oi3+2h5CrXiM4o=;
 b=AwxSbRTgpxYwSjOkrdsy/13fuf7QOf4qr6V8Nz2O0xhfW7YRCi1cN2Vw+uqV4Wapov
 Q62da8gor5Dy770MZG6TucYKo0z+wqqqb2+TdEiHwZpLMKBmcrCrvkDaqrIsoPTP5V/Z
 wQKfdCedJz3p0Hl6rfJ8Q79PE7LCWYLj00atakic8bhDZ2avVFiph6wWQAByvGYYq6Oj
 OlX7eWyWe+58GN846J79vOwviIfBuplrzDClwWVB3Gef/uqFlkOgPQCIPsLTxEa7WLwp
 ySiEZKgz3PWeZGtMY00K69WWbioz/ZLYdihkyxTFEPxwlq4WKzNDCAyofv4heXOB9bVf
 uisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=R8dg54ykK/+h+02bmkBpdQMFlN/31oi3+2h5CrXiM4o=;
 b=KtmYxdn2FaBd75UapTwvXKhQ0g/6xPSesPW9QoSQIo+dFo63vPtHOMmn6nYuNgQ4D8
 M5tL/4fVk2+LRIIefrJY4wtzh0ERHwORSqrF4SQ/f8h1lMN4cyrBzHE6xCZnj12Npumn
 +i7nmywzk+So0d8Sahd7m6TJ+w0NqfdfIJCmEzPgz5mYulpCd/QycQfCU3CR4FmAWi8d
 uQhaYL0jzLdb1p40QhUqtVifZJgl9BrgGOjUD1Zl8AA4yiRDQedm7nMQcDA35ljnqLvp
 gcdTB+N0C8RlkLaYewlTJ22YNVzyUSTkTfAKj+DRe8EGD1TDa3OXSznv1Mdb5xU+aNQo
 MqZA==
X-Gm-Message-State: AA+aEWZcdEWcONSr9JHkkvFF8gDE4KxOuQMQcwwJO1oxOm5Y3DXqY4q9
 xNhRIGldqYkui1IdAka6vn0HNQ==
X-Google-Smtp-Source: AFSGD/WieTcBo0lOhUWLOgI8WEb1hZqhop1O2hEcNmC+ONM8WokwdogXC6Pe8Pwm/NLLU7Kq3ND1rw==
X-Received: by 2002:a2e:3218:: with SMTP id
 y24-v6mr5569834ljy.157.1543622226381; 
 Fri, 30 Nov 2018 15:57:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id g17sm1140693lfj.36.2018.11.30.15.57.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:04 -0800 (PST)
Date: Fri, 30 Nov 2018 15:20:40 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: add missing memory unit-address
Message-ID: <20181130232040.z4i4sm5dsycxbmlu@localhost>
References: <20181130015251.20754-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130015251.20754-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155718_421773_E597850A 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>, arm@kernel.org,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 07:52:51PM -0600, Rob Herring wrote:
> The base aspeed-g5.dtsi already defines a '/memory@80000000' node, so
> '/memory' in the board files create a duplicate node. We're probably
> getting lucky that the bootloader fixes up the memory node that the
> kernel ends up using. Add the unit-address so it's merged with the base
> node.
> 
> Found with DT json-schema checks.
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Might be better to just remove the node altogether from the SoC dtsi 
> file. It's only saving the device_type definition.

Since I'm sweeping DT pull requests right now, and this is pretty
straightforward, I've applied it to next/dt directly.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
