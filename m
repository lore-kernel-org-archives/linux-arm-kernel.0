Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501DC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2844218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QPcYwss+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2844218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d4mYQW3SJAWo69oEpKS57Ke3D3/HiRPEiqQGz787jCY=; b=QPcYwss+Qs5L1h
	307ayq0KONVWGTOYXSwEIM2QPDucU7B0Dtvw+6lejChETi1mkmFDxZSbhTSbuMHbVnTRZ5covajaO
	F06TMEfDewLxiu+tJVzAuYuSbaC3ZHdxzbFTIViM1ppf5cZ6aD/8gqLw/gWWwXqZEYTxNSHyObj1O
	Wk7wZlUlX/keC4N80SnKpTlVbNH6cZesFyyxocchBaJlKNeKz76rPYCfUGU26GRPlGp8ml6enOwC7
	C/Kx0u5Z0cfCNp5lBRfdoMppDk+2L7iOBYCvcSaXVWftWAuqX1oBCmDEzs2LmOo7en0broLc4xL+Q
	TrOlivkuBT54XHN54mqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcaO-00042V-Mg; Thu, 24 Jan 2019 10:50:16 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcaK-000421-Fy
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:50:15 +0000
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so4771923ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A6i9MJon2zlWGrqG4PpGG/6NCocHuT+rewQAUHlC5F0=;
 b=CZ1WWW3QNdioKU7hR43hEm1pop0MNpj2Qo8UylRr/AwMe592vT1Ec0kJZyu4VUAOZU
 3zpNbhxBL2cvFwhdvLPEeBEj2osMqVgdyKQivV7DxmyEuvLb+VVYnYkJqclrh9RsI61q
 uTIOVjQFn8LCBaLcx0nS/j4kzbejeETIZXHEDbwGqyY33aTmJPmfGC/zOLbNGLd9Wbhb
 61rRifFEIpkZ1+mRH49ieA9MNw0pXOOz4wciwDXLzRNyddXMiq+4rYJRE5lx8I4ZL42c
 qMoJFBTNVEMB1Oo5m0asBSIrsxPIhzH2FLHvmp3ZIiT3Gl5zp0DLOGGEPrMeP90pn3Il
 baVA==
X-Gm-Message-State: AJcUukcEdvVAVeqatW6Psdg5eYwh05G730ea17yUemjg9r4/OuS7ntiO
 BxUwFR4ehfBj9537+GvhWBaIfLvgjO0NlsXGBPhSzA==
X-Google-Smtp-Source: ALg8bN4msxGcG05hflDX7g1Q0wX80+Ig6JkYItJpZ94Z9oUvXa7Qgw1XcP5rd61yXqTfpcLhbpylaoStO1McMRurjJw=
X-Received: by 2002:a2e:3012:: with SMTP id
 w18-v6mr4993758ljw.75.1548327009167; 
 Thu, 24 Jan 2019 02:50:09 -0800 (PST)
MIME-Version: 1.0
References: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
 <1548309279-5281-2-git-send-email-sumit.garg@linaro.org>
 <20190124094518.qig25h4vzuya6yhz@holly.lan>
 <CAFA6WYOF6a_cmOQyHuRa3VPsGVF0Yi80qXXCMpfcsO6=5BmbHQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOF6a_cmOQyHuRa3VPsGVF0Yi80qXXCMpfcsO6=5BmbHQ@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 24 Jan 2019 16:19:56 +0530
Message-ID: <CACi5LpNrgNkGB2NAC_Pai9MH5_LZH1W+ihvhLTM8G-PSYkGBKw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] tee: add bus driver framework for TEE based devices
To: Sumit Garg <sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_025012_535053_E531E01D 
X-CRM114-Status: GOOD (  32.40  )
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
 Daniel Thompson <daniel.thompson@linaro.org>, michal.lkml@markovi.net,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, yamada.masahiro@socionext.com,
 Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 3:49 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 15:15, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Jan 24, 2019 at 11:24:36AM +0530, Sumit Garg wrote:
