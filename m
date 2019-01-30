Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B17A20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ct+qjOOM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tw22amRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DxenmfwK2sGN28gSsvfDmJdCLbnVnzu5TOMc4gL98dQ=; b=ct+qjOOMP1Tu0d80E7YoXzqpd
	2+mMUc5fUX/viv7n8WfjaSlgZ0ov+Dh2+duTLLvv2ZsMekLIdtltYJSRakjkDVnSfbRy4GpeRP+rW
	oso1N816idHv/2Fb4jpkmO+RZEcrSoNxF5M/WY+lbqSk/+/qW8k7Kywbxbv5saFvi+TSj4S/Sdm3c
	o35y8xm4zHCeh8yl3EDA4kXl4InQt+FABgqlCVTSJiAjN2iYP2pYccM+6U40+UXuqvZn9Mdnk1/2a
	McoIuNfCXMtNGcGccZqavlsfqla0ObAK3qxmkSJGolCVMBV6o21WainM770XV1JCfoLCyYf0lOmEx
	1iuyF0NAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomvH-0000Fu-3G; Wed, 30 Jan 2019 10:16:47 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomvD-0000FA-Gw
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:16:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so25338301wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DcYjNMOXYZeSsr7HePExziPGNrJwGIroXR2N7eGwBAA=;
 b=Tw22amRzynwUUqwKVKX5z8lWAC9hmNeV02cTEbnXXdcp8qUseDpwX5ie5PJOkzQHl2
 gK9J1svfRFEwkJNc9RRLi9YCcprbtHWGaEBAwpKK6E2WwRZ+bUkIKY/sDdycF9E9kG9/
 lMz/4b07P8uUyC3mGyAxsTRqlXE48y8NjZE8STHy3mJoW5eN3VGpvJdSai9lNyOcTu51
 7QP8v3zBngLVpL/P78bgIhVFLWoESGuRQP7AbHMUTHzLbRZ6URBpqpxIlJ2KwuyRfOw4
 kTZd991mEfxzDDExOEaUea8Ha5KQdkXC4Axp5Ol9DESEk2mgsyN+gTg+x0CmFytF8X6w
 OjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DcYjNMOXYZeSsr7HePExziPGNrJwGIroXR2N7eGwBAA=;
 b=AIlNqyQuihwiACtdyaL4gz0K6aDQmoTiluo2CzxEAGfqyTsuUMzsu6XBJCg6hqX4j/
 NWI4DdzjQjKDFPlNNhgIQhQ4iZ6rfc0zodsjkiIwjqXESwoy9c36cSKbVZNvXPpGZ7Qd
 Eda18BP+SPrK8lEOt0MExixE0LqdF947dHkUlk9uStKjg6sQt2c+VhHFTT1MOxWALdO6
 hllz51u17Q9G3+ouZwAYBV3O1waAJqb2KyYVXMejDQheVWNVv74ibisFdc6ORaC1I659
 9T1TkodljmfcwwkSN31dw7l9avKvOdG6Rxc9YrG3C3ceiLT81fbErNaAhlC/ZDax9UQm
 ZN7Q==
X-Gm-Message-State: AJcUukd5Cl6AEfzfqixe5UEOdbtsfkYLxyzSB+OCCCh8uBPk7Mentw7q
 qIFa6JTkpYihCs70pZRCzEOJkQ==
X-Google-Smtp-Source: ALg8bN5W4CIHqEhZrojfAzteIZ4DHIy+tlEGsG4ZfzZZn2H2lgSKnafRLupQsQRTzdXZAP0eooFtvw==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr28332915wrm.328.1548843401738; 
 Wed, 30 Jan 2019 02:16:41 -0800 (PST)
Received: from ?IPv6:2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6?
 ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id r9sm3242336wmb.27.2019.01.30.02.16.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 02:16:40 -0800 (PST)
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
 <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
 <20190128104620.3e724lfm5xv5il4x@xps>
 <20190128155739.yyftnu7a5hz6if7d@e5254000004ec.dyn.armlinux.org.uk>
 <9118a1cc-7ad7-cdfc-4925-d609efbc8265@gmail.com>
 <20190128190401.zzus6m6fjxpyf36d@e5254000004ec.dyn.armlinux.org.uk>
From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <5b7fa0ee-eea9-d92f-5cdf-6c1b83a61c89@baylibre.com>
Date: Wed, 30 Jan 2019 10:16:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128190401.zzus6m6fjxpyf36d@e5254000004ec.dyn.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021643_704446_BE40CF9D 
X-CRM114-Status: GOOD (  17.83  )
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
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
 abailon@baylibre.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 19:04, Russell King - ARM Linux admin wrote:

Hi Russell,

> There is no "advertisement of SmartEEE" - it's just EEE.  That is
> because as far as the link partner is concerned, SmartEEE is just
> EEE.
> 
> Carlio posted a link to one of the datasheets for the family.  In
> there, it describes the EEE capability register, which describes
> what is supported, and the EEE wake error counter register.
> 
> It also describes the EEE advertisement and link parter advertisement
> registers.
> 
> All these registers correspond to the 802.3 section 45 defined MMD
> and address offsets found in Clause 45 compliant PHYs, and these
> registers control not only EEE but also SmartEEE.
> 
> Please stop thinking that SmartEEE is different on the link partner
> side from EEE - as far as the link partner is concerned, there is
> no difference.  The difference is all to do with the MAC side of
> the local PHY.

Thank you for clarifying how the SmartEEE is really working.

Now, the problem is that the MMD registers controlling the EEE (7.3c and 
7.3d, touched by the "eee-broken-*" property) are not the same as the 
ones for the SmartEEE (3.805b, 3.805c, 3.805d). So, is it worth to add a 
new DT property to deal also with the cases where we want to selectively 
disable the SmartEEE?

Thanks,

--
Carlo Caione

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
