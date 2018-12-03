Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8450AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:54:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B5D2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oL2bO2+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7ijZAg7K9M7QiAaEePoDnVpsvBYhCQas+X05hAiHGY=; b=oL2bO2+GQ6hsCk
	n9r97QxYpF2sbHNFA/m/MR18splpUH9IhNlIwzvPbujNMBdWaRvsCunf6HRnXhYfGBQkcfx8KxwCh
	QpTsBc1Mc76M2hCtxgA7A1FpWJXkVCeuvVq6Cr9U6WL2bOkU+If40GcfsH+wiHyLy09YiYFxgjNjn
	DXOelojAu922ohQYLyGnL2bu8JFnnI4VLjLTu8X+9QGmqXeTahWxPC2c6rJQd2HysyOVY5C0IoSR+
	IYrwQUnrwuFQnUvGsjZqNu6hm9DQgZmhCQtvdExNx1jMQchYz9fJqSPU5WvepGFZD21ijWivpFhbh
	eu8MnlzJq6XhxG+LVh6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTy2P-0007Fh-4X; Mon, 03 Dec 2018 23:54:05 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTy2M-0007FA-IX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 23:54:03 +0000
Received: by mail-oi1-f196.google.com with SMTP id v6so12673177oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 15:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Vxw/VIEORO8IfiAyKY5LfMRqYKcFHQdzDTPSpZ5mE5M=;
 b=msBdFYWuMvEkaeWS10okzLC3W7ghjbC557oqRKvrXM8Yv4Qs4A06OmkDJW6FOx7rQk
 GorfWm7FfZuZF2K5KyONMVYrcnTqZryadTvu/YbOmnw4Cb8ZhNHh+aOHa71XJfXixVwD
 6hn+mC7qzGYqR5ioX/HyUPOqeW8nN8CW5ZvAJYI8cTdtglArptVsWOJnFtxxbMQF7a4D
 B8HxmgmJZLQScWkGJ3+9GIx8RSFfqU12z1KCavVMMuFXlVEt4P2QVdCiGFBWdLnaxTf9
 nYnpgO3rmeGppO4wTN9beTIYJKC027i7jPUaSJfA0l+n/zluaTuJtenbvkVc5km3deVa
 x+cQ==
X-Gm-Message-State: AA+aEWYoYY0PID08h4dIUByHjP1bFSfirNXSadt6zVQq9Nx3fH9GYgwV
 S/XrKwAGdRmoYr5rAtvNww==
X-Google-Smtp-Source: AFSGD/VQ69yWBpbvo2SJ+2H8JHmW9vMAQun9s4tvjSQWC7sDqs/9Z4Cy2WOR8gAT3a1iYCaK13y9oQ==
X-Received: by 2002:aca:be89:: with SMTP id
 o131mr10771167oif.164.1543881231831; 
 Mon, 03 Dec 2018 15:53:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c23sm6492066otn.21.2018.12.03.15.53.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:53:50 -0800 (PST)
Date: Mon, 3 Dec 2018 17:53:50 -0600
From: Rob Herring <robh@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/6] dt-bindings: phy: Armada 38x common phy bindings
Message-ID: <20181203235350.GA5486@bogus>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMd-00089D-2Q@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gMBMd-00089D-2Q@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_155402_611936_CB337FD8 
X-CRM114-Status: GOOD (  12.91  )
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
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 12 Nov 2018 12:30:47 +0000, Russell King wrote:
> Add the Marvell Armada 38x common phy bindings.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  .../bindings/phy/phy-armada38x-comphy.txt          | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
