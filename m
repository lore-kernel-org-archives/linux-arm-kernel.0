Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76893C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4846C20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrRrLr2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4846C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F5ZNQWPt1iWn9EJ0Zg56SlFcG49AGN8zSg8RDeJZQhA=; b=DrRrLr2bSVHUIhT+z4TrGn8xt
	ygX/ut80CvjDipjV1JFIV/Ur3KZVNNM1vc5sFtgHF5FFjmTNAxbB67lf4LMoWYaxPN2qviy8qLVek
	izi4EwEnvVnBseacZWZy1aFq6cvj8H464nhBcu98+mkOab7npJEEaBwe8dJyTu6aESIrlXHEhrv1f
	IfzTvzrkbs31KNEXUVMmnPwJ34zzylcdsvmg6IYhphplEDxO8zAiqK10bjAGrZg3IQu/3wcnqZja7
	eA8TYvcdeG+swkIeN6rixsHrLMIAw6RtlDMQggzb6Y0pnOz2JIFsh31GAZFRBwqFYE3ks782L/NK1
	TYa690ZfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyR4-0001Km-L6; Fri, 11 Jan 2019 15:09:26 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyR0-0001K5-3d
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:09:24 +0000
Received: by mail-pf1-f196.google.com with SMTP id u6so7059410pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8irMVJEfKQIycZVTf0Xp4+zAYCLrYHIgirL9eSJTzi4=;
 b=bUMvhBn4WHMz4bOD50YxiOUrmVTEohPwaiByKncDyZ4axqwJQz6neY01k/SQEcMZGG
 l2oMgiFjvoPT4oH7teZLbXW6SA9n4idfuW4LneNHGrOx1B4snpraOThVG1w1CXczh5Bw
 ucpnH1eQNoKMgryxNMBGsLjyXw1hzm11SoybnFSupGbZwmOu5/Vxw1tEJzF/H0MYpgK/
 oGVsj8JtPNVSg85M5xQlpl6X6HwIFSsiSWwpOSOzjEVQ82ffZ9yK/01ExENb4VQNKmAQ
 anC8BSbPNKhkUVFsUFmebeEuJk/W2oYlsaQshCSHlx9RWsTxVgRe5bO2/X87MXn7R/87
 ObbQ==
X-Gm-Message-State: AJcUukeLc/rSw8Y2XwKP+JYwre3PN8P/9pTzQn76sJFnPTfXq2BwWVAp
 VXR2sStssZsR04YBJrm9twzzZQ==
X-Google-Smtp-Source: ALg8bN6pnHSPegfCGobvpBhF6VjcEqzjfwB3WaMNwg/+4tR5lffyaNJ8XW4NnAynNGdef49CV9Nbcg==
X-Received: by 2002:a63:9843:: with SMTP id l3mr13595672pgo.413.1547219361186; 
 Fri, 11 Jan 2019 07:09:21 -0800 (PST)
Received: from [192.168.1.6] ([122.177.131.230])
 by smtp.gmail.com with ESMTPSA id g190sm96388206pgc.28.2019.01.11.07.09.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 07:09:19 -0800 (PST)
Subject: Re: [PATCH v3 1/4] tee: add bus driver framework for TEE based devices
To: Sumit Garg <sumit.garg@linaro.org>, linux-arm-kernel@lists.infradead.org, 
 linux-crypto@vger.kernel.org
References: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
 <1547207251-9372-2-git-send-email-sumit.garg@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <6a01fee4-4331-be63-9a78-c4d646b43d29@redhat.com>
