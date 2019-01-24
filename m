Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5CDC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A43020854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qsUdtVIY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULcNqx3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A43020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qg2yb7iHFzTpHskIsI/aovl+H1Ova/vKfRDV9bmhWDI=; b=qsUdtVIYHKIKlr
	eqdmzeWVihf9/1UEV7xWKbwImTV3pbFlN0eGsdHmeAmF0fMv1S/eQ2c81FqD6/PJgr0RUkkzovbGP
	/RK747uUgbMAMziYwz5RhgAtu47eUpFF5Db3kTn9Ur/XwvnI21NOUAPyqdNM109DsDdEEGlzPud9L
	KBp5rL97bPdcHRpejYlKEACi8V2noQ57NQsvdaW8xqcDPciPuh09oWgpJuIu+jE2tXKTm686i+JYc
	i2xOCGFyu6pvzfswcbIlqSgPP5DgYaAd7GUzghM5BYvxOPoHnjKORVqfgLVmT8Eeh1i6cQHVbVLle
	JrmHyMSp5IAZtDjdkXhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmdBi-0002Fq-L6; Thu, 24 Jan 2019 11:28:50 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmdBe-0002FT-Ot
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:28:48 +0000
Received: by mail-ua1-x944.google.com with SMTP id d21so1846351uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6TtzdD/cba6sa/DrDzOU/l6zlkRVDT6fBw8RnvsQq3s=;
 b=ULcNqx3/mSpX5maCGz+/K5jI9k2Qj6DXOgdgsx/EVpksvsg7lIyz4wv3fRFo2270xd
 cFHpOcketX44O2SdfZWKoViwaHt+g4m8GTRmD4b6TqgVRX2UJz3aNtfK/eSNxCkL4GDT
 WCE/SwpcYAMeU54TM4Cx8W2xalOKiH97v2zgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6TtzdD/cba6sa/DrDzOU/l6zlkRVDT6fBw8RnvsQq3s=;
 b=sIPWG97Rj2okY3XreHVi319ThBpKfugiCT2cYf7wJf//ZteETd6gCjvlo7iOqdBmbK
 Oo4wFnkW31GbFxyS6A5xolVuSDYBR28TRM2pdH6ySwhlf7yCr9wZyfrW7hUgJv4OhWcQ
 ZqttT4ahGC0I3rtfrhVkACn2D3R6VuHDH7yhxyYh7C0rdyy6QgjlTdV+jP/ZVxnJhIDQ
 T3ygos3WEkGo3TVIFDb4WRCzc/LVHpmNM807xX1PTipVygM7wJXSH86yOxpbXDwtpBEH
 MrjuP8UK4sP+gi/kcBI801kdGjPYOvaCX4vnzSE5zY0GQfc6clmIowtaQHBXSaa0Z/ve
 zhmQ==
X-Gm-Message-State: AJcUukeMMJA3eOtR3BJtajbHAxMEro2QCVURLfwktmwwjKuFaWI3tw6b
 irBQKwNWBAJqbEaf12K9TiBCoFPQa+KKAgozzkGg3w==
X-Google-Smtp-Source: ALg8bN6iS46jnJBIMo8Xyi2MquUv8kAIqGURM0TPbaskQKGy7sLxOz+4QnTtRT/57dqWEHVZ3EJOwGK4XbDdcUCmW4U=
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr2525197uan.97.1548329325479;
 Thu, 24 Jan 2019 03:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
 <1548309279-5281-4-git-send-email-sumit.garg@linaro.org>
 <20190124101509.yrhyaj4xh32bn6pu@holly.lan>
