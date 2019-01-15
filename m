Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B204C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCA720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mHqfkDGW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M20DtUKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCA720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1jDsdzTflF6MKuIuPUHXn4e488MUJU0VgUZRmWP1biY=; b=mHqfkDGW9A3BVy
	577OXVfHEEdnJRWVOfZ4rr9YWRhXuR/EkHeg+GqxG/3WyVSKhvZjzatDlVg4spE2Q0ZJT4NP9uzkd
	aTe72TxXeoDZii9cNot+8tHN97vbLIPYOs1zWVDb859S+RX7uuCXmZTFtCQdQDptjQEtXohk9r9Ob
	IIIM/BtR3znj6+jYK85VlA4eF2UXRecX8tqCubkJz9lpO1lcTwdxOOcT0vpH/zKRduUC6VmSaBcb7
	qTGoqHT1mO0OiY++pgZ4CG/XH3E4sV36CRS3bDc4+no8CVVDQHLiRppJ3FnziDipsP9gHCUDNQWgH
	Q4UokMz/Kill4EFo6N0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNIJ-0005fG-4U; Tue, 15 Jan 2019 11:54:11 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNIA-0005da-7t
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:54:07 +0000
Received: by mail-ua1-x942.google.com with SMTP id t8so824355uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 03:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QGZ8jmwFtpmyKE1bae9s1cFmCnLiCPqF39zEMxqmUIk=;
 b=M20DtUKRFqZeeuuhf4mbmFrkhb3K5dyZ2KnkjvinKesWO2GLPsHjVnmb4CZ0Ihf7wi
 w3SsxUmZq22ehZllF7uAEZjXUeLyZoKi2x/s/5djqylxvayIp0BS5aW704B/C8s7FCC7
 7mVIgqLPamTWGaBnyq75aAtxXKPbzRA1WieKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QGZ8jmwFtpmyKE1bae9s1cFmCnLiCPqF39zEMxqmUIk=;
 b=mOcIcRuCv+5RnZWxhklxb9ke+oyo3po2MW5V2vlEa97GOjL/lTuNY6gBQ46b37UEKa
 NQ2MfYpXcrpHeALCHxudPT3W/itdVP584ofRCRGg1srUtWKnm9NYAQ4mF+SLqRjYRm6l
 2emquiWe4MYZBvk0yZG+/zaTefZTf8GbpmPltYi/L1U19w8RInlkCpL4teUFuXQV+SxY
 nuKrlCj0wXJbdg4+NTBRBvYOvrcpyqHFsNCGx4B7hBbd7gAvFp8YN/TybpXKpr1lrE6Q
 ovaHnIqSOlRoiOoEt9gaXg68WCa45Y3XclwdlsHkCF/k67pzlP8sOhRqadi5r8H2dUpu
 wy+w==
X-Gm-Message-State: AJcUukfaHuVj3QdTj9+HGORrcQtVS3Olpr+PU5n3LbpSQzTM+cY9AVw8
 8iaF1+LNPQmTbgekfgyB3jIVjpuJIDyYzhbba+lyZw==
X-Google-Smtp-Source: ALg8bN6dAB1cphC4ghhhPcCf5peHRxAozdhR4j/11tumXfCuPWXnblFrrqTDpRafqWZ68nAvx9oJClVx/O6ymWXXiHI=
X-Received: by 2002:a9f:314c:: with SMTP id n12mr1486974uab.33.1547553240372; 
 Tue, 15 Jan 2019 03:54:00 -0800 (PST)
MIME-Version: 1.0
References: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
 <1547207251-9372-2-git-send-email-sumit.garg@linaro.org>
 <6a01fee4-4331-be63-9a78-c4d646b43d29@redhat.com>
