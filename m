Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B588AC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:18:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810A32087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AiOpp8nZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe/Fv5+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810A32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QSAUPgT1dqVttf8o7RimBs8QC9mAP/QVdAl2y69kByM=; b=AiOpp8nZRgyUTg
	YYZEjsGZA1QfH3fmbMIPTWb7b8ssA08bYUQoH/CxJg+OVgYrkZ+vzT12cgb5ODiTIPCQAhmdNxRou
	QDj0Os1Zw4CsUkJKwBdN94VPQfQw4Vgiz8YMo8KYz+ftvhmIpGU0p9hakZcn1ltrwWSgHPHG8Qp4W
	h1JhzVvA7xqLcTQDhLoQbaf+yzwyKQiV6WIwujpcCW4u9PaKjcGGQ3A9UitiGmHi/+FM7AhNCs+ql
	xWwag3jlTWh4pDdPl3BKoyyFxFK0UuThwht5Qg/X7c7nNDjDC420/iNeN8+HWuXxnI8oIO8rT0KLu
	vxeFch1d8qNE9/BuNVHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjlb-0003xz-Vm; Mon, 04 Feb 2019 19:18:51 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjlZ-0003xI-22
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 19:18:50 +0000
Received: by mail-ed1-x542.google.com with SMTP id x30so915218edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pz91TlzcgTM6YlfZuR56aYR0lcb+9noOvl7XcVJxug8=;
 b=Oe/Fv5+cS9A+/oX6dpP1dkpas5de1KCgVGT3H3dN47CxWulxsnZKOt6FTc4e445W4Z
 1PiYe0o30sir0N9AJMcZWAC/J/8SK1XX+6xcXaSbYQ8mrfC4mKH5VqsXX08P3pHq57nK
 nfw242gY09p8eeYHiMrKE6nZtW5pgvCJwBU1i+smsHwQ5DmribkoZSEmPmuOymTX5Tna
 CNzkrpLba85rQtB3vd8MN+yji9RLjOselCqLDxUUec+xYl6UA0edDy6OpANGAsAoIoXI
 htN8aFragFL1uSommREjg25t1bl2E5PfGpt92AvZfoOFrD1jJu3UTVO9Nvq5j97FZPyT
 w4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pz91TlzcgTM6YlfZuR56aYR0lcb+9noOvl7XcVJxug8=;
 b=Sq1tjf90CaPRueEN/lO2B4G83gW0rloaP5KcD4uVv9g4znZJS0HNIkceXQti0BowGm
 qO/hP5Lc5zLVNAr/CvRQcwlxosiEfyGXzJeq2HDq3DjMuos0Gxi6RcCunNLypJuIV0tF
 IgbqK3d5XOupOcPNJGD9HuyJQS9D9PCqgJkGwSKeeDS/o8svziLBPxFiU67TEjeZyl8H
 TDX+nrBzftMOkT5r0lKPuQVRolyFXa1gbEjKJuQvFdh+OLR+e7INadRuKlRm8tkiTUXO
 YVuqGxHx3Y9LG5X0nmZxxdApfZbLFrApRDdQw8H0cqg4k3p8Bppeb0s4LyKa4GQ90unZ
 kl8A==
X-Gm-Message-State: AHQUAub7QPYKSjR69Ac0yIJRSOe0QLI1uHf+81OqTfm8fcejltjiwSRU
 6QCAwebt6/y5clSFDIH6ErVlXD8GaAWhb+JrENI=
X-Google-Smtp-Source: AHgI3IYsN7jLkmy+DEfRgWIsyOU945j/GyCjycGsRqtml3B++HTCoyWqxlI5Ej1TEmWMAoC/4X2yG2oC+7UfGIzJKOs=
X-Received: by 2002:a50:b356:: with SMTP id r22mr772379edd.164.1549307926462; 
 Mon, 04 Feb 2019 11:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130133005.5732-1-daniel.baluta@nxp.com>
 <AM0PR04MB4211CBB9D46FC6EDB9DA9F1680910@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211CBB9D46FC6EDB9DA9F1680910@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 4 Feb 2019 21:18:35 +0200