In-Reply-To: <20190124101509.yrhyaj4xh32bn6pu@holly.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 24 Jan 2019 16:58:33 +0530
Message-ID: <CAFA6WYNTo+fQ0zcgP3SuBXeFmzMY3AiHXsbMtHWE+rNoYQPUgg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tee: optee: add TEE bus device enumeration support
To: Daniel Thompson <daniel.thompson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_032846_841850_FD0D2438 
X-CRM114-Status: GOOD (  26.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, michal.lkml@markovi.net,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>,
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

On Thu, 24 Jan 2019 at 15:45, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jan 24, 2019 at 11:24:38AM +0530, Sumit Garg wrote:
> > OP-TEE provides a pseudo TA to enumerate TAs which can act as devices/
> > services for TEE bus. So implement device enumeration using invoke
> > function: PTA_CMD_GET_DEVICES provided by pseudo TA to fetch array of
> > device UUIDs. Also register these enumerated devices with TEE bus as
> > "optee-clntX" device.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |   1 +
> >  drivers/tee/optee/core.c          |   4 +
> >  drivers/tee/optee/device.c        | 153 ++++++++++++++++++++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h |   3 +
> >  4 files changed, 161 insertions(+)
> >  create mode 100644 drivers/tee/optee/device.c
> >
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 48d262a..56263ae 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -5,3 +5,4 @@ optee-objs += call.o
> >  optee-objs += rpc.o
> >  optee-objs += supp.o
> >  optee-objs += shm_pool.o
> > +optee-objs += device.o
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index e5efce3..ac59c77 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -634,6 +634,10 @@ static struct optee *optee_probe(struct device_node *np)
> >       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> >               pr_info("dynamic shared memory is enabled\n");
> >
> > +     rc = optee_enumerate_devices();
> > +     if (rc)
> > +             goto err;
> > +
> >       pr_info("initialized driver\n");
> >       return optee;
> >  err:
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > new file mode 100644
> > index 0000000..987e552
> > --- /dev/null
> > +++ b/drivers/tee/optee/device.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Linaro Ltd.
> > + */
> > +
>
> Does there need to be a pr_fmt() here (to make the pr_*() messages from
> this file match those from the optee/core.c):
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>

I think for consistency with optee/core.c file prints, will add this here.

> Alternatively you could get the probe function to pass the optee device
> and use dev_*()...
>
> TBH this is pretty severe nitpicking so feel free to add my reviewed
> by the next time this patch comes around:
>

No worries :).

-Sumit

> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>
> Daniel.
>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/uuid.h>
> > +#include "optee_private.h"
> > +
> > +/*
> > + * Get device UUIDs
> > + *
> > + * [out]     memref[0]        Array of device UUIDs
> > + *
> > + * Return codes:
> > + * TEE_SUCCESS - Invoke command success
> > + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> > + * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
> > + */
> > +#define PTA_CMD_GET_DEVICES          0x0
> > +
> > +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> > +{
> > +     if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> > +             return 1;
> > +     else
> > +             return 0;
> > +}
> > +
> > +static int get_devices(struct tee_context *ctx, u32 session,
> > +                    struct tee_shm *device_shm, u32 *shm_size)
> > +{
> > +     u32 ret = 0;
> > +     struct tee_ioctl_invoke_arg inv_arg = {0};
> > +     struct tee_param param[4] = {0};
> > +
> > +     /* Invoke PTA_CMD_GET_DEVICES function */
> > +     inv_arg.func = PTA_CMD_GET_DEVICES;
> > +     inv_arg.session = session;
> > +     inv_arg.num_params = 4;
> > +
> > +     /* Fill invoke cmd params */
> > +     param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +     param[0].u.memref.shm = device_shm;
> > +     param[0].u.memref.size = *shm_size;
> > +     param[0].u.memref.shm_offs = 0;
> > +
> > +     ret = tee_client_invoke_func(ctx, &inv_arg, param);
> > +     if ((ret < 0) || ((inv_arg.ret != TEEC_SUCCESS) &&
> > +                       (inv_arg.ret != TEEC_ERROR_SHORT_BUFFER))) {
> > +             pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n",
> > +                    inv_arg.ret);
> > +             return -EINVAL;
> > +     }
> > +
> > +     *shm_size = param[0].u.memref.size;
> > +
> > +     return 0;
> > +}
> > +
> > +static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > +{
> > +     struct tee_client_device *optee_device = NULL;
> > +     int rc;
> > +
> > +     optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> > +     if (!optee_device)
> > +             return -ENOMEM;
> > +
> > +     optee_device->dev.bus = &tee_bus_type;
> > +     dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > +     uuid_copy(&optee_device->id.uuid, device_uuid);
> > +
> > +     rc = device_register(&optee_device->dev);
> > +     if (rc) {
> > +             pr_err("device registration failed, err: %d\n", rc);
> > +             kfree(optee_device);
> > +     }
> > +
> > +     return rc;
> > +}
> > +
> > +int optee_enumerate_devices(void)
> > +{
> > +     const uuid_t pta_uuid =
> > +             UUID_INIT(0x7011a688, 0xddde, 0x4053,
> > +                       0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8);
> > +     struct tee_ioctl_open_session_arg sess_arg = {0};
> > +     struct tee_shm *device_shm = NULL;
> > +     const uuid_t *device_uuid = NULL;
> > +     struct tee_context *ctx = NULL;
> > +     u32 shm_size = 0, idx, num_devices = 0;
> > +     int rc;
> > +
> > +     /* Open context with OP-TEE driver */
> > +     ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> > +     if (IS_ERR(ctx))
> > +             return -ENODEV;
> > +
> > +     /* Open session with device enumeration pseudo TA */
> > +     memcpy(sess_arg.uuid, pta_uuid.b, TEE_IOCTL_UUID_LEN);
> > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > +     sess_arg.num_params = 0;
> > +
> > +     rc = tee_client_open_session(ctx, &sess_arg, NULL);
> > +     if ((rc < 0) || (sess_arg.ret != TEEC_SUCCESS)) {
> > +             /* Device enumeration pseudo TA not found */
> > +             rc = 0;
> > +             goto out_ctx;
> > +     }
> > +
> > +     rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
> > +     if (rc < 0)
> > +             goto out_sess;
> > +
> > +     device_shm = tee_shm_alloc(ctx, shm_size,
> > +                                TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +     if (IS_ERR(device_shm)) {
> > +             pr_err("tee_shm_alloc failed\n");
> > +             rc = PTR_ERR(device_shm);
> > +             goto out_sess;
> > +     }
> > +
> > +     rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > +     if (rc < 0)
> > +             goto out_shm;
> > +
> > +     device_uuid = tee_shm_get_va(device_shm, 0);
> > +     if (IS_ERR(device_uuid)) {
> > +             pr_err("tee_shm_get_va failed\n");
> > +             rc = PTR_ERR(device_uuid);
> > +             goto out_shm;
> > +     }
> > +
> > +     num_devices = shm_size / sizeof(uuid_t);
> > +
> > +     for (idx = 0; idx < num_devices; idx++) {
> > +             rc = optee_register_device(&device_uuid[idx], idx);
> > +             if (rc)
> > +                     goto out_shm;
> > +     }
> > +
> > +out_shm:
> > +     tee_shm_free(device_shm);
> > +out_sess:
> > +     tee_client_close_session(ctx, sess_arg.session);
> > +out_ctx:
> > +     tee_client_close_context(ctx);
> > +
> > +     return rc;
> > +}
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 35e7938..a5e84af 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -28,6 +28,7 @@
> >  #define TEEC_ERROR_BAD_PARAMETERS    0xFFFF0006
> >  #define TEEC_ERROR_COMMUNICATION     0xFFFF000E
> >  #define TEEC_ERROR_OUT_OF_MEMORY     0xFFFF000C
> > +#define TEEC_ERROR_SHORT_BUFFER              0xFFFF0010
> >
> >  #define TEEC_ORIGIN_COMMS            0x00000002
> >
> > @@ -181,6 +182,8 @@ void optee_free_pages_list(void *array, size_t num_entries);
> >  void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
> >                          size_t page_offset);
> >
> > +int optee_enumerate_devices(void);
> > +
> >  /*
> >   * Small helpers
> >   */
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
