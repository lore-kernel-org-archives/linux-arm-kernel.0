Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03453C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B957C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oCtAS7If";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUkP7iMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B957C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oGseE8ClAsg4K7CiZZux/NDM6mqHQ3aSGawJaAKx9C0=; b=oCtAS7If9R8Yw5
	iMyv8q2pgEt1X8J0Q59a0+hY2SJAEYhQ44Co16INL+exvS0UFmcSGhW3EYFWT6kzb+5ILk/oLn7IJ
	iNdHruoS0/nNFJvGf+PloDfLW2j68g53/BS2awDANpisG8JxPgoe4iO291X1mgBMaYtOQ+KhmXtpu
	Wdd8dMcyA+sCXtfLasdd2miuZs/ik40WZ8F/3gb8UQO+HwGs04iClOOGzKwREaTfbOkpdCMwY+iYb
	hMG6P9zyWZwB6AJrrE4+pXlwbipdSIDwow+gcQx9YIjPEf3tqo7UQHs6SNWttq9aN3jBA/w7IFc2g
	TNlNTipWsta14AI4a6pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwC0-0002Pm-Ar; Tue, 22 Jan 2019 13:34:16 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwBu-0002Oz-ED
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:34:13 +0000
Received: by mail-ua1-x942.google.com with SMTP id d21so8042343uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EfdIwdbRK43b54fj1Noa2nq7BBPRmS7ID38/9dZ/ej4=;
 b=FUkP7iMW/ncP9QxPm4dgq077EOzpkKzOfWnQBowPhnBrEqdTXPoiLpfl0tqMsu5bRM
 aHDcFFejbqmZfz2hbI/G3BY4HjhhuDEppkf3CFMxOf+1K/cW217ni0+m71fXMtwmXc/Z
 VfMIHP8v8u3N+9+Qtg/NN0eYXub86epKYCtG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EfdIwdbRK43b54fj1Noa2nq7BBPRmS7ID38/9dZ/ej4=;
 b=Au6nV4s452NUt2WfLGk0xZGSwfMq4xHzj/kb7N8e/L4NDJeGOB56M384eT6Ce2OH0+
 cSomqUciAOhpDVVAQrRyo5Ld9T7n44z5s/pXK11yisaWdBNPyDfAzS/hFK+8/LF9ajnE
 LvNx4VMIAJMs/bQnT20FKrLtQPrBsgV3B/nRpMuRAHGNj7Wdr/HEPGg18l8d+/y0UC8c
 UAfxaJVrC0GNNyUFaQXRP63Oer3n/z3Jf/amewjMxb/wPo4jBEcSrxCgJN2exjFgdGgY
 bQ3FRxjWzzE6SJhIcVCjk3UF3oHwS5F9B8iUA5shxsS7MUgLHE9U5TRj1O0YHLNO/2Iu
 ktnw==
X-Gm-Message-State: AJcUukdKKHKd8IzJXAOvb3BPOT75wmd6Ct/PHvts+uVSghjg9XlKPNdi
 nxMuisq0+iBNLGUzhSh6G263pQfwR+TUQJWdK1KJ8g==
X-Google-Smtp-Source: ALg8bN4l8lnSDBnIygvscA7mC5eSoxhJVCjQV6W+yI7/heRBXhQV1fCZ+6BEgWVNY/Upa/uHx/mzjeq8JGTuGJSLHcM=
X-Received: by 2002:ab0:148e:: with SMTP id d14mr13161268uae.23.1548164047542; 
 Tue, 22 Jan 2019 05:34:07 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-2-git-send-email-sumit.garg@linaro.org>
 <CACi5LpMN2N1joWxmwDy=DtH+stenUs64oJ2_T4T-7sSoS=NAgw@mail.gmail.com>
In-Reply-To: <CACi5LpMN2N1joWxmwDy=DtH+stenUs64oJ2_T4T-7sSoS=NAgw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 22 Jan 2019 19:03:56 +0530
Message-ID: <CAFA6WYNDt2Mf3cwPrgfCpxYrCZ5Z1eMD9ieu0sfUCNeCSmu=RA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tee: add bus driver framework for TEE based devices
To: Bhupesh Sharma <bhsharma@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_053410_597291_1AA8ED77 
X-CRM114-Status: GOOD (  26.93  )
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