Message-ID: <CAEnQRZDjN7z1nC8RSqaQXayz3rfBw6PGC69Knc4izGw62FnDGw@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: imx: Add support to start/stop a CPU
To: Aisheng Dong <aisheng.dong@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_111849_098922_A9166EA5 
X-CRM114-Status: GOOD (  20.21  )
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
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

Hi Shawn,

Care to have a look?

Daniel.

On Thu, Jan 31, 2019 at 10:16 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Daniel Baluta
> > Sent: Wednesday, January 30, 2019 9:30 PM
> > To: shawnguo@kernel.org
> > Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; daniel.baluta@gmail.com; Aisheng Dong
> > <aisheng.dong@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; S.j. Wang <shengjiu.wang@nxp.com>; Daniel
> > Baluta <daniel.baluta@nxp.com>
> > Subject: [PATCH v3] firmware: imx: Add support to start/stop a CPU
> >
> > This is done via RPC call to SCU.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> Regards
> Dong Aisheng
>
> > ---
> > Changes since v2: (as per Aisheng's review)
> >       - rename address with phys_address
> >       - remove unnecessary uint8_t cast
> >       - use 'true' as last parameter of imx_scu_call_rpc to actually
> >       wait for a response from SCU.
> >
> >  drivers/firmware/imx/misc.c           | 38
> > +++++++++++++++++++++++++++
> >  include/linux/firmware/imx/svc/misc.h |  3 +++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c index
> > 97f5424dbac9..4b56a587dacd 100644
> > --- a/drivers/firmware/imx/misc.c
> > +++ b/drivers/firmware/imx/misc.c
> > @@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
> >       u16 resource;
> >  } __packed;
> >
> > +struct imx_sc_msg_req_cpu_start {
> > +     struct imx_sc_rpc_msg hdr;
> > +     u32 address_hi;
> > +     u32 address_lo;
> > +     u16 resource;
> > +     u8 enable;
> > +} __packed;
> > +
> >  struct imx_sc_msg_req_misc_get_ctrl {
> >       struct imx_sc_rpc_msg hdr;
> >       u32 ctrl;
> > @@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc,
> > u32 resource,
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(imx_sc_misc_get_control);
> > +
> > +/*
> > + * This function starts/stops a CPU identified by @resource
> > + *
> > + * @param[in]     ipc         IPC handle
> > + * @param[in]     resource    resource the control is associated with
> > + * @param[in]     enable      true for start, false for stop
> > + * @param[in]     phys_addr   initial instruction address to be executed
> > + *
> > + * @return Returns 0 for success and < 0 for errors.
> > + */
> > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                     bool enable, u64 phys_addr)
> > +{
> > +     struct imx_sc_msg_req_cpu_start msg;
> > +     struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +
> > +     hdr->ver = IMX_SC_RPC_VERSION;
> > +     hdr->svc = IMX_SC_RPC_SVC_PM;
> > +     hdr->func = IMX_SC_PM_FUNC_CPU_START;
> > +     hdr->size = 4;
> > +
> > +     msg.address_hi = phys_addr >> 32;
> > +     msg.address_lo = phys_addr;
> > +     msg.resource = resource;
> > +     msg.enable = enable;
> > +
> > +     return imx_scu_call_rpc(ipc, &msg, true); }
> > +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> > diff --git a/include/linux/firmware/imx/svc/misc.h
> > b/include/linux/firmware/imx/svc/misc.h
> > index e21c49aba92f..031dd4d3c766 100644
> > --- a/include/linux/firmware/imx/svc/misc.h
> > +++ b/include/linux/firmware/imx/svc/misc.h
> > @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32
> > resource,  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> >                           u8 ctrl, u32 *val);
> >
> > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                     bool enable, u64 phys_addr);
> > +
> >  #endif /* _SC_MISC_API_H */
> > --
> > 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
