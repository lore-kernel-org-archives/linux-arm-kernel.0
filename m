Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D836C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8AE20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LjNeiv3Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdY+Afhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8AE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+QiC2qFkfdUbv1nsEOd+w6hG939thDHzXf193Z1KJro=; b=LjNeiv3QcRRSrtpHjXfan0utz
	OWs02BHmLoOU2HNdPNFhBCg4gR+UTTTr6CRZ2nyZ6fgo/HsJgNGcoyG9mpwintdHqD/zvESD2h82e
	BHXzPilupShnMCnYodJlFUtL9Nkddm70bS/8N8JgYYEnRZCzO7BBExS9a+X8zdU3fSASJkIhGcQIF
	ZbBswG5jUyw1EzpWMUAc5qfePldBV3c/R40nUK+lNV+90ZqVWLu6CGqxrko9SdgPkh95lYvlfrSdc
	louSrJIHuxGtLbol3s9njFN4RfTiODZLg9vgJSnbHmikLt5OQO+2PasPAxRpVgMiIKBH12TjFNuRS
	Dms3yTseA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqDU5-0003jQ-Dz; Sun, 03 Feb 2019 08:50:37 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqDU2-0003j5-5K
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 08:50:35 +0000
Received: by mail-wm1-x342.google.com with SMTP id b11so10144814wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/LcsvIxDxzsXKqiH34uS/jv8MOJ9Bgucz7iwKhZHocE=;
 b=jdY+AfhjeUl7Q3UEJhN6nfsnOtudXSpAACoyeOpWd7wwK5nBAiO4XpOqzZ5B56D5zD
 kK7mZV/LzJS6ycwrJOl9YGs2F133gQ80kMAmFV9tYwlAt1PG+l4riT1BrwbxVYhLMaBA
 io31pd/3S/JcmpCvXyE+wGkVZKhop6S5x9VsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/LcsvIxDxzsXKqiH34uS/jv8MOJ9Bgucz7iwKhZHocE=;
 b=h7DtbpLqpLwIit1eqwCrgqLW8PAMAYuJMGkMosMcWbPYyWA2DAq1SSkxVrV4mGgXOi
 R6z5mZauyzE4FfbzWmAJ+rzoSUHueVmemQPgMIOuiQ0yhOxNmg2C26g9wit/KNfrpjUd
 jEga0F9h00jZ+76lHVTFn3tdCZyOrDu83cRVYN7CSJPnTtpat5nujv7PuBiS5LrC+B5J
 GpFUtH2nFW4ascB6W9uzu08s+wjgr48wLl6UyPAgKtp65r03z02n60im3neNxKl6v5lL
 E/VMF6IbUV8UP8ECLTmrKiCOqQqXnY1XWS48Hnfxc2ln3Q90ZSIoJkwRf+3KyaDxzLuf
 pCrQ==
X-Gm-Message-State: AHQUAuY1t2bQs+Rmg3SMe1Iuiu/jk4ETJKFv+pDgZYViHMay3KzM1bJ1
 kVQBWKDLNcvzIJSl/dIIeXN6gw==
X-Google-Smtp-Source: AHgI3IaVKNr5Q5mqz9aghUMVTFSDxGa/EdhXg7EXBs088dJndMY92ED1M7PceCp+MWMN/1Rk6DwndQ==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr9445188wmk.44.1549183832087;
 Sun, 03 Feb 2019 00:50:32 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id j33sm28736604wre.91.2019.02.03.00.50.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 00:50:31 -0800 (PST)
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To: Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
 rajanv@xilinx.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
Date: Sun, 3 Feb 2019 08:50:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204070951.6933-2-nava.manne@xilinx.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_005034_213099_B3535204 
X-CRM114-Status: GOOD (  21.85  )
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

Hi Kishore,

I need ack for this patch from Michal Simek to take this via nvmem tree.

thanks,
srini

On 04/02/2019 07:09, Nava kishore Manne wrote:
> This patch adds a new API to provide access to the
> hardware related data like soc revision, IDCODE... etc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
> Changes for v1:
>                  -None.
> 
> Changes for RFC-V3:
>                  -corrected typo error in commit msg.
> 
> Changes for RFC-v2:
>                  -New Patch.
> 
>   drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h |  2 ++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 9a1c72a9280f..af2a209fc2da 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -186,6 +186,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
>   	return ret;
>   }
>   
> +/**
> + * zynqmp_pm_get_chipid - Get silicon ID registers
> + * @idcode:     IDCODE register
> + * @version:    version register
> + *
> + * Return:      Returns the status of the operation and the idcode and version
> + *              registers in @idcode and @version.
> + */
> +static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];
> +
> +	return ret;
> +}
> +
>   /**
>    * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
>    * @version:	Returned version value
> @@ -471,6 +494,7 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
>   
>   static const struct zynqmp_eemi_ops eemi_ops = {
>   	.get_api_version = zynqmp_pm_get_api_version,
> +	.get_chipid = zynqmp_pm_get_chipid,
>   	.query_data = zynqmp_pm_query_data,
>   	.clock_enable = zynqmp_pm_clock_enable,
>   	.clock_disable = zynqmp_pm_clock_disable,
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 3c3c28eff56a..c435f4b35adf 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,7 @@
>   
>   enum pm_api_id {
>   	PM_GET_API_VERSION = 1,
> +	PM_GET_CHIPID = 22,
>   	PM_IOCTL = 34,
>   	PM_QUERY_DATA,
>   	PM_CLOCK_ENABLE,
> @@ -91,6 +92,7 @@ struct zynqmp_pm_query_data {
>   
>   struct zynqmp_eemi_ops {
>   	int (*get_api_version)(u32 *version);
> +	int (*get_chipid)(u32 *idcode, u32 *version);
>   	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
>   	int (*clock_enable)(u32 clock_id);
>   	int (*clock_disable)(u32 clock_id);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
