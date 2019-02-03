Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6436CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C6620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAI0ybof";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvJYsg1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C6620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3g3vwT1EWGbmRJuePCGnrPpqmOl/YQ9IflCegcPb+yg=; b=TAI0ybofqK4lco4R8qee4Njq0
	baDzbyUvzXVCR2N/TRzG909vn3Xgzx41enMX8pCo42N/oh2mB4ynUKtAXB6XwD3TEAoGxxP3IM8D4
	MLE136TvwfswnEkZch5ZmwGZYPHrm/+C3h5EvHQJ4BALpeKPda6S7+OCgntY7HSBBzI/uBHDFYMKm
	/tktbKJB6ZO3c4Vxe7Kv/RLA7uq7ckdue9Qy+kbBEboAJ8v0pRMhDIZc88BhHBxRdrZkTRePoKPhi
	QlcYe7jJOhvQm6Wk6JwVgScZdbSRMhQvHZyu7AlJX/r2MH69AmZji1VzrNRTz7zNG/d4w9kN35EM5
	lCyWi/QnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqEEE-0002QK-2E; Sun, 03 Feb 2019 09:38:18 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqEEB-0002Pn-4K
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 09:38:16 +0000
Received: by mail-wm1-x342.google.com with SMTP id y8so10285036wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=j7kabuj/R/Wl+FA3xMNZwAPZLScIbShlL+vREBiYUc8=;
 b=AvJYsg1gyfGQ6sMDOiYM7qNNMz3foVwr6+25h7H4o9nx1EzSFRijiOTY8MzaozY3K/
 kxMFqkkshGVRA04cUpxSgK5rGpElu12bpGhmCUqh8qqeebtNwY8QoOdObKy4hyRiEJH+
 prmrT7P5TYnQt/g/+EwQxtzgNR2VugYzAO6CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j7kabuj/R/Wl+FA3xMNZwAPZLScIbShlL+vREBiYUc8=;
 b=RXOedoG9stm9Zf5Hj++DJf9IUDwIm/Aj44kBU6JhjCKXEpA4bGn4MSVoUsfXA6mud+
 HxGVUCxeLOXVA8NLMgABe74VIvZy8uiDr3qE/uZF4B6jYB8ZJP975ieAs+/DqTWm+WVi
 5pstzj6z58cwtW+1qyUxKDbAYYnFKKXNoZZ1h0QwrPI6cb8amdOpd/G7F4iCGomW0xms
 UYBUvSLGaHDeL6kYB0bdarWi9y6pmxk4xdKgldEZamuIN1tU4OlZz58ToJQEXgPrlHmr
 SNpQYwaHRhb4JLZVwfd1Tr7FGGO03pUdjvkkPbQ+GxG3iDhXCtPxaJg/kn+qlf8O8dMx
 ESPg==
X-Gm-Message-State: AHQUAuaHeENJ34Uexe0Q5htRabHB9l+forTT5liYnkOoYY6br0/dd6Mw
 qrAnHJNO7G0wYObMTk/OHIxF8A==
X-Google-Smtp-Source: AHgI3IZzlWSxHbRKnuYfLoF6iLPhaZKVssKrN5nmB0L0dSIkNbOek3ctRXhtTWJZjGq+Vv8aDZPUlw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr9384528wmf.38.1549186693309; 
 Sun, 03 Feb 2019 01:38:13 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id y20sm1368299wra.51.2019.02.03.01.38.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 01:38:12 -0800 (PST)
Subject: Re: [PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
To: Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
 rajanv@xilinx.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-4-nava.manne@xilinx.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <67e2af69-10bc-655c-e730-4c02a6375381@linaro.org>
Date: Sun, 3 Feb 2019 09:38:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204070951.6933-4-nava.manne@xilinx.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_013815_171025_CFDD270A 
X-CRM114-Status: GOOD (  15.75  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 04/02/2019 07:09, Nava kishore Manne wrote:
>   
> -config SC27XX_EFUSE
> -	tristate "Spreadtrum SC27XX eFuse Support"
> -	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> -	depends on HAS_IOMEM

Why are you removing SC27XX_EFUSE support here?

It does not look right!

> +config NVMEM_ZYNQMP
> +	bool "Xilinx ZYNQMP SoC nvmem firmware support"
> +	depends on ARCH_ZYNQMP
>   	help
> -	  This is a simple driver to dump specified values of Spreadtrum
> -	  SC27XX PMICs from eFuse.
> +	  This is a driver to access hardware related data like
> +	  soc revision, IDCODE... etc by using the firmware
> +	  interface.
>   
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem-sc27xx-efuse.
> +	  If sure, say yes. If unsure, say no.
>   
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 4e8c61628f1a..0b3abd7f5d02 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -39,5 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
>   nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
>   obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>   nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
> -obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
> -nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o

same here?

> +obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
> +nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
> +

--srini

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
