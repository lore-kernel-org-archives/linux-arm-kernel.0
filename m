Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A545C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:46:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E394A2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="be+igflM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OYtlgqdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E394A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W+c9SKeBaNCUyh+8kqG5g/4LfF4toi5zLbQTvrLhPNw=; b=be+igflMPoCo3ZxjWvAeHNLdP
	0ct8YccJu6ugzpiXGMiDLEnw/s1m2Z8NG98UALd9FX7KUlJLTPMC/DYLQZtWf05FvBWx28SEEu6RF
	rG1y0+AHetvAS1DHL6S1H+kjeTSNbXrssl/rUgutXwMfCdH1eVTDHdfgeeIrIGbQMJ68C0JqiAJFa
	v3uK6lFXVPzPPFuGQGQU7rIpfZvAFh8Oi094NH/WqUgcfTTwB3CltI+EFIKu18MhTzRqV3Y2QQC/3
	6437IiwVMk97sLJI33aHggMgpWQaHUDFW3fTtRfXmN25mZHDu6WnNdEivgBJATmwSAG4RtlB3Mwsw
	vuZ3xWWzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Qt-0005Dz-UQ; Mon, 28 Jan 2019 10:46:27 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Qp-0005Dc-KZ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:46:25 +0000
Received: by mail-wr1-x443.google.com with SMTP id u4so17466191wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7xfP1tUf/VsLNBv/ssEYuA5S1lcoyPYoNSl4+EAt7XQ=;
 b=OYtlgqdyN0/8ij9QXdav5TTsIa5tVJLlT0Gb6bTfXqPsVLpvbXXLfhMstYquqnbBkN
 3j77MDYAr8mLxg49mNITq/kVLox/bz3Nv64jJk/2QFDnpoLg3I4ZeyIDKGrsBbEkuBRm
 rFAzd9ZYRscposK6MZ/FNNC/XrEKn/4RlxsFMV/uYRBlEh0IX91ME4DN5D4l34587bXb
 BNUhxWX1vf7zVqsMjh40uZPIGCHcLcMKHZZ/RO3BCUX7N5fetPQkyGmT/vfO/+BTFoaL
 QHg6jZQ9behREi5eyslFlK89cvknzyIUNE4PrDJi38YzLIzr679gAaVQYv8c4bOGbx/1
 +wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7xfP1tUf/VsLNBv/ssEYuA5S1lcoyPYoNSl4+EAt7XQ=;
 b=IgTWjdC/aw9Tv0NXu2pUpi4IxIm6C/yBYQb7Q7A3S55/rSgd2wwn5xZJJ2EE8cIQy6
 nbkje38KmmVyuuKfrece7dMuUua1xOxlageTLrx5ZfgIHgsUWqnzmhu0Ka/uDQnoHEfx
 +h2LqesrCBKIJqBNyXusV/ihUGvn/Feq/Obh635LchEG+ZwvsVdw27sveBPevcWVzsOj
 21MmH86UgQaPyCppYvWoB9PzY0I13L70WMB2ZMWi1VH3FZ/g4bPxM61kEjZAVXxGyL+K
 H+eXvc/EbHQ17iiWup2NSNT9cO/V+SGrPFFGsA3R/Vtpidoo9srUh6dOHiET/McCO7JG
 OjKA==
X-Gm-Message-State: AHQUAuYjgWtckgJkp5BFE+vGhe/T2EVXfz4+d8+GF75oevGEO0pic9sM
 PXODII3RI/TeitCTSYg/2VjHpA==
X-Google-Smtp-Source: AHgI3IZCRNgfRWspUyVgnUSAkwBGZbVXvKXFvufQg++9Xatyc0JLjmp9h78zy9llLoC3CcAttws40A==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr7307935wrl.137.1548672381666; 
 Mon, 28 Jan 2019 02:46:21 -0800 (PST)
Received: from xps ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id 133sm84034060wme.9.2019.01.28.02.46.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 28 Jan 2019 02:46:21 -0800 (PST)
Date: Mon, 28 Jan 2019 10:46:20 +0000
From: Carlo Caione <ccaione@baylibre.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190128104620.3e724lfm5xv5il4x@xps>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
 <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_024623_747090_5A580B2E 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>, robh+dt@kernel.org,
 abailon@baylibre.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/01/19 20:27, Heiner Kallweit wrote:

/cut
>>> Thanks for the link. According to the description SmartEEE works 
>>> only if
>>> both link partners support it (hence are Atheros PHY's). I would assume
>>> that this usually isn't the case, shouldn't the feature be an opt-in
>>> therefore?
>>
>> I'm not convinced about that - I've been using AtherOS SmartEEE with
>> i.MX6 for quite some time (I have patches which allow me to read out
>> the stats via ethtool, and configure it - they're specific to the
>> FEC driver though.)  SmartEEE works just like EEE for me, and I
>> notice no problems.
>>
>> I have i.MX6 boards connected to Netgear GS116 and similar switches,
>> and also Marvell DSA switches on other platforms.
>>
>> This is why I said above about "more detail".  Then maybe folk would
>> know what to look for to see whether there is a problem.
>>
>OK, then the description of the referenced patch isn't fully correct
>and SmartEEE and EEE are partially compatible, and the problem is
>just that we don't know exactly to which extent.

Reading from the datasheet at [0] it seems that SmartEEE is compatible 
with EEE but it's something different.

With SmartEEE the PHY can actually enter LPI state even if this is not 
supported by the link partner since the LPI pattern is generated inside 
the PHY itself, so auto-implementing a sort of EEE.

So AFAICT EEE and SmartEEE are two different things requiring two 
different properties in the DTS if we want to have the possibility to 
disable it.

Cheers,

[0] 
https://media.digikey.com/pdf/Data%20Sheets/CSR%20PDFs/AR8031_DS_(Atheros)_Rev1.0_Aug2011.pdf

-- 
Carlo Caione

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
