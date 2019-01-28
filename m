Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E9C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41E421741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iEp+8fT/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dXfTwVc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41E421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Quk/UdM5V1sYb3g++qbvQcF/wm2NxwalTooRHrk+ECs=; b=iEp+8fT/FFvqwb
	XURhZOcVzOovm7IJ4wOi8uGfpnziycbCCNu+T0hjW0/GhBiuTmIFbPQJk63OloDicEosAFaxjX7Lk
	IL69JGY8fWTkAsadC1ZeqwSb+VAw67zQT0KuwtHlrznQdYszPDlGZ1I18w0eSxC0Nipy5LbnxDGFj
	gTg5TqDdoAMSBGFaFIQ6UXYWjGVPftOzDtJgis/aFqLMF+RPm41P8mk0+yrIZG4V8owD/zBIQmGyh
	EaSmGalNL5wDE3TKvBfz5BzUsoiPYhq9BTYbfprZJm8ZJMa39RaSsA5ME5BnNcN6rorvupUnT1yKl
	irVz4/DfPV3gSAY+LnEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCdG-0001cD-3u; Mon, 28 Jan 2019 19:31:46 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCdC-0001bo-NA
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:31:44 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so8188096pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c4sq5QNCH6X83p5VVC8SEGlVPFetVhIWyH3awcb2tbQ=;
 b=dXfTwVc9OO27KTyVD87Z0yZ8nPCi+y0EhnKNbgAmbZT5yaO3dUhVCeQ/gycZ+ana8b
 plprhaeMM+mNP0KLhzYSf3c4IPJ3JfW9BHnMhyFq2ZTfUwYEFmcr9cIa3OIQ7HqgEIkA
 uAzQNyPLRojgVDSlipRp3Jztskt084fO2+Rvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c4sq5QNCH6X83p5VVC8SEGlVPFetVhIWyH3awcb2tbQ=;
 b=Mfnb2Utzm5N8mf7lorG8pLHQRRs+agFysrXsWWdmdoVYwlsj/mKptUQGsA2PXXaMhM
 2yfZJk9V0p17hz87wYsNy9iar25np6Z6k9i59MGTGTBN77jbYADDf9squDb4l68i8fwa
 PM8pmfKFjAaUxm1EK9RCcxkAq9xkbmB8IbwaQ/VsdILZfG0KkLO0yH9Jv5+RLdEL6Hxh
 ycHmzjGuJH8UdAag1jAi05iyKDH1hnXZk9r2xBGPaCzm7D2g1SpQdqMW+xwyyqSPUf8o
 UlYqKBDR+ax9AxNE87LriLUFuegyBEZUSxq/2tfZ4jfMvB21XHf+OtnKqekCG4BhhNys
 CmjQ==
X-Gm-Message-State: AJcUukcRddEFcGc3i7qLXt2uc9ybTiVkiMF+IJEBXsYJoNAZLE4PkEIi
 dbBzy8vBGE8AR06MJ3JWySR8sg==
X-Google-Smtp-Source: ALg8bN60vUlnR5KheML4KFtRDNESKi8Gq3t8C3ZZui5R3UiAQb8S4CNvAh3NFU2deIKAIL6FiLz6bg==
X-Received: by 2002:a17:902:bc81:: with SMTP id
 bb1mr22538826plb.223.1548703901410; 
 Mon, 28 Jan 2019 11:31:41 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id c4sm67597103pfm.151.2019.01.28.11.31.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 11:31:40 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
From: Ray Jui <ray.jui@broadcom.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 rjui@broadcom.com, Wolfram Sang <wsa@the-dreams.de>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Message-ID: <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
Date: Mon, 28 Jan 2019 11:31:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_113142_755499_416FEDE8 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: mark.rutland@arm.com, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
 ajayg@nvidia.com, wsa@the-dreams.de, rayagonoda.kokatanur@braodcom.com,
 aaron.wu@analog.com, pierre-yves.mordret@st.com, kramasub@codeaurora.org,
 linux-i2c@vger.kernel.org, manivannan.sadhasivam@linaro.org, jdelvare@suse.de,
 f.fainelli@gmail.com, eajames@linux.vnet.ibm.com,
 shreesha.rajashekar@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 geert@linux-m68k.org, devicetree@vger.kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 jarkko.nikula@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

Just want to check if you had a chance to review the following patch series?

Thanks,

Ray

On 1/20/2019 1:49 PM, Ray Jui wrote:
> Hi Rayagonda/Wolfram,
> 
> I reviewed the entire patch series and added my Reviewed-by tag on 1/8
> and 2/8. The rest of the patches in this series already had my
> Signed-off-by tag.
> 
> Thanks,
> 
> Ray
> 
> On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
>> Hi,
>> This patchset contains support for IPROC I2C slave and NIC I2C support.
>> Following are the brief changes done inorder to support both IPROC I2C
>> slave mode and NIC I2C,
>>
>> a. Add support to allow I2C rx transfer upto 255 bytes
>> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>>    in certain SoCs where interrupt is not connected from the I2C block.
>> c. Add warpper read/write access for register to support indirect register
>>    access. This is required in certain SoCs with this iProc I2C
>>    block registered.
>> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>>    wait duration can be met.
>>
>> This patch series is based on kernel v5.0.0-rc2.
>>
>> Changes from v2:
>>  - Address Ray's review comments.
>>
>> Changes from v1:
>>  - Rebased to Linux v5.0.0-rc2
>>
>> Ray Jui (1):
>>   dt-bindings: i2c: iproc: make 'interrupts' optional
>>
>> Rayagonda Kokatanur (5):
>>   i2c: iproc: add polling support
>>   i2c: iproc: use wrapper for read/write access
>>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>>   i2c: iproc: add NIC I2C support
>>   arm64: dts: Stingray: Add NIC i2c device node
>>
>> Shreesha Rajashekar (2):
>>   i2c: iproc: I2C read up to 255 bytes support
>>   i2c: iproc: Add Slave mode support
>>
>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>>  drivers/i2c/busses/Kconfig                         |   1 +
>>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>>  4 files changed, 659 insertions(+), 131 deletions(-)
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