> > > Introduce a generic TEE bus driver concept for TEE based kernel drivers
> > > which would like to communicate with TEE based devices/services. Also
> > > add support in module device table for these new TEE based devices.
> > >
> > > In this TEE bus concept, devices/services are identified via Universally
> > > Unique Identifier (UUID) and drivers register a table of device UUIDs
> > > which they can support.
> > >
> > > So this TEE bus framework registers following apis:
> > > - match(): Iterates over the driver UUID table to find a corresponding
> > >   match for device UUID. If a match is found, then this particular device
> > >   is probed via corresponding probe api registered by the driver. This
> > >   process happens whenever a device or a driver is registered with TEE
> > >   bus.
> > > - uevent(): Notifies user-space (udev) whenever a new device is registered
> > >   on this bus for auto-loading of out-of-tree drivers.
> >
> > out-of-tree? Surely it can be used to auto-load any modulized driver.
> >
>
> Agree, will correct.
>
> >
> > > Also this framework allows for device enumeration to be specific to
> > > corresponding TEE implementation like OP-TEE etc.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/tee_core.c            | 57 ++++++++++++++++++++++++++++++++++++---
> > >  include/linux/mod_devicetable.h   |  9 +++++++
> > >  include/linux/tee_drv.h           | 32 +++++++++++++++++++++-
> > >  scripts/mod/devicetable-offsets.c |  3 +++
> > >  scripts/mod/file2alias.c          | 19 +++++++++++++
> > >  5 files changed, 115 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > index 7b2bb4c..9f4c8bc 100644
> > > --- a/drivers/tee/tee_core.c
> > > +++ b/drivers/tee/tee_core.c
> > > @@ -15,7 +15,6 @@
> > >  #define pr_fmt(fmt) "%s: " fmt, __func__
> > >
> > >  #include <linux/cdev.h>
> > > -#include <linux/device.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/module.h>
> > > @@ -1027,6 +1026,42 @@ int tee_client_invoke_func(struct tee_context *ctx,
> > >  }
> > >  EXPORT_SYMBOL_GPL(tee_client_invoke_func);
> > >
> > > +static int tee_client_device_match(struct device *dev,
> > > +                                struct device_driver *drv)
> > > +{
> > > +     const struct tee_client_device_id *id_table;
> > > +     struct tee_client_device *tee_device;
> > > +
> > > +     id_table = to_tee_client_driver(drv)->id_table;
> > > +     tee_device = to_tee_client_device(dev);
> > > +
> > > +     while (!uuid_is_null(&id_table->uuid)) {
> > > +             if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
> > > +                     return 1;
> > > +             id_table++;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int tee_client_device_uevent(struct device *dev,
> > > +                                 struct kobj_uevent_env *env)
> > > +{
> > > +     uuid_t *dev_id = &to_tee_client_device(dev)->id.uuid;
> > > +
> > > +     if (add_uevent_var(env, "MODALIAS=tee:%pUb", dev_id))
> > > +             return -ENOMEM;
> > > +
> > > +     return 0;
> >
> > Can just return directly here:
> >
> >         return add_uevent_var(... )
>
> Okay will use this instead.
>
> >
> > Other than these nitpicks then FWIW:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
>
> Thanks.
> -Sumit
>
> > > +}
> > > +
> > > +struct bus_type tee_bus_type = {
> > > +     .name           = "tee",
> > > +     .match          = tee_client_device_match,
> > > +     .uevent         = tee_client_device_uevent,
> > > +};
> > > +EXPORT_SYMBOL_GPL(tee_bus_type);
> > > +
> > >  static int __init tee_init(void)
> > >  {
> > >       int rc;
> > > @@ -1040,18 +1075,32 @@ static int __init tee_init(void)
> > >       rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> > >       if (rc) {
> > >               pr_err("failed to allocate char dev region\n");
> > > -             class_destroy(tee_class);
> > > -             tee_class = NULL;
> > > +             goto out_unreg_class;
> > >       }
> > >
> > > +     rc = bus_register(&tee_bus_type);
> > > +     if (rc) {
> > > +             pr_err("failed to register tee bus\n");
> > > +             goto out_unreg_chrdev;
> > > +     }
> > > +
> > > +     return 0;
> > > +
> > > +out_unreg_chrdev:
> > > +     unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > > +out_unreg_class:
> > > +     class_destroy(tee_class);
> > > +     tee_class = NULL;
> > > +
> > >       return rc;
> > >  }
> > >
> > >  static void __exit tee_exit(void)
> > >  {
> > > +     bus_unregister(&tee_bus_type);
> > > +     unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > >       class_destroy(tee_class);
> > >       tee_class = NULL;
> > > -     unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> > >  }
> > >
> > >  subsys_initcall(tee_init);
> > > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > > index f9bd2f3..14eaeeb 100644
> > > --- a/include/linux/mod_devicetable.h
> > > +++ b/include/linux/mod_devicetable.h
> > > @@ -779,4 +779,13 @@ struct typec_device_id {
> > >       kernel_ulong_t driver_data;
> > >  };
> > >
> > > +/**
> > > + * struct tee_client_device_id - tee based device identifier
> > > + * @uuid: For TEE based client devices we use the device uuid as
> > > + *        the identifier.
> > > + */
> > > +struct tee_client_device_id {
> > > +     uuid_t uuid;
> > > +};
> > > +
> > >  #endif /* LINUX_MOD_DEVICETABLE_H */
> > > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > > index 6cfe058..ce957ce 100644
> > > --- a/include/linux/tee_drv.h
> > > +++ b/include/linux/tee_drv.h
> > > @@ -15,11 +15,14 @@
> > >  #ifndef __TEE_DRV_H
> > >  #define __TEE_DRV_H
> > >
> > > -#include <linux/types.h>
> > > +#include <linux/device.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/kref.h>
> > >  #include <linux/list.h>
> > > +#include <linux/mod_devicetable.h>
> > >  #include <linux/tee.h>
> > > +#include <linux/types.h>
> > > +#include <linux/uuid.h>
> > >
> > >  /*
> > >   * The file describes the API provided by the generic TEE driver to the
> > > @@ -538,4 +541,31 @@ static inline bool tee_param_is_memref(struct tee_param *param)
> > >       }
> > >  }
> > >
> > > +extern struct bus_type tee_bus_type;
> > > +
> > > +/**
> > > + * struct tee_client_device - tee based device
> > > + * @id:                      device identifier
> > > + * @dev:             device structure
> > > + */
> > > +struct tee_client_device {
> > > +     struct tee_client_device_id id;
> > > +     struct device dev;
> > > +};
> > > +
> > > +#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
> > > +
> > > +/**
> > > + * struct tee_client_driver - tee client driver
> > > + * @id_table:                device id table supported by this driver
> > > + * @driver:          driver structure
> > > + */
> > > +struct tee_client_driver {
> > > +     const struct tee_client_device_id *id_table;
> > > +     struct device_driver driver;
> > > +};
> > > +
> > > +#define to_tee_client_driver(d) \
> > > +             container_of(d, struct tee_client_driver, driver)
> > > +
> > >  #endif /*__TEE_DRV_H*/
> > > diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> > > index 2930044..1607183 100644
> > > --- a/scripts/mod/devicetable-offsets.c
> > > +++ b/scripts/mod/devicetable-offsets.c
> > > @@ -225,5 +225,8 @@ int main(void)
> > >       DEVID_FIELD(typec_device_id, svid);
> > >       DEVID_FIELD(typec_device_id, mode);
> > >
> > > +     DEVID(tee_client_device_id);
> > > +     DEVID_FIELD(tee_client_device_id, uuid);
> > > +
> > >       return 0;
> > >  }
> > > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > > index a37af7d..d0e4172 100644
> > > --- a/scripts/mod/file2alias.c
> > > +++ b/scripts/mod/file2alias.c
> > > @@ -37,6 +37,9 @@ typedef unsigned char       __u8;
> > >  typedef struct {
> > >       __u8 b[16];
> > >  } uuid_le;
> > > +typedef struct {
> > > +     __u8 b[16];
> > > +} uuid_t;
> > >
> > >  /* Big exception to the "don't include kernel headers into userspace, which
> > >   * even potentially has different endianness and word sizes, since
> > > @@ -1287,6 +1290,21 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
> > >       return 1;
> > >  }
> > >
> > > +/* Looks like: tee:uuid */
> > > +static int do_tee_entry(const char *filename, void *symval, char *alias)
> > > +{
> > > +     DEF_FIELD(symval, tee_client_device_id, uuid);
> > > +
> > > +     sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
> > > +             uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
> > > +             uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
> > > +             uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
> > > +             uuid.b[15]);
> > > +
> > > +     add_wildcard(alias);
> > > +     return 1;
> > > +}
> > > +
> > >  /* Does namelen bytes of name exactly match the symbol? */
> > >  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
> > >  {
> > > @@ -1357,6 +1375,7 @@ static const struct devtable devtable[] = {
> > >       {"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
> > >       {"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
> > >       {"typec", SIZE_typec_device_id, do_typec_entry},
> > > +     {"tee", SIZE_tee_client_device_id, do_tee_entry},
> > >  };
> > >
> > >  /* Create MODULE_ALIAS() statements.
> > > --
> > > 2.7.4
> > >

With Daniel's inputs addressed, for this patch:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