On Mon, 21 Jan 2019 at 20:58, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Sumit,
>
> On Mon, Jan 21, 2019 at 3:00 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
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
> >  drivers/tee/tee_core.c  | 45 +++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/tee_drv.h | 37 ++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 7b2bb4c..55370d5 100644
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
> > +                                  struct device_driver *drv)
> > +{
> > +       const tee_client_device_id *id_table;
> > +       struct tee_client_device *tee_device;
> > +
> > +       id_table = to_tee_client_driver(drv)->id_table;
> > +       tee_device = to_tee_client_device(dev);
> > +
> > +       while (!uuid_is_null(id_table)) {
> > +               if (uuid_equal(&tee_device->id, id_table))
> > +                       return 1;
> > +               id_table++;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +struct bus_type tee_bus_type = {
> > +       .name           = "tee",
> > +       .match          = tee_client_device_match,
> > +};
> > +EXPORT_SYMBOL_GPL(tee_bus_type);
> > +
> >  static int __init tee_init(void)
> >  {
> >         int rc;
> > @@ -1040,18 +1063,32 @@ static int __init tee_init(void)
> >         rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> >         if (rc) {
> >                 pr_err("failed to allocate char dev region\n");
> > -               class_destroy(tee_class);
> > -               tee_class = NULL;
> > +               goto out_unreg_class;
> >         }
> >
> > +       rc = bus_register(&tee_bus_type);
> > +       if (rc) {
> > +               pr_err("failed to register tee bus\n");
> > +               goto out_unreg_chrdev;
> > +       }
> > +
> > +       return 0;
> > +
> > +out_unreg_chrdev:
> > +       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > +out_unreg_class:
> > +       class_destroy(tee_class);
> > +       tee_class = NULL;
> > +
> >         return rc;
> >  }
> >
> >  static void __exit tee_exit(void)
> >  {
> > +       bus_unregister(&tee_bus_type);
> > +       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> >         class_destroy(tee_class);
> >         tee_class = NULL;
> > -       unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> >  }
> >
> >  subsys_initcall(tee_init);
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 6cfe058..ba985d8 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -15,11 +15,13 @@
> >  #ifndef __TEE_DRV_H
> >  #define __TEE_DRV_H
> >
> > -#include <linux/types.h>
> > +#include <linux/device.h>
> >  #include <linux/idr.h>
> >  #include <linux/kref.h>
> >  #include <linux/list.h>
> >  #include <linux/tee.h>
> > +#include <linux/types.h>
> > +#include <linux/uuid.h>
> >
> >  /*
> >   * The file describes the API provided by the generic TEE driver to the
> > @@ -538,4 +540,37 @@ static inline bool tee_param_is_memref(struct tee_param *param)
> >         }
> >  }
> >
> > +extern struct bus_type tee_bus_type;
> > +
> > +/*
> > + * For TEE based client devices we use the device uuid as the
> > + * identifier.
> > + */
> > +typedef uuid_t tee_client_device_id;
> > +
> > +/**
> > + * struct tee_client_device - tee based device
> > + * @id:                        device identifier
> > + * @dev:               device structure
> > + */
> > +struct tee_client_device {
> > +       tee_client_device_id id;
> > +       struct device dev;
> > +};
> > +
> > +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> > +
> > +/**
> > + * struct tee_client_driver - tee client driver
> > + * @id_table:          device id table supported by this driver
> > + * @driver:            driver structure
> > + */
> > +struct tee_client_driver {
> > +       const tee_client_device_id *id_table;
> > +       struct device_driver driver;
> > +};
> > +
> > +#define to_tee_client_driver(d) \
> > +               container_of(d, struct tee_client_driver, driver)
> > +
> >  #endif /*__TEE_DRV_H*/
> > --
> > 2.7.4
> >
>
> LGTM, if there are no further comments on this patch please free to add:
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
>

Thanks for this review tag. Actually I have to add support in module
device table for TEE bus devices as per Ard's comments on patch #4. So
that will require changes in this patch in next version.

-Sumit

> Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
