Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD2E2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGsm0pdT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orYKLCJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD2E2190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LQMWjpSBvAE0H6dVu8i95HycZRf661USsUJQTr2/9ZM=; b=aGsm0pdT72EfcpyXKdXO3c2V+
	ru6lxrABykrMnSOLRlJQUHBmfBpHzQZP9Vh2vSO4NDJsKLDE2edPTptEJ2tF8l3Pvfg0huGuYXhoJ
	3dIP6xYWay5l67Os/5ivPQ3r3CqlDO50EKzskHFfzClcKfXBVKtYUFXXVJXALK/gwD9Q21RnQ+Evc
	2Xo7+R3vTy5HdMS5XRjWS4MfFzRRuduOP9Th0NI0lC+1jNc1XhI4TePsEhSlzJp/2csd8WKQ7FDdo
	VTpFY7N60YUq0iSr565hPPVdr3xLY7dlUwRRScFnvJ+PTsWU8YNioMzVqR1TxFdOKqpdatNSlwKDR
	zKitgWd7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrs1-00007R-Um; Wed, 13 Feb 2019 10:34:25 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrry-00005h-Nl
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:34:24 +0000
Received: by mail-wr1-x441.google.com with SMTP id t18so1896535wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LieBVVVdKyP95R11D2/eV7vtBd1PQludtrUBXGSu3nM=;
 b=orYKLCJUmA96E1zSha13AuODx2x5fQdXLKXU8d50AMbg+kdqmzUM+qFpsuP/dlCjdc
 QyfdBvRL9B+WQ5KonUOwh+qqI3cT9A5znkCjaTB5XnvPQ152e7wiE7fzRDcU9AnaR1Xw
 7hBCRh+0fFJsBLyZP9nD3Fs3398b8P2Lfk2vkaYsJWmIT/7eNVEWNBsEQHG0P4CtP94G
 zSXks0IWEi6abI0382kHkp/Kmut8gXu9Wz4OesAITTKmOIt2E23lY9pxFpK47/e1nRBh
 x1rCYqSBqtZWDPphniqxZ99zShFjiFzeMAM4iS/lFKgjfCiKdLlLECLhQmi5Hk2qKlcc
 IzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LieBVVVdKyP95R11D2/eV7vtBd1PQludtrUBXGSu3nM=;
 b=U0eYeB/+bhWNHMwpiBMr304GN6n/duVS/wGL4Rr726V6XFrByhLUFnz+JYL/Qjiv2w
 QW+GfB4AK6LX46eus0RRdAbPQd38yc6WFBDHOayexNN9imOO2HILU2rLxySxduQhedbZ
 gdKfxTMaKLSHUgc/B9sI92zvh93/MtQlqkNY8HSxYGbhcHRyp0xB+qyEEAc0trj0+r71
 /CBxdtWcv1WeeyI38u6v9A1LpOpv75aQf2w2reQEwLkN5exja72co3PY1bMW0Lm6Jcck
 He6nlXZ+0kzlj7L032MiKoIXFX1jXlClsPxr9fEE2qvd0SOKqBm5yE6H9/SxRQMAPrIh
 mDiw==
X-Gm-Message-State: AHQUAuZ/d3dzUloIDmW0b2BCkD/Uv5ZgILegmC/w1ynwruEd0lebSuuZ
 ZzkH7/YWxlsfFVm+wq0Z1M6M8Q==
X-Google-Smtp-Source: AHgI3IZ9gdzX+Ei5Qdffvbq/TjBcqttowzcjuLbJBczHgzdJ7VS4+1MlY1pwpNqAwF2hvmdofluffA==
X-Received: by 2002:a5d:42c3:: with SMTP id t3mr6261626wrr.232.1550054060836; 
 Wed, 13 Feb 2019 02:34:20 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id e9sm27785424wrc.56.2019.02.13.02.34.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 02:34:20 -0800 (PST)
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To: Fabrice Gasnier <fabrice.gasnier@st.com>, robh+dt@kernel.org,
 alexandre.torgue@st.com
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
Date: Wed, 13 Feb 2019 10:34:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_023422_787492_BF93DDDE 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/02/2019 10:15, Fabrice Gasnier wrote:
> On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
>> Non volatile memory area is available on STM32. It contains various
>> factory programmed information such as unique device ID, analog calibration...
>> This patchset adds NVMEM support to access these data.
> 
> Hello,
> 
> Gentle reminder for this new driver review
Nvmem provider driver itself looks fine for me, but I am unable to take 
this as 5.1 material, as I normally take nvmem patches which are 
reviewed and ready before rc5.

dt bindings patch needs an ack from DT maintainers.

Thanks,
srini
> 
> Best Regards,
> Fabrice
> 
>>
>> Fabrice Gasnier (4):
>>    dt-bindings: nvmem: Add STM32 factory-programmed romem
>>    nvmem: Add driver for STM32 factory-programmed read only mem
>>    nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>>    ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
>>
>>   .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
>>   arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
>>   drivers/nvmem/Kconfig                              |  10 +
>>   drivers/nvmem/Makefile                             |   2 +
>>   drivers/nvmem/stm32-romem.c                        | 202 +++++++++++++++++++++
>>   5 files changed, 258 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>>   create mode 100644 drivers/nvmem/stm32-romem.c
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
