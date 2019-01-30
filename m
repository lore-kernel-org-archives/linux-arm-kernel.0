Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC47C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E69B2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BYfeoOsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E69B2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pKLjIFiTv3HJlvSpSg5oljzUuFMBQDnQsdQXEgej9/M=; b=BYfeoOsx4EaSOJ
	LhlVkftwteZT5gNXoKchpq8AqjVogMe3WgYWWEHLFkK0tHVoljg3L1k2q5MuvsPrsgnRQR9GlpRTk
	pxZQEHVIXlRt5XMnAZQSgSAIKWs3CvqYy/AkeKruIFFnz/P4h447DYgJ+B9KzzrVTlTN75u3AgelO
	AXDvXgMJpC101cqRCH7lMC7Cl1AeaENAID+HBiDwyNf2x9DtZFuEUuc7x1dF8dJsBvZz05kZLDUtj
	I0K9yP/Zq1mCLXpk3xJXHADhQV24NRbTlwRGmg48tByKlxH03S9b1OE+q712+cUXfwtyAIvVnrDvp
	X/sd70grv+dhk7dv+msg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goscr-0004Jm-N3; Wed, 30 Jan 2019 16:22:09 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goscn-0004IK-U1; Wed, 30 Jan 2019 16:22:07 +0000
Received: by mail-oi1-f195.google.com with SMTP id v6so112325oif.2;
 Wed, 30 Jan 2019 08:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KN1aOOGffgyHdr/32v6SqWUL8gWXLKTH4oDU1/suvRA=;
 b=emvDXKIQsNC6DO70AIn7fh1XiR9OuKDgL9Pa7iDTe4B9D3ucXTLsm4DY2GqSdNiTgf
 mWS+co58GD16ASXfLXP3QGs1xtEi1emBNjzAtPB5K3arJVOpBk0dmBnMyoZbgftgv1d0
 RtoRjdScOC9JzCXK9ZuJHQ3gdXfw3W4maAgifAxrpVgcDJsxxv3fgbxYRXrLSq7Yvz0o
 WpAEQL3dg4718oEvpZqLzNjJdXBfOrLvskGbM+uJzS6c2XhUFNhaIP/qJC82edGekwM9
 Ku+BOQ4yFiQ4W8u8weZQXR24x+5hT0adIVeFpwQU9Ow2N5/hO3l7gmVzxnE9cLYRh/AV
 E2RQ==
X-Gm-Message-State: AHQUAuYGPulP6EYblvAyev06CgfmfIUBhyCtmkaJVjZY4vZ22jkdtDAi
 FFTVL90iCf1tZUT9HDTkfQ==
X-Google-Smtp-Source: AHgI3IYDHzc1okMvkTuFmyyJ3jddXAwbzHWN9WsfAOKvP0GGvj9I52uGbMLR5RytVLmhuFgMtnkOUA==
X-Received: by 2002:aca:d78b:: with SMTP id
 o133mr12135907oig.232.1548865325100; 
 Wed, 30 Jan 2019 08:22:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w4sm698235otm.46.2019.01.30.08.22.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 08:22:04 -0800 (PST)
Date: Wed, 30 Jan 2019 10:22:04 -0600
From: Rob Herring <robh@kernel.org>
To: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Message-ID: <20190130162204.GA1521@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_082205_970449_3B79C544 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
 mars.cheng@mediatek.com, Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
 linux-clk@vger.kernel.org, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>,
 linux-serial@vger.kernel.org, yingjoe.chen@mediatek.com,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> From: Ben Ho <Ben.Ho@mediatek.com>
> 
> Add basic chip support for Mediatek 8183, include
> pinctrl file, uart node with correct uart clocks, pwrap device
> 
> Add clock controller nodes, include topckgen, infracfg,
> apmixedsys and subsystem.
> 
> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---


> +	sysirq: intpol-controller@c530a80 {

interrupt-controller@...


Place all the MMIO peripherals under one or more simple-bus nodes.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