Date: Fri, 11 Jan 2019 20:39:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1547207251-9372-2-git-send-email-sumit.garg@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070922_176873_0415782F 
X-CRM114-Status: GOOD (  28.47  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 herbert@gondor.apana.org.au, arnd@arndb.de, ard.biesheuvel@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, robh+dt@kernel.org, mpm@selenic.com,
 jens.wiklander@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sumit,

Thanks for the patch. Some nitpicks in-line:

On 01/11/2019 05:17 PM, Sumit Garg wrote:
> Introduce a generic TEE bus driver concept for TEE based kernel drivers
> which would like to communicate with TEE based devices/services.
> 
> In this TEE bus concept, devices/services are identified via Universally
> Unique Identifier (UUID) and drivers register a table of device UUIDs
> which they can support.
> 
> So this TEE bus framework registers a match() callback function which
> iterates over the driver UUID table to find a corresponding match for
> device UUID. If a match is found, then this particular device is probed
> via corresponding probe api registered by the driver. This process
> happens whenever a device or a driver is registered with TEE bus.
> 
> Also this framework allows for device enumeration to be specific to
> corresponding TEE implementation like OP-TEE etc.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/tee/tee_core.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
>   include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..a685940 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -15,7 +15,6 @@
>   #define pr_fmt(fmt) "%s: " fmt, __func__
>   
>   #include <linux/cdev.h>
> -#include <linux/device.h>
>   #include <linux/fs.h>
>   #include <linux/idr.h>
>   #include <linux/module.h>
> @@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
>   }
>   EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>   
> +static int tee_client_device_match(struct device *dev,
> +				   struct device_driver *drv)
> +{
> +	struct tee_client_device *tee_device;
> +	const struct tee_client_device_id *id_table;
> +
> +	tee_device = to_tee_client_device(dev);
> +	id_table = to_tee_client_driver(drv)->id_table;
> +
> +	while (!uuid_is_null(&id_table->uuid)) {
> +		if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
> +			return 1;
> +		id_table++;
> +	}
> +
> +	return 0;
> +}
> +
> +struct bus_type tee_bus_type = {
> +	.name		= "tee",
> +	.match		= tee_client_device_match,
> +};
> +EXPORT_SYMBOL_GPL(tee_bus_type);
> +
>   static int __init tee_init(void)
>   {
>   	int rc;
> @@ -1040,10 +1063,23 @@ static int __init tee_init(void)
>   	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
>   	if (rc) {
>   		pr_err("failed to allocate char dev region\n");
> -		class_destroy(tee_class);
> -		tee_class = NULL;
> +		goto chrdev_err;
>   	}
>   
> +	rc = bus_register(&tee_bus_type);
> +	if (rc) {
> +		pr_err("failed to register tee bus\n");
> +		goto bus_err;
> +	}
> +
> +	return 0;
> +
> +bus_err:
> +	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> +chrdev_err:
> +	class_destroy(tee_class);
> +	tee_class = NULL;
> +

Hmm.. these error paths/labels look out-of-order.
See 'drivers/i2c/i2c-dev.c' for example.

Normally our error paths in an __init function is of the same order as 
the __exit function implementation. So this should be changed to 
something like:

   +out_unreg_class:
   +	class_destroy(tee_class);
   +	tee_class = NULL;
   +out_unreg_chrdev:
   +	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);

>   	return rc;
>   }
>   
> @@ -1052,6 +1088,7 @@ static void __exit tee_exit(void)
>   	class_destroy(tee_class);
>   	tee_class = NULL;
>   	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> +	bus_unregister(&tee_bus_type);

Since the __exit function order is the reverse of the __init one, lets 
reorder this as:

  +	bus_unregister(&tee_bus_type);
   	class_destroy(tee_class);
    	tee_class = NULL;
    	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);

See 'drivers/i2c/i2c-dev.c' for example.

>   }
>   
>   subsys_initcall(tee_init);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..ed16bf1 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -20,6 +20,8 @@
>   #include <linux/kref.h>
>   #include <linux/list.h>
>   #include <linux/tee.h>
> +#include <linux/device.h>
> +#include <linux/uuid.h>

If possible, let's keep alphabetical order of header files when making 
changes in the patch.

>   
>   /*
>    * The file describes the API provided by the generic TEE driver to the
> @@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
>   	}
>   }
>   
> +extern struct bus_type tee_bus_type;
> +
> +/**
> + * struct tee_client_device_id - tee based device identifier
> + * @uuid:		For TEE based client devices we use the device uuid
> + *			as the identifier.
> + */
> +struct tee_client_device_id {
> +	uuid_t uuid;
> +};

Hmm.. Do we really need a struct for a single element, rather lets use a 
simple typedef here.

> +
> +/**
> + * struct tee_client_device - tee based device
> + * @id:			device identifier
> + * @dev:		device structure
> + */
> +struct tee_client_device {
> +	struct tee_client_device_id id;
> +	struct device dev;
> +};

Add a blank line here.

> +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> +
> +/**
> + * struct tee_client_driver - tee client driver
> + * @id_table:		device id table supported by this driver
> + * @driver:		driver structure
> + */
> +struct tee_client_driver {
> +	const struct tee_client_device_id *id_table;
> +	struct device_driver driver;
> +};

Add a blank line here.
> +#define to_tee_client_driver(d) \
> +		container_of(d, struct tee_client_driver, driver)
> +
>   #endif /*__TEE_DRV_H*/
> 

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
