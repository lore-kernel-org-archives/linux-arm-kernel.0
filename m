Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A32C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B54217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8b9pSG8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldC+wThu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B54217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3SvQI/V036aPSYure/L4+Z+TdVZJ51ojtPYXUs5LhZI=; b=l8b9pSG8AkASsE
	Js4YBG+wotgKx+XzWsidJ3lsSZgfMJFE1W8HAlUW2yPlTz/DYx/sKZNyugl4LI+faGTKIppVaBpCx
	IKEvEPhl4C+PVjEs+bMomO3uVqqk7gsdPzwqyJ8UB22rk3+/YSFuDoCPhcq5B1tmOcvuhLAC+YFY/
	sfEkRDvclC3ZFMxMZ8VxTcYVuOsdxCyHURR76bxfL1URDNhq9qpQrrikk/zOpPHqeV8X935ecwDYz
	DCJAgk1vGV4KcglMR6jBRFy1eUE+Nnoa3tiLe2kopViiPqwcFbCRPsVr582uXRa9MQ6ynuOYiNL4x
	PIA1N6odAqchiyApcvDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5BZ-0003sp-1e; Wed, 27 Feb 2019 19:48:09 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5BV-0003sL-Jb
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:48:06 +0000
Received: by mail-oi1-x244.google.com with SMTP id j135so14486840oib.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fldtQHOifDanDhFlYrzElnvY/w/FO+3Si64v4s151xI=;
 b=ldC+wThusiems77n2S/eNCFK8H5GVsKpTGNDt7XyAeVAlIlxGTxPZJynmbm++33TtM
 q+JemssC1yZ0ojiKPp3TkkH1Gxme5R4gyw8NqeEVoruyd6Y7RtdOG/dFDbZ9RRjIvDUL
 UGKIzFTFLaMD4U9qnFttQM9zjtOq4+KCPLUWbnM2jv01H3il9tdeb5Sh5cnW2G8oALxO
 78y057ZZBZ7xwtqrn4DF1a6+ntIFYJP1Y7hrhteTRplWkO9ICR8XtQ6ImvGlAz+8xE4A
 LWE5o+lJnqt3bSxYk4Oz83y2JtegNgPP8iwk4icYcf6gX68KUtBPPg5B4iNFjsEqp0FT
 ekCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fldtQHOifDanDhFlYrzElnvY/w/FO+3Si64v4s151xI=;
 b=Nq0l10KtLNXg0m7BBsnbTezsj97769pDUe9eXFJwAXiXUm9ZzEvQP4xcVTx6jqo42B
 YDDkIb1zQurKEh8pkEtkfZk/P9+9LH7rRn8bikltNumN7r119aKWkdt1mfBRLhnNZFxi
 JI+OpfaIX3atiU1YBieZQ3NnM1gsRO6uM1yseowW0V7wqNKimEzUesv/OwHHekBSG1xe
 PHXhypC+3ZV1/hS3E8sVQ7qjQF/IzpMkZorczuLLkfenx8YRfKLSyAH/09UzH8h93nck
 1LMkH1RyB/R32Os71nm/BcUeYRe5ZGnEtSONQTSrd6SshI9slRblwK0dlcKwWUWcgNiq
 9Tzw==
X-Gm-Message-State: APjAAAWqCsct34AH+O7uBr8Kw7r2IpYwqyVEChyfxSLjIcd9g7Tixkh0
 TNXeO1vg4ighwUHrilZrhi2Q4DNITV+1aGT6DXc=
X-Google-Smtp-Source: AHgI3IbIQ3i6Q1ipP8ZXVvoVzdH+2F5CKoAo+HBuHc1SUwBvUoh8y9K/ZvDBhlPm19e1rykUom63V1ggknt+WcjZw1E=
X-Received: by 2002:aca:aac7:: with SMTP id t190mr594721oie.43.1551296883878; 
 Wed, 27 Feb 2019 11:48:03 -0800 (PST)
MIME-Version: 1.0
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Feb 2019 16:47:52 -0300
Message-ID: <CAOMZO5BtjCDw4Vd2DpJdw7iamK694EpvGxsVZ7Me_guesoqqaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_114805_648701_56AA4061 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anson,

On Wed, Feb 27, 2019 at 7:08 AM Anson Huang <anson.huang@nxp.com> wrote:

> +Example :
> +       mmdc0: mmdc@21b0000 { /* MMDC0 */

Node names should be generic, so:

memory-controller@21b0000

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
