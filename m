Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79157C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:30:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF9F20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XG6bOaVJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJG1KVGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF9F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZlfTWmnlpGk4ebgj8RO3/l9A6eFvCEFDA9yJpBI1R0U=; b=XG6bOaVJDBhrff
	dDNePWRsr+hGxzfBrh4YXKlTnQQ77HkUSczWjUdAUK7HAE4TZ5vmPLFe4dXVnM+MnKzQojYi7h5MI
	w06Dm21T9rXm/h2ugW8nwy8TJGGy1MKGdwJOcn4+gwDGSqQUW5U0PqOmCU4aSyHPF2NBF09IuNaVJ
	xZEW+gfpR6xsYKLvx9JL6SJ7uYAOFKhYOBJdRyOJITARC9KR+0eHPF9rgg6Ue2xxbWHWSsBg6uUcW
	l/p7DNRbMlZ8cGg80n8j/zN42x9DHhRiduO1ql4fvnTqH9KbghlfxRT7d49vAKZdp2lr6OLN8q+xU
	h08DtxSjheHqtEUa444w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnyZQ-0005LD-N0; Mon, 28 Jan 2019 04:30:52 +0000
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnyZN-0005Km-27
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 04:30:51 +0000
Received: by mail-vk1-xa43.google.com with SMTP id j23so3371863vke.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 20:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yenhmi2j4TkGM2GINDSEMBHITUuoeZKSorinP3U+/s8=;
 b=PJG1KVGFc1MQQuBNUyuzu4aSjR/sAeNAM1M58KMDaYGCJtlfO6iNqUis8pzIWuXkj+
 sn/zCNgocZUrTzZtyxJxTwnbA5qljvMnxloKR6uoWyB8hrT9lXaUyoRIH0eQ50h38RgP
 uLqTZuhv3Mq9xfRaXxitSf9yBxn7ts4qJq8V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yenhmi2j4TkGM2GINDSEMBHITUuoeZKSorinP3U+/s8=;
 b=sNQhYjUCAC6kmKYKOiv5VuvBV8cbHR5LE2Fv3x+R4ZM8npDt4CxX6rxFmrHaef6okB
 HDo44v3DJc2R9rDUkBxICe8+KlzVB8ygcd24Pqx8dnNJ+am0K2qNh2GdWtp3mSdPBAQz
 FhTui12wkTUZXSLS3hznTWQ6xNLvHi21zi81KAL05F9q8nwahvOb1GhWlcawOPh25Ywy
 rBblmSvaYh2ogILtqkeiurrqYjzctE3w4LEsRwj2h323oQVm1MrDsgOzwpM/oXyMDtxD
 TGuOJkqwNb+hhgbCeftXmW83Clj8jBGgmwsd6CWe+aOPlToD1Z6XaHGUbof/ezeKDXNo
 t5yw==
X-Gm-Message-State: AJcUukefjE4Fdz0BuhBAoRrGWC6ouC5BbXI/VENQcVwQKjsIeTbxHECr
 TzC7Em+gi+sKnYMCQWbFiRAIEE9mgdkylU4AhCeqxw==
X-Google-Smtp-Source: ALg8bN7BSKydUadcEiXgvFOwHNns+YxxsdUQKcBRIr8T66GQbWKEHr++bq6I83aIpnV3a8avNaCP0pXH+TyjHM2t7kU=
X-Received: by 2002:a1f:95d1:: with SMTP id x200mr8039872vkd.78.1548649846121; 
 Sun, 27 Jan 2019 20:30:46 -0800 (PST)
MIME-Version: 1.0
References: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
 <1548309279-5281-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1548309279-5281-5-git-send-email-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 28 Jan 2019 10:00:34 +0530
Message-ID: <CAFA6WYMpX7YqXqYXtKPAw52gyhgzt=RMFihyUN_gkj3b+OurPQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] hwrng: add OP-TEE based rng driver
To: Herbert Xu <herbert@gondor.apana.org.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_203049_130373_7BC30982 
X-CRM114-Status: GOOD (  25.57  )
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
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

Hi Herbert,

On Thu, 24 Jan 2019 at 11:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On ARM SoC's with TrustZone enabled, peripherals like entropy sources
> might not be accessible to normal world (linux in this case) and rather
> accessible to secure world (OP-TEE in this case) only. So this driver
> aims to provides a generic interface to OP-TEE based random number
> generator service.
>
> This driver registers on TEE bus to interact with OP-TEE based rng
> device/service.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Do you have any comments/feedback on this patch before I send next version (v6)?

-Sumit

