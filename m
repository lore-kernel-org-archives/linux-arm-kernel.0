Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08753C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8953214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ophojlsv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="be75JzQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8953214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=elQ54sBCn7hFnJPfpeQB8Ua4HawRCY85mSGEjNdVj8g=; b=ophojlsvTz6S08
	nBDnFnK71rbq7Guh8bhv2Wk/lQF9hu0I0+o5CKxF+tBoQCsKw80AaC2f4fPehsmOQ+AdurjHjfzg4
	A7S/oRaPnbQ70HQzGHDER8/i38KYW2QSRDUxVBgkoGSPxn733Gv2yNRve/AWZluloTEQ6QwQman6p
	frG6HlZCQTKRM9WBouL+Bvsx0HPyxUROxz+bqJE5OQOkPF/bQl8E3o/d29w59cipPaJwRj6RYFkYK
	OuUHuEKTiEK8iMOq4QtN7U5kvqAyN9Q+5xNpK4R+kj58HZFuSlRz185+hMFuuN5tIxXF8p56MHfKP
	O9sfxEEgaktAwlv1OSsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPn7-00022N-8C; Tue, 29 Jan 2019 09:34:49 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPn3-00021q-0r
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:34:46 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so21143271wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1AFF7zfX2emsgFskKDZcDByeBSeYsdpHdS8Qjt8Fvk0=;
 b=be75JzQ3jNtOmjZ9pY+G6UDaF7nMhsLqBiCx9bEFu67W6j7AG9d3/DmYlWgCo8aE+Z
 nvXGrGyOCYZspvrLcLX8AKnuV198r3JRJv8Pt3z34OISRcuLUCQz0zSuFM+9Cp/TJagu
 j0muTfRPiIS3sZuP4GA9JI6slzsTyoHYqBiqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1AFF7zfX2emsgFskKDZcDByeBSeYsdpHdS8Qjt8Fvk0=;
 b=S1aQECss8qMps+Ec4aRDTPjXApMX6pUlzlaQSzdLZ6hEtJDROfFmZ+3+qExbIIqyjQ
 7Nblv0eNu6kmMrRwLq6pMfS36Gy+DqBpwnrCFS57d3uiitAp96u6SvDGJygzd21/iHlY
 8ZXmUaotl+aoVS+L9RpcE43XPAMfb5PRvcR1k+/6m1RFo0LIdfF7PeX4r0tuKj+37NCO
 LKqgGy5Ci6ii5uSYGQCvycTIoCzvsqUpOgthQLmH0x7ngzkY4wGT82d54wnbyFNRIDnk
 ByQYCttqfc7ZOBVfVVTcwhz5nSUSAe/5fycJeU7lKZMWbGzBE2wZR6hax1bqWmEaZ/FM
 Hv0g==
X-Gm-Message-State: AJcUukdtlDLq3PjHe1JwmDDzMEkM+8tc8hIyB+6TfChyHlH+Uy5RRu1u
 hVHFRmxoYRqcOR37qcA8px373g==
X-Google-Smtp-Source: ALg8bN7i9H4V36F2QpJD+R1s87YCkrz6LYWM9Om19UoH3tN3s4IGh7jY+42fFDeeASYwZGfbuicQGA==
X-Received: by 2002:a5d:42ce:: with SMTP id t14mr25430839wrr.51.1548754482836; 
 Tue, 29 Jan 2019 01:34:42 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id f187sm1568911wma.4.2019.01.29.01.34.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 01:34:41 -0800 (PST)
Date: Tue, 29 Jan 2019 09:34:39 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v6 4/4] hwrng: add OP-TEE based rng driver
Message-ID: <20190129093439.oftwq4labucdql4b@holly.lan>
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
 <1548740978-28495-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548740978-28495-5-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013445_073311_4E378DFE 
