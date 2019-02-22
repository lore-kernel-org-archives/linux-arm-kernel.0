Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:44:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A108A206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3kmFw2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sssk4xW+fQg7cca+frzCHF7Iy8erhQWoTneRA+Bl2rE=; b=U3kmFw2zRzCFyw
	xJW6qT1Qu02BnTxYgmai3npB4BFAHk4+mM8b9u+3tpwResNHzuNj2hXuiFK4tu2VrDynUorKpJMoq
	FJ/O/w9U9i2uMRE9L4fAo1sunZUJWXYrLaEFKVA9xUcLCmyCjKNL3Cl2qv5rmicy/s0UJe/EK1dlU
	jsNRoU9JkxECu1ddMS2QbgQiLVU7PBTNGAmDZ1MOLowCPZmpCIrJQiI3oepzEh4Ymo3qF3rhD1sdi
	s91jdMIVsSIUd/FO1Z2P+vcon5oPue10bcPutLrHMMlGUTjK8nyurX1ueh+UfRL4rkxkdDZvXJcQY
	+cAbI7tTPo010JGjvRXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKUe-0006X8-JQ; Fri, 22 Feb 2019 23:44:36 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKUa-0006Wp-S1
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:44:34 +0000
Received: by mail-oi1-f194.google.com with SMTP id a81so3063407oii.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TsMu8Tc0IV0e0muIODVfZM/XsSXkFmUhOoNfZ/p2zng=;
 b=fE3RWKZd45tngGjktKPO4iHqO5Y2HJgDcCbO60N2UeivpZF9EiJKZw9wpbwpKSVMBt
 ktPWCo9qwDRmILwJ5MU8sVrp3kWj2QtaN1U6ylPFs4QDco1tmzY0rd7ygEfc3piBhjn+
 COCq8seCg/EbCFC7RvKEMm1EwM2sj6WGCYA89v2mDWnbnuWytrLqHy0mHYqXaSkFMe8q
 Q+TldYbbMk+S05ewZh0H/3CUxJyXK5+obB24OXSJmU79qFpeDs4EhHTNU6FIy/U3AmNb
 CTL5lOrRVC0n4iLaEq+EZG10tevXefXKWAqdHb1CMZS8Q/1pQvZU6kmNMxqBRbX575Kt
 bieQ==
X-Gm-Message-State: AHQUAuYFb9+G6vq1v5s9FtWPP6MLx0giNbMvU3RjIHwIsGyp67G5MZQf
 +lhe1DziqNZ/BpaqYcoRLw==
X-Google-Smtp-Source: AHgI3IaoEebKMVS5eyOUh7mTHzoNK33m8zVNkovRGt1f0X7257zf1G2hI/irS//xNro7MehjmN77lA==
X-Received: by 2002:aca:7290:: with SMTP id p138mr4075438oic.116.1550879070582; 
 Fri, 22 Feb 2019 15:44:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m89sm1163009otc.7.2019.02.22.15.44.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 15:44:29 -0800 (PST)
Date: Fri, 22 Feb 2019 17:44:29 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH v2 3/9] serial: core: add rs485-rts-delay-us devicetree
 property for RS485
Message-ID: <20190222234429.GA19985@bogus>
References: <20190221171758.10322-1-martin.kepplinger@ginzinger.com>
 <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_154432_914199_0C576087 
X-CRM114-Status: GOOD (  17.64  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, alexandre.torgue@st.com, corbet@lwn.net,
 richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
 mcoquelin.stm32@gmail.com, jslaby@suse.com, linux-serial@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 06:17:52PM +0100, Martin Kepplinger wrote:
> struct serial_rs485 now optionally holds the rts delay values in
> microseconds. Users can set these delays in their devicetree descriptions,
> so this adds the microseconds-option with the "rs485-rts-delay-us" boolean
> property.

If it has a value, it's not boolean.

Should the old prop be deprecated?

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.txt |  1 +
>  drivers/tty/serial/serial_core.c                   | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> index b92592dff6dd..77396c62b383 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -12,6 +12,7 @@ Optional properties:
>    * b is the delay between end of data sent and rts signal in milliseconds
>        it corresponds to the delay after sending data and actual release of the line.
>    If this property is not specified, <0 0> is assumed.
> +- rs485-rts-delay-us: the same as rs485-rts-delay, but in microseconds.
>  - rs485-rts-active-low: drive RTS low when sending (default is high).
>  - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
>    feature at boot time. It can be disabled later with proper ioctl.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
