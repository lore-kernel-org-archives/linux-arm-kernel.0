Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D96C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:46:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F2620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWNyfGmJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDM2v5pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F2620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O1wHmkeJd4luRipXdoY3c0b/8/kUkl3ewBBz/7winvQ=; b=JWNyfGmJeBl9uL
	rFa0Go/d4CEC4p69WIuqQ2cp4AI/1W60BT+b+CdPLjCwBqEO7owHXTfll3FgnLNjlg5lYqHE57U6+
	Zj6KjU8wlIA+cbUXOOMgS2VjXvhHVnONZfWcjGCB/hZMq3qziOyKaptPA4kmvAvBkAiSKOLH0eOhO
	V3y5HCWO6E8aLtjdlQi9tgJWr048dDHayHw7NKXKEmSrGjyXJiMhAjFj4hAYHe4VyOkJk8ERa1qan
	8Ez75e+Eu8kop1KijiWocxF41WCNQYUskpQgUj8N3aRYFGwz38tBBfh8TaHTyYYD1DEcrXOAvuhMo
	4rL/cR8uu5srY+VJldhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopGU-0004Sy-M2; Wed, 30 Jan 2019 12:46:50 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopGR-0004SW-Gb
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:46:49 +0000
Received: by mail-io1-xd42.google.com with SMTP id t24so19307339ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mzr4ARbu1TjAJHS3g9jhoTSUIRon+Ua3EZgbCU4NmpM=;
 b=GDM2v5pMEse2iQm6bSsuV5UVIP0VjgRMA6ramkeol82YtrVdtd4Par+3h+hCvbrVzw
 1DV4uxTgUAzZZ2tuMzI/B673fLbs6mWkA5r0byaLmHwtMOgqty7/s/X5Wi/2YPH054i1
 QcbixkX+aEwWjAcSoRHbDhAdr7fON+Ld2lf3Zq0CGQRWC8WCBJVQHv2+yGuQJ7LLogZ5
 xAArSfC1hJwEf6cQ/JlbEWT519L2w7kmn0N36Stmo0Oe8c6vVnyGRTL73UMLYH5hkOVM
 fMJXkIYEWkS4ajs6VF+fmLVeW4cypQjXQHAfke1yKJOX5i5yEaho2RD3tcc6mT5truDw
 gFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mzr4ARbu1TjAJHS3g9jhoTSUIRon+Ua3EZgbCU4NmpM=;
 b=ReL4WBiNtMBM8Xt1ydxSYUZu9yUVVzX3S48JwA57Pst111mXtkv71dVpAh7sjR8jBy
 KOWqQ8V9QXdq0zs8tF8zAktAvXc04mr6Sc4vI+jJXE+eiqSGRXMJZ1cEP7buGV+3qf+t
 R+AwNPL946py0UE+oiaFYKiwhjdGUHBaX3vGNSbBz0HVZl9jUS8iCPh1k4pLOFBwvAKv
 LTWoST+Et2xtBHyIceWgIggdJa04l8nFf7IfO6r7AvIFdSiuTglkm/X7jWsGw3r9XN0C
 AmF6DCvpOTrvyM53nFMiLF20rQiNfDG0W37Wj4xhH/ne87DrFcr/kKJ2sP11PcvMAGzQ
 2kNw==
X-Gm-Message-State: AHQUAuZoBc/p9lU595jBUecDvybLzByWM0UP2h7IS1SqulGYBju3B24G
 UIygZpDVU91YYdhbhD9tesU/gFFgK7WasB5TZos=
X-Google-Smtp-Source: AHgI3Ia2MHeEdqbgKMaIi6axve2Mh8Pu5dfNmgDGM7u3sNA0XqCauHSh9mPjAGD8nYLdiGMG0WWXfiFcrcnOlM0EIdE=
X-Received: by 2002:a5e:8517:: with SMTP id i23mr15184935ioj.28.1548852406261; 
 Wed, 30 Jan 2019 04:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130095749.8952-1-daniel.baluta@nxp.com>
In-Reply-To: <20190130095749.8952-1-daniel.baluta@nxp.com>
From: Dong Aisheng <dongas86@gmail.com>
Date: Wed, 30 Jan 2019 20:46:35 +0800
Message-ID: <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_044647_575875_B8A500D9 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 5:59 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> This is done via RPC call to SCU.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
>         - remove unused variable ret
>         - add documentation for imx_sc_pm_cpu_start function
>
>  drivers/firmware/imx/misc.c           | 38 +++++++++++++++++++++++++++
>  include/linux/firmware/imx/svc/misc.h |  3 +++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
> index 97f5424dbac9..f511d6f624fd 100644
> --- a/drivers/firmware/imx/misc.c
> +++ b/drivers/firmware/imx/misc.c
> @@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
>         u16 resource;
>  } __packed;
>
> +struct imx_sc_msg_req_cpu_start {
> +       struct imx_sc_rpc_msg hdr;
> +       u32 address_hi;
> +       u32 address_lo;
> +       u16 resource;
> +       u8 enable;
> +} __packed;
> +
>  struct imx_sc_msg_req_misc_get_ctrl {
>         struct imx_sc_rpc_msg hdr;
>         u32 ctrl;
> @@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
>         return 0;
>  }
>  EXPORT_SYMBOL(imx_sc_misc_get_control);
> +
> +/*
> + * This function starts/stops a CPU identified by @resource
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[in]     enable      true for start, false for stop
> + * @param[out]    address     initial instruction address to be executed
> + *
> + * @return Returns 0 for success and < 0 for errors.
> + */
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +                       bool enable, u64 address)
> +{
> +       struct imx_sc_msg_req_cpu_start msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;

pls drop the unneccesary unit8_t

> +       hdr->size = 4;
> +
> +       msg.address_hi = address >> 32;
> +       msg.address_lo = address;
> +       msg.resource = resource;
> +       msg.enable = enable;
> +
> +       return imx_scu_call_rpc(ipc, &msg, false);

s/false/true

> +}
> +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
> index e21c49aba92f..c03bf2a23add 100644
> --- a/include/linux/firmware/imx/svc/misc.h
> +++ b/include/linux/firmware/imx/svc/misc.h
> @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
>  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
>                             u8 ctrl, u32 *val);
>
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +                       bool enable, u64 address);

Nitpick: phy_addr

Otherwise, looks good to me.

Regards
Dong Aisheng

> +
>  #endif /* _SC_MISC_API_H */
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
