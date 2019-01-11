Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C663C20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9WGoxNP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODILqu5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C663C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TYArFniwhz15efBTgG8cLEa6lUiLfUxmgAl7Z9R/Hos=; b=o9WGoxNPBbWFfd
	iDiE0xa/Z2hB/FddPUh+VR+SUSa4lUqgW0lr5Cz/58BnFsg0JIm32GBt4JW1QzlmLpjLaYuP73qb4
	6wa+FsYS76pK1fhLeMH6tmwI9XPstABQORhdU4Wo9IQuivU/B3gh12YFapnjqVa4Ohr/SMB4kYjxv
	acrTfdPd/rnnecfj3bJ1dTfFgV2OW6f3wOCAxnsE2wGO8mCZvGVf08JZAtevQPyuWSJaPMnKax9Sm
	yYCcZmlNJjDIDR+vD3Ixmp52+b0OrSuiMTE2BhyYSn2IG6fYjgbIcmue8zsmKTqf34LKNwP7YYC4P
	rtI83/NioP0qZgDJw8fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghqVg-0007vE-31; Fri, 11 Jan 2019 06:41:40 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghqVc-0007um-In
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 06:41:38 +0000
Received: by mail-ua1-x943.google.com with SMTP id z24so4429075ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=insVKXAI2BdmwV+tijyrOG00REZx8cOa7WU0NuC4TI0=;
 b=ODILqu5dnmrqfImCcEVSmEtsCNihVzIzkrzUqk41vZxeCVWAZ55T/ppOs+RqYZbYQh
 BIZDM7eR2FkTRi7gQ77VBnE8GjxiMxU0yw5X1nFm1td28eNUbceS5vhFSzrpSI67vEhW
 MTURbW8vQnB0fRBMK92N1QTvXiCyvjPYgw6MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=insVKXAI2BdmwV+tijyrOG00REZx8cOa7WU0NuC4TI0=;
 b=fyPoVyROVf48Vyyt517r8kRp5mG/SybauzoMRMnCWDDwL+3nJjxPimSrhQ/Hwg5a5i
 BRwZQc6zdY8xC5moshyTyZxswc6GKVZB+x/pWTEce7sEav01Iov1Br0J/6ywYeSr10yF
 18c4/uOPenxgHdG7+Dcp3r4e2sF7bn7hWsOP1RlFnIgZ/WmAGPyKkWCIR0MWF+PDClyz
 fAkqmm7Nc7Iq5uixMGqpLXGbgmyp+VhOH8MOFPXAOsbDpGA6N8q6Girr6SjzEqQX28r0
 waewqgQAah5o3A9LNg3k0Gp700gmTEoskEDT2Wg/b3vKNdKtJwc40oyZiVDUcC49VQoz
 D2yw==
X-Gm-Message-State: AJcUukd625tjNleLS3jxTTbB0DUuUzgIoTG0dEBF3xFblUIcD9V5P0TE
 EjTVpve2wURLfWRA110PzRXZeO5s2Mm+8AlJIOAcRw==
X-Google-Smtp-Source: ALg8bN5o5TAmUmPaCmJgalCoDhfb2Fpe0YR7o9GrMl9Ufbuj1Ui8DXNfXYOBRu6I0EOLWPbDajSAxdap3NK12an+Z2Y=
X-Received: by 2002:a9f:314c:: with SMTP id n12mr5247700uab.33.1547188893591; 
 Thu, 10 Jan 2019 22:41:33 -0800 (PST)
MIME-Version: 1.0
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-2-git-send-email-sumit.garg@linaro.org>
 <20190110140630.js7mrhu6nfnjsfhx@holly.lan>
