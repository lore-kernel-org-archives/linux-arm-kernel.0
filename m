Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AF5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3852147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUElsElH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/6xiZvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3852147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RGj9doSbCDN1XD6924zHFfQ7fDxZ5zBtwhLK4/RQ7IQ=; b=AUElsElHQmc8g4
	qMx9kmLisuPBXRLgWjuqMD4EbmwBNMrilUH8Snkw+vt84CC9iYVRmqAMo0N9W+w9cC4QPwKrnw6h+
	kXHglLp9bocDcgA3nHQPj49yafoUF+bU4pck4PS3t95vajXB0gZkiPDnRiTY8wzarNszAwcPZloOX
	WrPJetR+kZBm6AIhbtwxQnYTEVZy4aUUib3OAWrOknhgVMw2NCZP8cKpcugGaa+0Xs4w43RkocDIo
	rhVFl8/yoP3QDh0SXroWZIuVvoxJkLdRZgv4EVbFPTTWV41ufD/D9F4Jt2XxpLQvZDooZnogT00d5
	rk9wR1LjBJ39YYczpxMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhgX-00082f-F6; Thu, 07 Feb 2019 11:17:37 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhgU-00081v-SG
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:17:36 +0000
Received: by mail-pg1-x541.google.com with SMTP id r11so4351026pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q1Cia1wz+5mRCkHMYytkTgvIy7gLgYFs59E2XGQjZCc=;
 b=Y/6xiZvjSdnJhM6j/zki8qil3Ybc/r8bO9vx8LtPIQBMuwcgJWVg17dqthEvGGnbbv
 6v/hBI3qGAEiw02tmnm6d3FTjpa+yQMvzXeE1plc8IsQT4mZVhMf366l+ji79p1Cy3+W
 EtBwsB3sG0wmQzlTX0FDmXsZtRdsIJK847l/GOm4wuYAOJS5riWrS5F1qeJRB2TrCsr/
 Ivzd6bskDEBkexVtUYVO2ah0cMw7EAqBGN1i70aeYz49Rngq7bMPk1wHX/6YkzXK8wQ/
 kDl+LDEHv/4Fw1GlBCSRqVHfbtON5UJcRs9pSfAx7NRaMM4BqvQLTF/XfYGo6W+h9XWR
 nP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q1Cia1wz+5mRCkHMYytkTgvIy7gLgYFs59E2XGQjZCc=;
 b=Bp25YS8lseAbf+eGWWNdgBl02NnMMn582n3HbsUea0lIOuEnuEVeN/ybm/IJXWd3Ri
 2KjLAX2vNFBD8CD/1mmWzuAirD4Zyjb8fORnEgu7jUTj9/6jBICTgcm5zcu9NItL3kF7
 lUszPnXh+9lZ7qUr5jOF5aLg4Sl4J432RwMWcWCyxWtEeRMf5q2cu1jrWPNz9ZCzJuVk
 PnEY/BTam/y7+ixqmVL/4bHQHItLKBbas2GVAVT2WVWvhPYBmHCilunExtmcGIapKgwY
 Q8uHE8ZDmtzzaHpH3OY4GVd5bWs+hwQM0LZDACqtUMjDcilf2NcErgQBw0OcgthTzAJI
 wyjQ==
X-Gm-Message-State: AHQUAuY+XEhwvD54gxBwXPlbUdyz58T2aX8hdsAGVODc8f66iZ1gC8HG
 XGlQ4fPW4KeUPm0nUVFTnRb0
X-Google-Smtp-Source: AHgI3IaTolTllKJ7hnsFOVC1XuKkbhT6P2f8fyuUS5y1sZsQYBC8NV5IIlJx7k/NWQx/Q8ssBCUTkA==
X-Received: by 2002:a63:4858:: with SMTP id x24mr14245500pgk.420.1549538253718; 
 Thu, 07 Feb 2019 03:17:33 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730d:914e:a8b4:2532:ae24:7d86])
 by smtp.gmail.com with ESMTPSA id l8sm21650875pfb.68.2019.02.07.03.17.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 03:17:32 -0800 (PST)
Date: Thu, 7 Feb 2019 16:47:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add HI3670 reset controller
 binding
Message-ID: <20190207111726.GA30269@Mani-XPS-13-9360>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
 <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
 <1549536094.4557.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549536094.4557.8.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_031734_977133_1A2F2F65 
X-CRM114-Status: GOOD (  22.74  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Philipp,

On Thu, Feb 07, 2019 at 11:41:34AM +0100, Philipp Zabel wrote:
> Hi Manivannan,
> 
> On Fri, 2019-02-01 at 21:08 +0530, Manivannan Sadhasivam wrote:
> > HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> > driver is reused for HI3670 SoC and the binding is documented here.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt     | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > index 2bf3344b2a02..5d60ec541331 100644
> > --- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > @@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
> >  controller binding usage.
> >  
> >  The reset controller registers are part of the system-ctl block on
> > -hi3660 SoC.
> > +hi3660 and hi3670 SoCs.
> >  
> >  Required properties:
> > -- compatible: should be
> > +- compatible: should be one of the following:
> >  		 "hisilicon,hi3660-reset"
> > +		 "hisilicon,hi3670-reset"
> 
> If the HI3670 reset controller is compatible to the HI3660 reset
> controller, this could be:
> 
> - compatible: should be one of the following:
>               "hisilicon,hi3660-reset" for HI3660
>               "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
> 
> That way there would be no need to change the driver and it would be
> documented that the two reset controllers are compatible.
> 

Yeah, I thought about the fallback approach initially but was unsure
about which method to adopt. Will use fallback compatible in next
revision.

Thanks,
Mani

> regards
> Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
