Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE95B204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DBa8dmxU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/xXy5Tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE95B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=re9IdhRV6AhDnSqWkOOaCFSuFMf6AOWqqV0ZjCXoNCM=; b=DBa8dmxUmiSE3v
	xsjV1Nxqet2CwH7rbAnQlmVytOBkmh6+z7TXP93JA8gAFxLg6XD5yOD7TvG0Fxfk5p4C0JREC2JNP
	xbRtRvVpn8fljoLNKqp03ZeVx9t74JJrHdfLzG+vdXnofBXFyq+jqcRk4Q92wuWzsyOlK2fLHSLnT
	hQNVryeEXQKpOTcppy1QAYCFebKK0Y673O47TMMcvFPkYiYE9KjAizLAYkwS62zNtlX6ueFa2EQMa
	gTMH7rXD/HpyTuuHcHxM1Ajkvi85CS1LJ33H2EcK90uDNHijziYln8ofyxx9mWqyk/ZCgv3/eSYPf
	raVhvu17LXlFyZ+eqfQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj6Zm-0006kG-4q; Mon, 14 Jan 2019 18:03:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj6Zj-0006jF-AR
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 18:03:04 +0000
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80861204EC
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547488979;
 bh=Ev/n5b53GOCLb05qQdtq7PSdDCtXNFlR01DuJETX6ss=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=X/xXy5Tc/x0ttoGw74IeUMOkvHz3VBk4GocsfUWt5ipr3j24vSo3ZD1rJdoSytX+F
 +78P0K8j/A+6QKFV+ZemneCxRchOgQwBDtJE5j1LN0Sztt76H0Bl3RTQWvTdx34iP8
 p/rBb2vNFw8tbwImx6hoM4QkKqsmav1bokx3ePgE=
Received: by mail-qt1-f176.google.com with SMTP id t13so27575596qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 10:02:59 -0800 (PST)
X-Gm-Message-State: AJcUukeM2Fatb8qmDhgrv/6x3gNqxhDbSnf1dv/m5zMtksNvP04cCeoI
 cthkuOlfcmcNM/ee18LJVuTOt3tPTy3/gPMxfg==
X-Google-Smtp-Source: ALg8bN7Vh5+gL2cUGcNomkkzpk/sAGgH5VukCTVPe7m8sXRyyLmwisB1+AFthfa9RhSZcQvi6fCsps/OJh0jaaOBTDA=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr23935497qta.38.1547488978744; 
 Mon, 14 Jan 2019 10:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 14 Jan 2019 12:02:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
Message-ID: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_100303_376667_5322854E 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree binding for Oxalis board in JSON format. While adding
> that, let's fix the description for LS1012A also.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index d34fe0749199..0f30142fe316 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -173,12 +173,13 @@ properties:
>                - fsl,vf610
>                - fsl,vf610m4
>
> -      - description: LS1021A based Boards
> +      - description: LS1012A based Boards

Well, yes that was wrong...

>          items:
>            - enum:
>                - fsl,ls1012a-rdb
>                - fsl,ls1012a-frdm
>                - fsl,ls1012a-qds
> +              - ebs-systart,oxalis

Sort alphabetically.

>            - const: fsl,ls1021a

And this is wrong too.

I you just change it, then we will be missing an entry for LS1021A.
What's the status of that SoC because there is no board dts file? We
should not have .dtsi files in the kernel which don't get built.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
