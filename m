Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5917FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B8F20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUJfuL9v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXv+iqsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B8F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TSBxQU1W1l3jyEXB0w/PKrx2T5VFisKsSExP/FT4Ik=; b=DUJfuL9v9Dxiq7
	IKPcDumbZAcQmX5EhEdlx8E+yT+vrgUMvBfmSDtriojgBePsfsiE8mhLm0nZdvTJPAg88+P/8AbjA
	v3ZO9nmI+VHWM2xTimrKtN8iX5gUBUxmYq5I+/oRkA4naz21e4o0AGBMDhCjmNuHO7imT6CZpbfcG
	06g9MScpPYiPMI7lVKbR5hKu40w+8mi+h/nDoav7XpL9WgJjE46U+RvGXYhBl6Pu78krz4JgGlQFd
	50fddDG70c5fuFncvns1zR+UHCeWQ5Srzhd7tRftc9/eF66wTOyN0nxCCC7VmxcG6fKU0Jrt4liSb
	sP/zHrTGTmg/6SNvMnoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPZi-00018D-1l; Fri, 07 Dec 2018 23:30:26 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPZe-00016U-GB
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:30:24 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so2494165plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Xe+0U7AEF8Sy7fWxtsHJuSR6GRBK1TSDzTBz0pDfccs=;
 b=nXv+iqsR3ikh3pfPJPyqvHsQOJMcG1Sdd8aUXxvREnPC1FDCS1+vtazYujGGoCxwj/
 +7/Msre3Gfucywvgn61x9xIN2xsU9yS0n3rvveajNzGzfbmesoEnyPGdKSadUSZsDw+m
 JkhQOBh5k5zgVHopm8j98iaKS4McYAu8//am0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Xe+0U7AEF8Sy7fWxtsHJuSR6GRBK1TSDzTBz0pDfccs=;
 b=ovZ5Cdg5ebtp/M+L3tC/SESGVTnvHotfUO0MxGNdCbmVHva0Owtu43l/fYIqYeXfzw
 RrLtvp+M3so/bVyNEalYhdkJsX3+wpn7vhXwaErUSd6hB0ODFYUmBZ0v/y7wiwUk/+vb
 HNLlaVFGmyXob+cFIO3zJOx47UvHdEYlGC8JLbtzOj7NMZPTRhqh3r0k/kV6+FVvz741
 3KJxgsjlbHPtIk8A8OiV96S/FixTks7KdQ0TkB6RQFMP1rZpwk1M3lUMox91rxkIuEoU
 mrMBWhdf17fLN0KvS4MRAAV97Lz6Nn9ZYaYFJdgXPx0IKKzjk394WABwPFDHD3d1d6Ag
 /6Cw==
X-Gm-Message-State: AA+aEWYjgOeSI7B+Csv/09gQWwsLH0+mGdY+gB2WD3Qr6PVb5IYfKK9v
 qwwQJzXXnc9Qx4BQwdThaGitVg==
X-Google-Smtp-Source: AFSGD/VUFWwgJ7kZ4oBpIIbUlYW1RnJ8Hni5iGZ61RzOq8t4IIpAJoOqizFUnicfU/HkVH00C5lS6g==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr3973560plb.169.1544225411658; 
 Fri, 07 Dec 2018 15:30:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
 by smtp.gmail.com with ESMTPSA id 85sm6360865pfw.17.2018.12.07.15.30.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:30:10 -0800 (PST)
Date: Fri, 7 Dec 2018 15:30:10 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v11 5/8] interconnect: qcom: Add sdm845 interconnect
 provider driver
Message-ID: <20181207233010.GE14307@google.com>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207152917.4862-6-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153022_535253_E2DAD50F 
X-CRM114-Status: GOOD (  16.56  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Georgi,

not a full review, only one thing I just stumbled across:

On Fri, Dec 07, 2018 at 05:29:14PM +0200, Georgi Djakov wrote:
> From: David Dai <daidavid1@codeaurora.org>
> 
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1027 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>
> ...
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 000000000000..f594dd6f500f
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> 
> ...
> 
> +static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
> +{
> +	struct qcom_icc_node *qn;
> +	int ret, i;
> +
> +	bcm->addr = cmd_db_read_addr(bcm->name);
> +	if (!bcm->addr) {
> +		dev_err(dev, "%s could not find RPMh address\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}
> +
> +	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
> +		dev_err(dev, "%s command db missing or partial aux data\n",
> +			bcm->name);
> +		return -EINVAL;
> +	}

cmd_db_read_aux_data_len() is in the process of being removed, see
ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in
cmd_db_read_aux_data()") in arm-soc/for-next

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=ed3cafa79ea756be653d22087c017af95ea78a49

Cheers

Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