In-Reply-To: <20190110140630.js7mrhu6nfnjsfhx@holly.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 11 Jan 2019 12:11:22 +0530
Message-ID: <CAFA6WYNu-wm+V3qc85wodbMYoorMNMKMhG9dde7xqcPH5XVyUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tee: add bus driver framework for TEE based devices
To: Daniel Thompson <daniel.thompson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_224136_632433_EBBE4FE0 
X-CRM114-Status: GOOD (  25.66  )
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
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 19:36, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jan 10, 2019 at 05:54:54PM +0530, Sumit Garg wrote:
> > Introduce a generic TEE bus driver concept for TEE based kernel drivers
> > which would like to communicate with TEE based devices/services.
> >
> > In this TEE bus concept, devices/services are identified via Universally
> > Unique Identifier (UUID) and drivers register a table of device UUIDs
> > which they can support.
> >
> > So this TEE bus framework registers a match() callback function which
> > iterates over the driver UUID table to find a corresponding match for
> > device UUID. If a match is found, then this particular device is probed
> > via corresponding probe api registered by the driver. This process
> > happens whenever a device or a driver is registered with TEE bus.
> >
> > Also this framework allows for device enumeration to be specific to
> > corresponding TEE implementation like OP-TEE etc.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  | 41 ++++++++++++++++++++++++++++++++++++++---
> >  include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..9ddb89e 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -15,7 +15,6 @@
> >  #define pr_fmt(fmt) "%s: " fmt, __func__
> >
> >  #include <linux/cdev.h>
> > -#include <linux/device.h>
> >  #include <linux/fs.h>
> >  #include <linux/idr.h>
> >  #include <linux/module.h>
> > @@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> >
> > +static int tee_client_device_match(struct device *dev,
> > +                                struct device_driver *drv)
> > +{
> > +     struct tee_client_device *tee_device;
> > +     const struct tee_client_device_id *id_table;
> > +
> > +     tee_device = to_tee_client_device(dev);
> > +     id_table = to_tee_client_driver(drv)->id_table;
> > +
> > +     while (!uuid_is_null(&id_table->uuid)) {
> > +             if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
> > +                     return 1;
> > +             id_table++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +struct bus_type tee_bus_type = {
> > +     .name           = "tee",
> > +     .match          = tee_client_device_match,
> > +};
> > +EXPORT_SYMBOL_GPL(tee_bus_type);
> > +
> >  static int __init tee_init(void)
> >  {
> >       int rc;
> > @@ -1040,10 +1063,21 @@ static int __init tee_init(void)
> >       rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> >       if (rc) {
> >               pr_err("failed to allocate char dev region\n");
> > -             class_destroy(tee_class);
> > -             tee_class = NULL;
> > +             goto class_err;
> >       }
> >
> > +     rc = bus_register(&tee_bus_type);
> > +     if (rc) {
> > +             pr_err("failed to register tee bus\n");
> > +             goto class_err;
>
> There is an unregister_chrdev_region() in tee_exit(). Why isn't it
> needed on this error path?
>

Will add "unregister_chrdev_region()" on this error path.

-Sumit

>
> > +     }
> > +
> > +     return 0;
> > +
> > +class_err:
> > +     class_destroy(tee_class);
> > +     tee_class = NULL;
> > +
> >       return rc;
> >  }
> >
> > @@ -1052,6 +1086,7 @@ static void __exit tee_exit(void)
> >       class_destroy(tee_class);
> >       tee_class = NULL;
> >       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > +     bus_unregister(&tee_bus_type);
> >  }
> >
> >  subsys_initcall(tee_init);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..ed16bf1 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -20,6 +20,8 @@
> >  #include <linux/kref.h>
> >  #include <linux/list.h>
> >  #include <linux/tee.h>
> > +#include <linux/device.h>
> > +#include <linux/uuid.h>
> >
> >  /*
> >   * The file describes the API provided by the generic TEE driver to the
> > @@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
> >       }
> >  }
> >
> > +extern struct bus_type tee_bus_type;
> > +
> > +/**
> > + * struct tee_client_device_id - tee based device identifier
> > + * @uuid:            For TEE based client devices we use the device uuid
> > + *                   as the identifier.
> > + */
> > +struct tee_client_device_id {
> > +     uuid_t uuid;
> > +};
> > +
> > +/**
> > + * struct tee_client_device - tee based device
> > + * @id:                      device identifier
> > + * @dev:             device structure
> > + */
> > +struct tee_client_device {
> > +     struct tee_client_device_id id;
> > +     struct device dev;
> > +};
> > +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> > +
> > +/**
> > + * struct tee_client_driver - tee client driver
> > + * @id_table:                device id table supported by this driver
> > + * @driver:          driver structure
> > + */
> > +struct tee_client_driver {
> > +     const struct tee_client_device_id *id_table;
> > +     struct device_driver driver;
> > +};
> > +#define to_tee_client_driver(d) \
> > +             container_of(d, struct tee_client_driver, driver)
> > +
> >  #endif /*__TEE_DRV_H*/
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
