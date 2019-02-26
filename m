Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC43C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C21B213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D5yd7G4J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kg7jp8Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C21B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=83xsZ8SoHjV3jh5HEz1pXNCGE+gS1ryq60W/AYVSXys=; b=D5yd7G4JkbnzuTnzVzoS3P7nF
	/LryWXQx2Ud3MDezrSjlNIeDLuvPoz+ARiOhbTcQtSgp0o9seZOwV/E4xJcCFaxuAYsU3jm3mA782
	x/fXp/lgtb7s43FlzVsjKVrHT5lii7CmGyDkIUeZa9zTsDZXjXL/Iu2U0L8SLoCHyqo1fElEUoPqa
	QRY/L93W5g3QuffpVlFmiO3DxRCD2fcFELZEyMF+T3WyU7jfi9RcUviVDEdjGnk5I9tZiSaM3zxPs
	ZgZ7T8ctbQACSVrk2cxdl51TiQb6VvBTQeDFvJa+EqoY7KSAJFv2n5q6FTFcSg+mJl3CDxgaaNESI
	WTMs18GQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYYC-0004as-NS; Tue, 26 Feb 2019 08:57:20 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYY9-0004aI-Pd
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 08:57:19 +0000
Received: by mail-wr1-x443.google.com with SMTP id l5so12972981wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S35F2dY0IkDH0zCO63ymoahlalUNx6qu+5BTWvJk4YY=;
 b=kg7jp8ErPi0+a4M8kmC7FTAF0Iqpdx6JVd7nYWSvF33J9NLSGVS4cEd5DTk5LAJClk
 29Wj+1D0nBLyKzsLeOFJ9/vxSErsJbSCjpFrSztPmF72HsinYILN6R4Sx69bO0Jvc0wH
 0BjGq+D8iBAth0bvTiy/zExN2YZ6RDcKnJXZ7yqKxu/nFlCtruGcE7Svrg7Eje9tNbBb
 DZXxTTHQyM3EZHDiQDglInXGdc+7eYGlHYSMjHy0YZX6wFT8Q2A5csbGL1UGKF4JMFI8
 bBz5oUcg5eOB9Hpm5SWEBOV21RbJCQq/398lm7kynIRv7/1aVgbN722rhcQ6fuN5/PqF
 LFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S35F2dY0IkDH0zCO63ymoahlalUNx6qu+5BTWvJk4YY=;
 b=LkW/iHeAKtfXryJ9h4Xz+0p4gYIroZbE5nAmE7vCRfG9V8Oo9RQEJnJscz4sPZdmBJ
 A6iLQH35+Nd1H0eVVQyDCPfiP19S12XNpUh6GOcwBm23cN0ei/TR98Czan9r7eL4+fD9
 FniwoaDJsPY07J9Gu4yTmAA0hLm9XjCcTd7qGj153XKkg6M4s48PdGIrSzFeJ7AmIk4v
 bvDvPqHOnG0iVAd1ZN/fDhyanbOsPaVcyaBaFTL3H8ZglXZIASvgUkemPIBsCSbCyYqP
 GZDxv3Ow1RHM8XQnfpXhDqlTmiyRNed/DF88gHMCsAFwpqo/GibTj8qcRGQkNxN3nlhK
 8x9Q==
X-Gm-Message-State: AHQUAuasCnW/DWDBkM/MaVMFAcjRvSq0LfZe+oT0qCGQXn+vo6lBnPs5
 UAV/pIV8E99iX6VQgE06RYGP/UwsqGY=
X-Google-Smtp-Source: AHgI3IZ9PoLfc3RjKZel4JxK3z+35ibPGYc3fMNqw6rmynZ6+dVMmpyRgmCzccbLcAAEaQVkXJ4TkQ==
X-Received: by 2002:adf:f792:: with SMTP id q18mr11275310wrp.324.1551171435329; 
 Tue, 26 Feb 2019 00:57:15 -0800 (PST)
Received: from ?IPv6:2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6?
 ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id o30sm12666362wro.57.2019.02.26.00.57.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:57:14 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
To: Abel Vesa <abel.vesa@nxp.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190225151127.elg2iuaxa4otdb46@fsr-ub1664-175>
From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <e0af9818-86cf-c341-61a4-0a1406b07880@baylibre.com>
Date: Tue, 26 Feb 2019 08:57:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225151127.elg2iuaxa4otdb46@fsr-ub1664-175>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_005717_889954_1770D20F 
X-CRM114-Status: GOOD (  17.26  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/02/2019 15:11, Abel Vesa wrote:
> On 19-02-02 15:06:36, Carlo Caione wrote:
>> Add a new node to enable the On-Chip OTP controller and add the new
>> binding in the documentation.
>>
>> Carlo Caione (2):
>>    arm64: dts: imx8mq: Add on-chip OTP controller node
>>    dt-bindings: imx-ocotp: Add i.MX8MQ compatible
>>
>>   Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi             | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>
>> -- 
>> 2.19.1
>>
> 
> What's the status of this patchseries ?
> 
> It would help a lot if we would manage to get this in.

Uh, for some reason I thought Lucas was going to take care of this.
I'll submit a v2 now.

--
Carlo Caione


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
