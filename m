Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D632C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:11:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392C42082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXYrdCxn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CwNrNyOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392C42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iphAz37x/nSewCJVSk0gwvRBOAUQKmddwFHc6t504wQ=; b=uXYrdCxnF0MzWq
	YpC+DZvLZsg8TK7x3EefqmC/LxLH+ShTnhGYThdmUl2noLrc4ABrEqw9CJU2B0zWiQDkD74Qjm8EK
	vyIpDKHHCt2S8PiHo5Aa4HDrSQdGfw/+Y46Cse1ywm7vf/sO8TSA1o8R8OOkB1RqzGD3I4I3qEqkL
	qbMZDLTWs22y4Ab/hF7/h8AHN5AfaR9cwVWuEohwWPvphdiymVWK8v4lJqNZbX8TTdntGNAnG/T/0
	oU5+KiV+Wsl2rsEhwPra983wWlhR0jjqip4sXRdDSR6ZjIKqzOUIbPo4eQaHX+gJ8JxBO9brghAL8
	IxPvaB00uxui596IOBmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUKmv-0000Tq-Fc; Wed, 05 Dec 2018 00:11:37 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUKms-0000Sy-7b
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:11:35 +0000
Received: by mail-pf1-x442.google.com with SMTP id h3so9060221pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 16:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MyXV8qcJJ7uOd5iHnPSCIj0jr1yTwKaB0MjRoosOzrE=;
 b=CwNrNyOVoVas7Sr44m1xf3Lh/PXx3l1BtNARe6s/9LzEKbtYsAWGU/j/gxp0qp4hTK
 O0e3dJveaATZnD+bjAYm+E+34CpQg9QGY5rGAj0f17z7LLExMOSyCurEZ9N7v1YoZB5b
 7lQr0RbNTyE/N3kyS2mccCn2q3bu4b1pHuTCgIjXmU1c/8B2mEPdl5Cw2RX9VIl8VvEv
 n2VqE5Xf+8SxFidMq1n+t4+H9n8Vv2FnWirOs0S5N3WEjOb8H1KbwkEPFweCx7WcNNxq
 4tEZGnFB9t69a6tmMSyEspjKw6fjyj8IQYQwRG7So9e2j4H6hQbof/s79cmrxXj/D//Z
 v8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MyXV8qcJJ7uOd5iHnPSCIj0jr1yTwKaB0MjRoosOzrE=;
 b=Vl4z7E2WSeWU8H7z4IPmzC2EzAWetUnGawGmSEu2KGzqhMRMxQ1YhFfWbDIDY+11P6
 J0hoES9I/KTtkO3hYAQ28N40Of+g4IVlTel4WXGM6cx0zBBLRWpQrTnni8seTTCuTRBw
 3BLNMSssARwNx1QlkBt6kCg40gCQWZnejxH8sgGXquuhfh4Kbd7IreCJh4wvbBekFiPb
 HB5Ju8ls2zWoFohTxwWrcIddEvFPWz+30UtnB+aqfKwJuKmsGvKzhvWWwAurNTehe7ly
 yrC8oc69tp7bK1tuMVJJa2GusYfVVf6UDJAwB8W8rh+cwfnunS73KvvdVsgr8YE00X74
 RBog==
X-Gm-Message-State: AA+aEWZtkzPI2RIgsazccAgU7y7ueu2PBOxVPW1d+PMTvzanR7Vx6lkC
 rR9ThY05DlVXzEpMwaRnFhF2UA==
X-Google-Smtp-Source: AFSGD/WuZq8ZVKLD/CmPrFvK/b7VWfMj7wpoIoTeuqxLQ9KD9OZB4R4gT0anmtsHOz82jhbOTOvmaQ==
X-Received: by 2002:a63:9d05:: with SMTP id i5mr17111958pgd.98.1543968682286; 
 Tue, 04 Dec 2018 16:11:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
 by smtp.gmail.com with ESMTPSA id k38sm29402672pgb.33.2018.12.04.16.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 16:11:21 -0800 (PST)
Subject: Re: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Hans de Goede <hdegoede@redhat.com>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
Date: Tue, 4 Dec 2018 17:11:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204192831.12440-1-miquel.raynal@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_161134_281617_2FBDD9FB 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/18 12:28 PM, Miquel Raynal wrote:
> Hello,
> 
> As part of an effort to bring suspend to RAM support to Armada 3700
> SoCs (main target: ESPRESSObin), this series handles the work around
> the SATA IP.
> 
> First, a change in the libahci platform adds support for the new PHY
> framework by following the phy_set_mode()/phy_power_on()
> sequence. Then, the AHCI MVEBU driver is a bit updated (patch 2 & 3)
> and a missing initialization is added for the A3700 in patch 4 (only
> done by the Bootloader before). Missing clock support is implemented
> in patch 5 to be sure the clock will be resumed before this driver
> (see [1] for the series adding device links to the clock core).
> 
> Finally, device trees are updated to reflect the hardware: the missing
> PHY is added to the ESPRESSObin DT, and the clock is added to the SoC
> DT (patch 6 & 7). Bindings already document the clock and the PHY so
> no update is needed on this regard.

Probably the best/easiest to queue this through the libata tree for
4.21. Agree?

-- 
Jens Axboe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