In-Reply-To: <6a01fee4-4331-be63-9a78-c4d646b43d29@redhat.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 15 Jan 2019 17:23:48 +0530
Message-ID: <CAFA6WYNmALRBZ=_61e__rMeVsRNJjUOB=E2Gc4RHzMF0OvqhcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tee: add bus driver framework for TEE based devices
To: Bhupesh Sharma <bhsharma@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_035402_427991_172EDD80 
X-CRM114-Status: GOOD (  28.36  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 11 Jan 2019 at 20:39, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Sumit,
>
> Thanks for the patch. Some nitpicks in-line:
>

Apologies for delay in my response as I was on leave. Please find my
comments inline.

Will include these nitpicks in v4 but let me wait for any further
major comments.

> On 01/11/2019 05:17 PM, Sumit Garg wrote:
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
> >   drivers/tee/tee_core.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
> >   include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 76 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..a685940 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -15,7 +15,6 @@
> >   #define pr_fmt(fmt) "%s: " fmt, __func__
> >
> >   #include <linux/cdev.h>
> > -#include <linux/device.h>
> >   #include <linux/fs.h>
> >   #include <linux/idr.h>
> >   #include <linux/module.h>
> > @@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
> >   }
> >   EXPORT_SYMBOL_GPL(tee_client_invoke_func);
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
> >   static int __init tee_init(void)
> >   {
> >       int rc;
> > @@ -1040,10 +1063,23 @@ static int __init tee_init(void)
> >       rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> >       if (rc) {
> >               pr_err("failed to allocate char dev region\n");
> > -             class_destroy(tee_class);
> > -             tee_class = NULL;
> > +             goto chrdev_err;
> >       }
> >
> > +     rc = bus_register(&tee_bus_type);
> > +     if (rc) {
> > +             pr_err("failed to register tee bus\n");
> > +             goto bus_err;
> > +     }
> > +
> > +     return 0;
> > +
> > +bus_err:
> > +     unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > +chrdev_err:
> > +     class_destroy(tee_class);
> > +     tee_class = NULL;
> > +
>
> Hmm.. these error paths/labels look out-of-order.
> See 'drivers/i2c/i2c-dev.c' for example.
>
> Normally our error paths in an __init function is of the same order as
> the __exit function implementation. So this should be changed to
> something like:
>
>    +out_unreg_class:
>    +    class_destroy(tee_class);
>    +    tee_class = NULL;
>    +out_unreg_chrdev:
>    +    unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>

It seems that prior to this patch also allocation order in __init
function differed from release order in __exit function. Will correct
that too along with this.

> >       return rc;
> >   }
> >
> > @@ -1052,6 +1088,7 @@ static void __exit tee_exit(void)
> >       class_destroy(tee_class);
> >       tee_class = NULL;
> >       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > +     bus_unregister(&tee_bus_type);
>
> Since the __exit function order is the reverse of the __init one, lets
> reorder this as:
>
>   +     bus_unregister(&tee_bus_type);
>         class_destroy(tee_class);
>         tee_class = NULL;
>         unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>

Ok.

> See 'drivers/i2c/i2c-dev.c' for example.
>
> >   }
> >
> >   subsys_initcall(tee_init);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..ed16bf1 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -20,6 +20,8 @@
> >   #include <linux/kref.h>
> >   #include <linux/list.h>
> >   #include <linux/tee.h>
> > +#include <linux/device.h>
> > +#include <linux/uuid.h>
>
> If possible, let's keep alphabetical order of header files when making
> changes in the patch.
>

Ok.

> >
> >   /*
> >    * The file describes the API provided by the generic TEE driver to the
> > @@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
> >       }
> >   }
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
>
> Hmm.. Do we really need a struct for a single element, rather lets use a
> simple typedef here.
>

Agree, will rather use typedef here.

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
>
> Add a blank line here.
>

Ok.

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
>
> Add a blank line here.

Ok.

-Sumit

> > +#define to_tee_client_driver(d) \
> > +             container_of(d, struct tee_client_driver, driver)
> > +
> >   #endif /*__TEE_DRV_H*/
> >
>
> Thanks,
> Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