X-CRM114-Status: GOOD (  25.82  )
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
Cc: mark.rutland@arm.com, michal.lkml@markovi.net, herbert@gondor.apana.org.au,
 arnd@arndb.de, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
 bhsharma@redhat.com, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
 yamada.masahiro@socionext.com, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com, jens.wiklander@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 11:19:38AM +0530, Sumit Garg wrote:
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  MAINTAINERS                        |   5 +
>  drivers/char/hw_random/Kconfig     |  15 ++
>  drivers/char/hw_random/Makefile    |   1 +
>  drivers/char/hw_random/optee-rng.c | 298 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/char/hw_random/optee-rng.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a4..dcef7e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11262,6 +11262,11 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
>  S:	Maintained
>  F:	drivers/tee/optee/
>  
> +OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> +M:	Sumit Garg <sumit.garg@linaro.org>
> +S:	Maintained
> +F:	drivers/char/hw_random/optee-rng.c
> +
>  OPA-VNIC DRIVER
>  M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
>  M:	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index dac895d..25a7d8f 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -424,6 +424,21 @@ config HW_RANDOM_EXYNOS
>  	  will be called exynos-trng.
>  
>  	  If unsure, say Y.
> +
> +config HW_RANDOM_OPTEE
> +	tristate "OP-TEE based Random Number Generator support"
> +	depends on OPTEE
> +	default HW_RANDOM
> +	help
> +	  This  driver provides support for OP-TEE based Random Number
> +	  Generator on ARM SoCs where hardware entropy sources are not
> +	  accessible to normal world (Linux).
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called optee-rng.
> +
> +	  If unsure, say Y.
> +
>  endif # HW_RANDOM
>  
>  config UML_RANDOM
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index e35ec3c..7c9ef4a 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
>  obj-$(CONFIG_HW_RANDOM_MTK)	+= mtk-rng.o
>  obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
>  obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
> +obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> new file mode 100644
> index 0000000..2b9fc8a
> --- /dev/null
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -0,0 +1,298 @@
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
> +#define TEE_ERROR_HEALTH_TEST_FAIL	0x00000001
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
> +#define TA_CMD_GET_ENTROPY		0x0
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
> +#define TA_CMD_GET_RNG_INFO		0x1
> +
> +#define MAX_ENTROPY_REQ_SZ		(4 * 1024)
> +
> +/**
> + * struct optee_rng_private - OP-TEE Random Number Generator private data
> + * @dev:		OP-TEE based RNG device.
> + * @ctx:		OP-TEE context handler.
> + * @session_id:		RNG TA session identifier.
> + * @data_rate:		RNG data rate.
> + * @entropy_shm_pool:	Memory pool shared with RNG device.
> + * @optee_rng:		OP-TEE RNG driver structure.
> + */
> +struct optee_rng_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +	u32 data_rate;
> +	struct tee_shm *entropy_shm_pool;
> +	struct hwrng optee_rng;
> +};
> +
> +#define to_optee_rng_private(r) \
> +		container_of(r, struct optee_rng_private, optee_rng)
> +
> +static size_t get_optee_rng_data(struct optee_rng_private *pvt_data,
> +				 void *buf, size_t req_size)
> +{
> +	u32 ret = 0;
> +	u8 *rng_data = NULL;
> +	size_t rng_size = 0;
> +	struct tee_ioctl_invoke_arg inv_arg = {0};
> +	struct tee_param param[4] = {0};
> +
> +	/* Invoke TA_CMD_GET_ENTROPY function of Trusted App */
> +	inv_arg.func = TA_CMD_GET_ENTROPY;
> +	inv_arg.session = pvt_data->session_id;
> +	inv_arg.num_params = 4;
> +
> +	/* Fill invoke cmd params */
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +	param[0].u.memref.shm = pvt_data->entropy_shm_pool;
> +	param[0].u.memref.size = req_size;
> +	param[0].u.memref.shm_offs = 0;
> +
> +	ret = tee_client_invoke_func(pvt_data->ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		dev_err(pvt_data->dev, "TA_CMD_GET_ENTROPY invoke err: %x\n",
> +			inv_arg.ret);
> +		return 0;
> +	}
> +
> +	rng_data = tee_shm_get_va(pvt_data->entropy_shm_pool, 0);
> +	if (IS_ERR(rng_data)) {
> +		dev_err(pvt_data->dev, "tee_shm_get_va failed\n");
> +		return 0;
> +	}
> +
> +	rng_size = param[0].u.memref.size;
> +	memcpy(buf, rng_data, rng_size);
> +
> +	return rng_size;
> +}
> +
> +static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
> +	size_t read = 0, rng_size = 0;
> +	int timeout = 1;
> +	u8 *data = buf;
> +
> +	if (max > MAX_ENTROPY_REQ_SZ)
> +		max = MAX_ENTROPY_REQ_SZ;
> +
> +	while (read == 0) {
> +		rng_size = get_optee_rng_data(pvt_data, data, (max - read));
> +
> +		data += rng_size;
> +		read += rng_size;
> +
> +		if (wait) {
> +			if (timeout-- == 0)
> +				return read;
> +			msleep((1000 * (max - read)) / pvt_data->data_rate);
> +		} else {
> +			return read;
> +		}
> +	}
> +
> +	return read;
> +}
> +
> +static int optee_rng_init(struct hwrng *rng)
> +{
> +	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
> +	struct tee_shm *entropy_shm_pool = NULL;
> +
> +	entropy_shm_pool = tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
> +					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	if (IS_ERR(entropy_shm_pool)) {
> +		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
> +		return PTR_ERR(entropy_shm_pool);
> +	}
> +
> +	pvt_data->entropy_shm_pool = entropy_shm_pool;
> +
> +	return 0;
> +}
> +
> +static void optee_rng_cleanup(struct hwrng *rng)
> +{
> +	struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
> +
> +	tee_shm_free(pvt_data->entropy_shm_pool);
> +}
> +
> +static struct optee_rng_private pvt_data = {
> +	.optee_rng = {
> +		.name		= DRIVER_NAME,
> +		.init		= optee_rng_init,
> +		.cleanup	= optee_rng_cleanup,
> +		.read		= optee_rng_read,
> +	}
> +};
> +
> +static int get_optee_rng_info(struct device *dev)
> +{
> +	u32 ret = 0;
> +	struct tee_ioctl_invoke_arg inv_arg = {0};
> +	struct tee_param param[4] = {0};
> +
> +	/* Invoke TA_CMD_GET_RNG_INFO function of Trusted App */
> +	inv_arg.func = TA_CMD_GET_RNG_INFO;
> +	inv_arg.session = pvt_data.session_id;
> +	inv_arg.num_params = 4;
> +
> +	/* Fill invoke cmd params */
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +
> +	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		dev_err(dev, "TA_CMD_GET_RNG_INFO invoke err: %x\n",
> +			inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	pvt_data.data_rate = param[0].u.value.a;
> +	pvt_data.optee_rng.quality = param[0].u.value.b;
> +
> +	return 0;
> +}
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int optee_rng_probe(struct device *dev)
> +{
> +	struct tee_client_device *rng_device = to_tee_client_device(dev);
> +	int ret = 0, err = -ENODEV;
> +	struct tee_ioctl_open_session_arg sess_arg = {0};
> +
> +	/* Open context with TEE driver */
> +	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
> +					       NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	/* Open session with hwrng Trusted App */
> +	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +	sess_arg.num_params = 0;
> +
> +	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((ret < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		err = -EINVAL;
> +		goto out_ctx;
> +	}
> +	pvt_data.session_id = sess_arg.session;
> +
> +	err = get_optee_rng_info(dev);
> +	if (err)
> +		goto out_sess;
> +
> +	err = hwrng_register(&pvt_data.optee_rng);
> +	if (err) {
> +		dev_err(dev, "hwrng registration failed (%d)\n", err);
> +		goto out_sess;
> +	}
> +
> +	pvt_data.dev = dev;
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return err;
> +}
> +
> +static int optee_rng_remove(struct device *dev)
> +{
> +	hwrng_unregister(&pvt_data.optee_rng);
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +const struct tee_client_device_id optee_rng_id_table[] = {
> +	{UUID_INIT(0xab7a617c, 0xb8e7, 0x4d8f,
> +		   0x83, 0x01, 0xd0, 0x9b, 0x61, 0x03, 0x6b, 0x64)},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(tee, optee_rng_id_table);
> +
> +static struct tee_client_driver optee_rng_driver = {
> +	.id_table	= optee_rng_id_table,
> +	.driver		= {
> +		.name		= DRIVER_NAME,
> +		.bus		= &tee_bus_type,
> +		.probe		= optee_rng_probe,
> +		.remove		= optee_rng_remove,
> +	},
> +};
> +
> +static int __init optee_rng_mod_init(void)
> +{
> +	return driver_register(&optee_rng_driver.driver);
> +}
> +
> +static void __exit optee_rng_mod_exit(void)
> +{
> +	driver_unregister(&optee_rng_driver.driver);
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
