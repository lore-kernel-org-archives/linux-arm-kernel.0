Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA25C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8478E20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jMKo0v91";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fw37EuZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8478E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nXAYTCfgYdM4P7oKW9oCK85AfFPnMjdmJYigxhbK9WI=; b=jMKo0v91h+J+Xjan3ub5+Z1wa
	VgnMjKAfOMCZRidZT5Yu3RWSXVRQK2y/Sgg1B1hu4xZRdj11nETIovnvio4cp3OweTw5yk72ugmXG
	4TD20xMll4RFW9o/lt+2whDf/ai3QFCTIPE7ZKMyrIO1GDjbLoyroPozUEa76YrVpnc8fhUSoqdqr
	kbNUXY7Ee9VzLDKUJ+OoaWrSlfsG24b7Op1ffI+Vs6h60OLXYiBornQnOJIqIy6jnf3zjrU1V1wAL
	dYdjpyEq62VxSz01u1N0czZ8wdYYXrMgxo9WE0XVnwISBzKBxp3AMsxCws9csn/YKTN45W7iTgHIb
	m0IF2i/8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNdR-0000d4-L5; Tue, 15 Jan 2019 12:16:01 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNdO-0000cc-Eb
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:15:59 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so2677834wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 04:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QYpZFokLKelMXguvF1cqJWGpCfsdP5gJ955eokNSo1w=;
 b=fw37EuZEgQVJ6gHnV/VpoRr3nTj0w8I+mHs7V0PVIcFsdwFfSFaz0K0zB3hXXNNCfu
 Oy0mEB0D2+cdV9BJl2CZsFLQ7QTiKrvqTrjKD53UXYBnqyb+DjEdaDcvSOM3aKanHsjA
 jYRLv/Lw8ueqKb+IjWX6X4yDOeh6cUa3V5g58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QYpZFokLKelMXguvF1cqJWGpCfsdP5gJ955eokNSo1w=;
 b=XAn7+vrWG9GKwlB+Rg+g6CquB3h8kb0Mma9t1qJ6sF1hP5OH2nZYE8qUe8pcJDmrd7
 iaLS0qB+vJvCE4Pz2mZvR8tUG5odTMvXuLADZcIJgeZsaPmXO6uA9UObpV93VboXJb9C
 sex47ynUIQBYqyvv5/zi2dG0oUXA1yH8FTmqoWzKTQFhigVrBLTT7aodMD8CNBWAJUbL
 w4BmnJFNHMkGgtAqY3M0+crdWDTENMBtZPNByQoqerHZFZR8NCkpNh4A5w5+pUV+h9qQ
 LXx/iyZvo6yKxT8gei4CjvR97wE6yAIUwBY9zLOrVSVUEGYOAbELIVBWKBvgAsT29eaC
 d65Q==
X-Gm-Message-State: AJcUukfC15rOvVzojfAXEHRlf03YOVeWkCuqgeCzuh7zGWNx2mIg4ldK
 chnGgIZqxB2zCsgSopXJeCF0GwuOeUg=
X-Google-Smtp-Source: ALg8bN5PPBh2eTXKloSQmyp5qFEC9J/Ylb72tw9J/Wl7RsK3qkLTKDv3JriEqiJbS2stdGe6sfPzgw==
X-Received: by 2002:adf:aa9c:: with SMTP id h28mr2867542wrc.216.1547554556175; 
 Tue, 15 Jan 2019 04:15:56 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id 3sm35763269wmw.46.2019.01.15.04.15.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 04:15:55 -0800 (PST)
Subject: Re: [PATCH 0/3] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
 <7ca64f1d-8649-79a3-4c48-5242a68a837b@i2se.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <adecee28-e26f-4831-00da-804ca0cfc194@linaro.org>
Date: Tue, 15 Jan 2019 12:15:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7ca64f1d-8649-79a3-4c48-5242a68a837b@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_041558_499374_8B1B0F61 
X-CRM114-Status: GOOD (  15.02  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 15/01/2019 10:17, Stefan Wahren wrote:
> Hi Shawn,
> hi Srinivas,
> 
> Am 11.12.18 um 14:51 schrieb Stefan Wahren:
>> According to the reference manuals for i.MX6ULL and i.MX6ULZ both SoCs
>> only support 8 OTP banks instead of 16. So we can't use the compatible
>> string of i.MX6UL.
>>
>> Stefan Wahren (3):
>>    dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
>>    nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
>>    ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible
>>
>>   Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>>   arch/arm/boot/dts/imx6ull.dtsi                        | 4 ++++
>>   drivers/nvmem/imx-ocotp.c                             | 7 +++++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
> Rob already gave his Reviewed-By for the binding. Are you fine with the rest of the series?

Applied 1 and 2.

Thanks,
srini
> 
> Regards
> Stefan
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