> ---
>  MAINTAINERS                        |   5 +
>  drivers/char/hw_random/Kconfig     |  15 ++
>  drivers/char/hw_random/Makefile    |   1 +
>  drivers/char/hw_random/optee-rng.c | 274 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 295 insertions(+)
>  create mode 100644 drivers/char/hw_random/optee-rng.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a4..dcef7e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11262,6 +11262,11 @@ M:     Jens Wiklander <jens.wiklander@linaro.org>
>  S:     Maintained
>  F:     drivers/tee/optee/
>
> +OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> +M:     Sumit Garg <sumit.garg@linaro.org>
> +S:     Maintained
> +F:     drivers/char/hw_random/optee-rng.c
> +
>  OPA-VNIC DRIVER
>  M:     Dennis Dalessandro <dennis.dalessandro@intel.com>
>  M:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index dac895d..25a7d8f 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -424,6 +424,21 @@ config HW_RANDOM_EXYNOS
>           will be called exynos-trng.
>
>           If unsure, say Y.
> +
> +config HW_RANDOM_OPTEE
> +       tristate "OP-TEE based Random Number Generator support"
> +       depends on OPTEE
> +       default HW_RANDOM
> +       help
> +         This  driver provides support for OP-TEE based Random Number
> +         Generator on ARM SoCs where hardware entropy sources are not
> +         accessible to normal world (Linux).
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called optee-rng.
> +
> +         If unsure, say Y.
> +
>  endif # HW_RANDOM
>
>  config UML_RANDOM
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index e35ec3c..7c9ef4a 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
>  obj-$(CONFIG_HW_RANDOM_MTK)    += mtk-rng.o
>  obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
>  obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
> +obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> new file mode 100644
> index 0000000..4ad0eca
> --- /dev/null
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018-2019 Linaro Ltd.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/hw_random.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +
> +#define DRIVER_NAME "optee-rng"
> +
> +#define TEE_ERROR_HEALTH_TEST_FAIL     0x00000001
> +
> +/*
> + * TA_CMD_GET_ENTROPY - Get Entropy from RNG
> + *
> + * param[0] (inout memref) - Entropy buffer memory reference
> + * param[1] unused
> + * param[2] unused
> + * param[3] unused
> + *
> + * Result:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + * TEE_ERROR_NOT_SUPPORTED - Requested entropy size greater than size of pool
> + * TEE_ERROR_HEALTH_TEST_FAIL - Continuous health testing failed
> + */
> +#define TA_CMD_GET_ENTROPY             0x0
> +
> +/*
> + * TA_CMD_GET_RNG_INFO - Get RNG information
> + *
> + * param[0] (out value) - value.a: RNG data-rate in bytes per second
> + *                        value.b: Quality/Entropy per 1024 bit of data
> + * param[1] unused
> + * param[2] unused
> + * param[3] unused
> + *
> + * Result:
> + * TEE_SUCCESS - Invoke command success
> + * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
> + */
> +#define TA_CMD_GET_RNG_INFO            0x1
> +
> +#define MAX_ENTROPY_REQ_SZ             (4 * 1024)
> +
> +static struct tee_context *ctx;
> +static struct tee_shm *entropy_shm_pool;
> +static u32 ta_rng_data_rate;
> +static u32 ta_rng_session_id;
> +
> +static size_t get_optee_rng_data(void *buf, size_t req_size)
> +{
> +       u32 ret = 0;
> +       u8 *rng_data = NULL;
> +       size_t rng_size = 0;
> +       struct tee_ioctl_invoke_arg inv_arg = {0};
> +       struct tee_param param[4] = {0};
> +
> +       /* Invoke TA_CMD_GET_ENTROPY function of Trusted App */
> +       inv_arg.func = TA_CMD_GET_ENTROPY;
> +       inv_arg.session = ta_rng_session_id;
> +       inv_arg.num_params = 4;
> +
> +       /* Fill invoke cmd params */
> +       param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +       param[0].u.memref.shm = entropy_shm_pool;
> +       param[0].u.memref.size = req_size;
> +       param[0].u.memref.shm_offs = 0;
> +
> +       ret = tee_client_invoke_func(ctx, &inv_arg, param);
> +       if ((ret < 0) || (inv_arg.ret != 0)) {
> +               pr_err("TA_CMD_GET_ENTROPY invoke function error: %x\n",
> +                      inv_arg.ret);
> +               return 0;
> +       }
> +
> +       rng_data = tee_shm_get_va(entropy_shm_pool, 0);
> +       if (IS_ERR(rng_data)) {
> +               pr_err("tee_shm_get_va failed\n");
> +               return 0;
> +       }
> +
> +       rng_size = param[0].u.memref.size;
> +       memcpy(buf, rng_data, rng_size);
> +
> +       return rng_size;
> +}
> +
> +static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +       u8 *data = buf;
> +       size_t read = 0, rng_size = 0;
> +       int timeout = 1;
> +
> +       if (max > MAX_ENTROPY_REQ_SZ)
> +               max = MAX_ENTROPY_REQ_SZ;
> +
> +       while (read == 0) {
> +               rng_size = get_optee_rng_data(data, (max - read));
> +
> +               data += rng_size;
> +               read += rng_size;
> +
> +               if (wait) {
> +                       if (timeout-- == 0)
> +                               return read;
> +                       msleep((1000 * (max - read)) / ta_rng_data_rate);
> +               } else {
> +                       return read;
> +               }
> +       }
> +
> +       return read;
> +}
> +
> +static int optee_rng_init(struct hwrng *rng)
> +{
> +       entropy_shm_pool = tee_shm_alloc(ctx, MAX_ENTROPY_REQ_SZ,
> +                                        TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       if (IS_ERR(entropy_shm_pool)) {
> +               pr_err("tee_shm_alloc failed\n");
> +               return PTR_ERR(entropy_shm_pool);
> +       }
> +
> +       return 0;
> +}
> +
> +static void optee_rng_cleanup(struct hwrng *rng)
> +{
> +       tee_shm_free(entropy_shm_pool);
> +}
> +
> +static struct hwrng optee_rng = {
> +       .name           = DRIVER_NAME,
> +       .init           = optee_rng_init,
> +       .cleanup        = optee_rng_cleanup,
> +       .read           = optee_rng_read,
> +};
> +
> +static int get_optee_rng_info(struct device *dev)
> +{
> +       u32 ret = 0;
> +       struct tee_ioctl_invoke_arg inv_arg = {0};
> +       struct tee_param param[4] = {0};
> +
> +       /* Invoke TA_CMD_GET_RNG_INFO function of Trusted App */
> +       inv_arg.func = TA_CMD_GET_RNG_INFO;
> +       inv_arg.session = ta_rng_session_id;
> +       inv_arg.num_params = 4;
> +
> +       /* Fill invoke cmd params */
> +       param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +
> +       ret = tee_client_invoke_func(ctx, &inv_arg, param);
> +       if ((ret < 0) || (inv_arg.ret != 0)) {
> +               dev_err(dev, "TA_CMD_GET_RNG_INFO invoke func error: %x\n",
> +                       inv_arg.ret);
> +               return -EINVAL;
> +       }
> +
> +       ta_rng_data_rate = param[0].u.value.a;
> +       optee_rng.quality = param[0].u.value.b;
> +
> +       return 0;
> +}
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +       if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +               return 1;
> +       else
> +               return 0;
> +}
> +
> +static int optee_rng_probe(struct device *dev)
> +{
> +       struct tee_client_device *rng_device = to_tee_client_device(dev);
> +       int ret = 0, err = -ENODEV;
> +       struct tee_ioctl_open_session_arg sess_arg = {0};
> +
> +       /* Open context with TEE driver */
> +       ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +       if (IS_ERR(ctx))
> +               return -ENODEV;
> +
> +       /* Open session with hwrng Trusted App */
> +       memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +       sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +       sess_arg.num_params = 0;
> +
> +       ret = tee_client_open_session(ctx, &sess_arg, NULL);
> +       if ((ret < 0) || (sess_arg.ret != 0)) {
> +               dev_err(dev, "tee_client_open_session failed, error: %x\n",
> +                       sess_arg.ret);
> +               err = -EINVAL;
> +               goto out_ctx;
> +       }
> +       ta_rng_session_id = sess_arg.session;
> +
> +       err = get_optee_rng_info(dev);
> +       if (err)
> +               goto out_sess;
> +
> +       err = hwrng_register(&optee_rng);
> +       if (err) {
> +               dev_err(dev, "hwrng registration failed (%d)\n", err);
> +               goto out_sess;
> +       }
> +
> +       return 0;
> +
> +out_sess:
> +       tee_client_close_session(ctx, ta_rng_session_id);
> +out_ctx:
> +       tee_client_close_context(ctx);
> +
> +       return err;
> +}
> +
> +static int optee_rng_remove(struct device *dev)
> +{
> +       hwrng_unregister(&optee_rng);
> +       tee_client_close_session(ctx, ta_rng_session_id);
> +       tee_client_close_context(ctx);
> +
> +       return 0;
> +}
> +
> +const struct tee_client_device_id optee_rng_id_table[] = {
> +       {UUID_INIT(0xab7a617c, 0xb8e7, 0x4d8f,
> +                  0x83, 0x01, 0xd0, 0x9b, 0x61, 0x03, 0x6b, 0x64)},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(tee, optee_rng_id_table);
> +
> +static struct tee_client_driver optee_rng_driver = {
> +       .id_table       = optee_rng_id_table,
> +       .driver         = {
> +               .name           = DRIVER_NAME,
> +               .bus            = &tee_bus_type,
> +               .probe          = optee_rng_probe,
> +               .remove         = optee_rng_remove,
> +       },
> +};
> +
> +static int __init optee_rng_mod_init(void)
> +{
> +       int rc;
> +
> +       rc = driver_register(&optee_rng_driver.driver);
> +       if (rc)
> +               pr_warn("driver registration failed, err: %d", rc);
> +
> +       return rc;
> +}
> +
> +static void __exit optee_rng_mod_exit(void)
> +{
> +       driver_unregister(&optee_rng_driver.driver);
> +}
> +
> +module_init(optee_rng_mod_init);
> +module_exit(optee_rng_mod_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Sumit Garg <sumit.garg@linaro.org>");
> +MODULE_DESCRIPTION("OP-TEE based random number generator driver");
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
