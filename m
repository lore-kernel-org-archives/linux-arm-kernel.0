Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78552070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tF3Suo3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78552070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lFfvZI4N0CPKmNVrAA7kYLdpywAytLegL4D3AFHVu/s=; b=tF3Suo3wtdpvJU
	aM5ee8PN9Vj2FvPFhrRE2R2q33atILfcYRG6APhjxWkJ804RqWwGsTZCGDwc1TufoM3K/c6aclgzr
	9yH681FwIczIoBw6CXJUVZrY/72UcIZYrV3c5jQG1dsLCHqlxwv2FH3eRySi0LtO/3T+iAJ+h7w5e
	rT/4M4SfuDBn5IqJD4fJwoe7Yb779pZ6f7UcR7SoWETSuWMVvVAnOKR9Zofd+nJieRpmexq1BY+ou
	f3u4lBuqNOAHjTzwbKlZjn40gdkMcoLGHCK8BJxiJscEE8MXcx5jCkbHr6HPmzDmNoTYT0PubeiPk
	Kjma2DVfx9nDecmQO9aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGmG-0001dX-Qs; Fri, 22 Feb 2019 19:46:32 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGmC-0001a1-Kn
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:46:30 +0000
Received: by mail-oi1-f194.google.com with SMTP id z14so2679468oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g/66mCBt5iuS4DHcvmT7yW3xaXm9CqK0ZEHHhvk1QgM=;
 b=cjl6oJauu+AAWY3+3wBvY49xPsLTXOKSKJTit+/n9N7VdMdh+01s3Aq05U4p3P40Cz
 BrKduSXlGjd67Adbk5lYMLSYOKTEGpJDfgJ47LI6M0e7lbZfs8Tl9O1TplExMKsdCKr0
 piZZ1lalJh5If2/tdT4Ox1ecB/y/7b8AX2DqEuOM/534sQCL0wNCB2DtP3TrVRdMcdLg
 npQ88DUQy4tlWlGG7hjWj+pyenoXptrGRudc8Tp44PIK3FpIO53EiQvZ7T/+U2Ijjrk8
 uZeQ4ouDV1RsnFo0Eggy7ue5UOlN+BbKbWKkTnA7v7D6eUD+6umQBkbnyLPcHdIXuSy3
 0GGw==
X-Gm-Message-State: AHQUAubyssyLdg0f4JU31mxNtoiKENAQhljwhkQ1bN1Utxb268Un/9Cf
 5Cb8+Kg8fd6CcPLQlakc2g==
X-Google-Smtp-Source: AHgI3IZJqrXJalFuAnhjmqzlj7jHBWFqqRuWJoIe6WXHuUn7clHWViMEWvSw1izp8MYJPAsuB0nVXw==
X-Received: by 2002:aca:35c1:: with SMTP id c184mr2103764oia.39.1550864787562; 
 Fri, 22 Feb 2019 11:46:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j1sm886053otl.43.2019.02.22.11.46.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 11:46:26 -0800 (PST)
Date: Fri, 22 Feb 2019 13:46:26 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: imx: remove unused resources from
 scu resource table
Message-ID: <20190222194626.GA13280@bogus>
References: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_114628_763745_EF8B1131 
X-CRM114-Status: GOOD (  14.69  )
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
 Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 02:35:02PM +0000, Anson Huang wrote:
> Removes below resources which were defined during
> pre-silicon phase and the real silicons do NOT have
> them, they have never been used, latest system
> controller firmware also removed them:
> 
> 	IMX_SC_R_DC_0_CAPTURE0
> 	IMX_SC_R_DC_0_CAPTURE1
> 	IMX_SC_R_DC_0_INTEGRAL0
> 	IMX_SC_R_DC_0_INTEGRAL1
> 	IMX_SC_R_DC_0_FRAC1
> 	IMX_SC_R_DC_1_CAPTURE0
> 	IMX_SC_R_DC_1_CAPTURE1
> 	IMX_SC_R_DC_1_INTEGRAL0
> 	IMX_SC_R_DC_1_INTEGRAL1
> 	IMX_SC_R_DC_1_FRAC1
> 	IMX_SC_R_GPU_3_PID0
> 	IMX_SC_R_M4_0_SIM
> 	IMX_SC_R_M4_0_WDOG
> 	IMX_SC_R_M4_1_SIM
> 	IMX_SC_R_M4_1_WDOG
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes since V2, just separate the patch to 2, 1 patch to remove resources and the other is to add new
> resources.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> index 4481f2d..32cce37 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -36,15 +36,15 @@
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> -#define IMX_SC_R_DC_0_CAPTURE0		23
> -#define IMX_SC_R_DC_0_CAPTURE1		24
> +#define IMX_SC_R_UNUSED19		23
> +#define IMX_SC_R_UNUSED5		24

If unused, don't define them.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
