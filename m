Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E0C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0132085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tEMqgZ+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0132085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jlkedsIEe0UtmfNJrvmZx5PixBFKH+ne/NNH5W9qEgk=; b=tEMqgZ+jY/z0Bt
	b1ha5SsqZvwTxFjcI+GOJ4Ex5e3rvG1vA2PoOzl375zQ6Y+rmfrDS/hlIklJBu66C/X01xoIUtcjY
	kCpnJsMVz9F+0cxC1S3EfAN8VbafXeyInca/BQanTDR59Lpxdc98/00NxHLqUN8vAkG2HDQ+oDC/Y
	ZohW5c7ELTV222i6h8EL5mFoEV+JYYdcZxA4tNLn7Tw/itAmSfj/N3Z9zKGjWdza8Kj+2fqcwa5RP
	A4L32qHGYPAlCRTDqLSxBA2zAzhQUkELFWNfW3zjvchr6qPc3vpVW0Gln668rCuWYdD9i26XVlCgL
	lmzQCSrcaVojFKVBqOSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbVP-0002ms-I9; Mon, 21 Jan 2019 15:28:55 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbVL-0002mI-IV
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:28:53 +0000
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so17880358ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8Ns3hO7au/4gP43Zy3r2VRePjfEOnTZweviuyxTwnI=;
 b=XM/slQO2jkwU7Me7sj4TeeRZr60FfRw/487nkqWE8p36vhCWqNU1jlaOvYZz9TCmzP
 zVD6in59j8Cjp5PTu49JX8PPjXYANOGPhQEpS0lRXjYadC5akDvvpJatGdK5RSzVuBUQ
 7AyIqLHFMufiVWB6fiSBMCJ9jG+5+B7Wr2cEoTYknUJUn1btBm/FIL69avuz0BnpNgaq
 GQpJEf4GzQwfjbHK4UvvGJaZ64A7lBXg7HUaAh6r9UvPITugraHCa1rWpS8V000oX7je
 8/UmXChGOtlZZ93OjRSawt62vq3wKeGwlpEBT/qGhjfKZsjHSNoj8n5PqyHCt27bqX9f
 INhA==
X-Gm-Message-State: AJcUukdLTzbBQSErs6mtIOhxhxYzHj5w0lkoMakEx+GwBdIZgAMFvhkh
 NlaYbuWhzYTuJaFuqvShqQU9ZV2vrty7/q1s+QHubA==
X-Google-Smtp-Source: ALg8bN4ZHZ7dKDFf5R7QhvSllevOcyIcT7jVeDhaCGxVvRQGrHa0d/6lqrQYLKOIgzmd4nqL74DTInAWEILGX4BuABs=
X-Received: by 2002:a2e:a0d5:: with SMTP id
 f21-v6mr8576758ljm.98.1548084529125; 
 Mon, 21 Jan 2019 07:28:49 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-2-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1548062959-31860-2-git-send-email-sumit.garg@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 21 Jan 2019 20:58:36 +0530
Message-ID: <CACi5LpMN2N1joWxmwDy=DtH+stenUs64oJ2_T4T-7sSoS=NAgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tee: add bus driver framework for TEE based devices
To: Sumit Garg <sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_072851_614549_FD82BFDF 
X-CRM114-Status: GOOD (  24.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sumit,

On Mon, Jan 21, 2019 at 3:00 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
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
>  drivers/tee/tee_core.c  | 45 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/tee_drv.h | 37 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 7b2bb4c..55370d5 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -15,7 +15,6 @@
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>
>  #include <linux/cdev.h>
> -#include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> @@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
>  }
>  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
>
> +static int tee_client_device_match(struct device *dev,
> +                                  struct device_driver *drv)
> +{
> +       const tee_client_device_id *id_table;
> +       struct tee_client_device *tee_device;
> +
> +       id_table = to_tee_client_driver(drv)->id_table;
> +       tee_device = to_tee_client_device(dev);
> +
> +       while (!uuid_is_null(id_table)) {
> +               if (uuid_equal(&tee_device->id, id_table))
> +                       return 1;
> +               id_table++;
> +       }
> +
> +       return 0;
> +}
> +
> +struct bus_type tee_bus_type = {
> +       .name           = "tee",
> +       .match          = tee_client_device_match,
> +};
> +EXPORT_SYMBOL_GPL(tee_bus_type);
> +
>  static int __init tee_init(void)
>  {
>         int rc;
> @@ -1040,18 +1063,32 @@ static int __init tee_init(void)
>         rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
>         if (rc) {
>                 pr_err("failed to allocate char dev region\n");
> -               class_destroy(tee_class);
> -               tee_class = NULL;
> +               goto out_unreg_class;
>         }
>
> +       rc = bus_register(&tee_bus_type);
> +       if (rc) {
> +               pr_err("failed to register tee bus\n");
> +               goto out_unreg_chrdev;
> +       }
> +
> +       return 0;
> +
> +out_unreg_chrdev:
> +       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> +out_unreg_class:
> +       class_destroy(tee_class);
> +       tee_class = NULL;
> +
>         return rc;
>  }
>
>  static void __exit tee_exit(void)
>  {
> +       bus_unregister(&tee_bus_type);
> +       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>         class_destroy(tee_class);
>         tee_class = NULL;
> -       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>  }
>
>  subsys_initcall(tee_init);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6cfe058..ba985d8 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -15,11 +15,13 @@
>  #ifndef __TEE_DRV_H
>  #define __TEE_DRV_H
>
> -#include <linux/types.h>
> +#include <linux/device.h>
>  #include <linux/idr.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/tee.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
>
>  /*
>   * The file describes the API provided by the generic TEE driver to the
> @@ -538,4 +540,37 @@ static inline bool tee_param_is_memref(struct tee_param *param)
>         }
>  }
>
> +extern struct bus_type tee_bus_type;
> +
> +/*
> + * For TEE based client devices we use the device uuid as the
> + * identifier.
> + */
> +typedef uuid_t tee_client_device_id;
> +
> +/**
> + * struct tee_client_device - tee based device
> + * @id:                        device identifier
> + * @dev:               device structure
> + */
> +struct tee_client_device {
> +       tee_client_device_id id;
> +       struct device dev;
> +};
> +
> +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> +
> +/**
> + * struct tee_client_driver - tee client driver
> + * @id_table:          device id table supported by this driver
> + * @driver:            driver structure
> + */
> +struct tee_client_driver {
> +       const tee_client_device_id *id_table;
> +       struct device_driver driver;
> +};
> +
> +#define to_tee_client_driver(d) \
> +               container_of(d, struct tee_client_driver, driver)
> +
>  #endif /*__TEE_DRV_H*/
> --
> 2.7.4
>

LGTM, if there are no further comments on this patch please free to add:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
