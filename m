Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:45:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9EB20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jGke/E4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9EB20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BnBMT6TPZTCLINzIJE1IyqQgCi6+Q/XaTKvHwSyn7sE=; b=jGke/E4XTethmEFtM33tjKCKI
	FpKvZMKiFMMJpO7ry6oEsikuHkWnVVDHhRoAJ/bqyUrHGySS0wRG3ZV5BU3VXB9zqEExQmVBDKfZk
	tet4nMc06bRJRLp0uQ/p/jiw6FYUlsih+mLn8eCN0IuIY45dxHooeT7pGY8E7McgN99taIhZ+/0RG
	MQSHbHxsEV3Xakp5qAo9+3LED/4p06efD7FN6HGjOgc5pLzlMplUS9RG7Wlg7DtJI69L7PLCZBwTJ
	/MNhgD0amK4Xpw0mzwx1wmgz3b9tVtQFLn4jm9Ge8eB1Cc7dufIF/xXGMKimGT9CYo1utkWAEDGmJ
	V0O9KMKCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvFG-00076y-Ua; Fri, 11 Jan 2019 11:45:02 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvFD-00074l-F6
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:45:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83CAF80D;
 Fri, 11 Jan 2019 03:44:58 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7499F3F70D;
 Fri, 11 Jan 2019 03:44:57 -0800 (PST)
Subject: Re: [RESEND PATCH v3 2/2] coresight: etmv4: Update ID register table
 to add UCI support
To: mike.leach@linaro.org, linux@armlinux.org.uk
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-3-mike.leach@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <05f725dd-24be-65e4-8b5d-a9acc9167ae9@arm.com>
Date: Fri, 11 Jan 2019 11:44:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218215944.2444-3-mike.leach@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_034459_511064_2E7B8505 
X-CRM114-Status: GOOD (  18.73  )
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
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/12/2018 21:59, Mike Leach wrote:
> Updates the ID register tables to contain a UCI entry for the A35 ETM
> device to allow correct matching of driver in the amba bus code.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..2fb8054e43ab 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>   		.mask	= 0x000fffff,		\
>   	}
>   
> +static struct amba_cs_uci_id uci_id_etm4[] = {
> +	{
> +		/*  ETMv4 UCI data */
> +		.devarch	= 0x47704a13,
> +		.devarch_mask	= 0xfff0ffff,
> +		.devtype	= 0x00000013,
> +	}
> +};
> +
> +#define ETM4x_AMBA_UCI_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= uci_id_etm4,		\
> +	}
> +
>   static const struct amba_id etm4_ids[] = {
>   	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
>   	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
>   	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
>   	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
> -	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
> +	ETM4x_AMBA_UCI_ID(0x000bb9da),		/* Cortex-A35 */
>   	{},
>   };
>   
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
