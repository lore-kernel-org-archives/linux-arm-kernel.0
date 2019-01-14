Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF781C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD5920659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pdh4Rt0g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtUOHFqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AfR/coly2q6HkXbuXmvVOrmTFPP/fH3BMdCt2jAWN9A=; b=Pdh4Rt0gE2mawl
	jrt2RmpTf0Oh/eW8YAuhUGbh8/v1GKRZm9MmKg3FLg8HjiDDKZsssvIKZJKa/da3dULy+gVI+8F/j
	H3Q2mhlD4dAkKMkZBNx3ZhbFQr7uJXrdd/aKJERNN2eMWhkudobtqHpISSz2ZcvHrIU1Xbvarttfi
	LIh+8fxgTTNHwbdA8mJvDYQQvlRqCEkeCc1udvTmB7sdXWaMFV++e8Tz5mnXMZZGjUI+OmB/0SJ01
	kB//71uwI1jlLcBGwZDs6uOq+nq0YAoObzUSVTuJPGN56XsJEPMzgD20ymF6MHLJLwn6z6OzMRxg3
	4sfxPu848hqh5vCigPuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0fS-0002Co-W8; Mon, 14 Jan 2019 11:44:35 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0fP-00022p-OD
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 11:44:33 +0000
Received: by mail-vs1-xe44.google.com with SMTP id b74so13407846vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 03:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Uc8FfGJZbh0xIzENuKwM+WoC+uX+Zv7+UWwVqDKbN0I=;
 b=MtUOHFqOy5ZWS70/sWtt0v9CBz5Qo2cQZLU9Z7VQe4j7JUV+h4U8drpgA4Imzcq0Tm
 9pGD16sVKVojC/f8NE9lqgIAEbJx5qMbbOoRip0LfaTmso70gcVVYJsUq+Y4ZLcxoQuD
 RKVqSshytpnaVhO6uG/mStAkLUWWNZPljoRxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uc8FfGJZbh0xIzENuKwM+WoC+uX+Zv7+UWwVqDKbN0I=;
 b=I7xvDrytBJxinSkv81pE5K2dv1xrWMvVAuoUBk6GG0U75eVGjYbJbSowCx3HY70gwf
 nCNwtsKVFt4Vlfif5T5RP7ssq/xExlC9RHsfq/uBwK40wVedN1rDkT6jlURVoi8otnjg
 krWsz/38ns0kfuAHEWG0ZYZsVZ3Bl3iSCFHvYJn2vFzDejOHvTsHB8v9UjOdoaRRHmbc
 r+XztXCwEiW4/eDr3naztiuxLpXKPLIgVoWW4ywBTYsjG8Ku/Wn98i2f4EMD74KBwfN1
 HPDf44Xu324Ptz1NBP9VApfsuxQ7g4EBtPChjRGgJyDni3TJv887RDATlg0K5j46P/8c
 549A==
X-Gm-Message-State: AJcUukegDzG+IWge77wtnLsa6k5e4/KhxKl88jyyS8DZP4omRwyThII+
 MgF90DtGgvUVWnld8dRLjWL3CROJE0druTnjmjedcA==
X-Google-Smtp-Source: ALg8bN5wxbHpVBxLDaPP17LvnvCu8CuP+pCnHAjKOHqvNOrS9fQOngXLgxEPAe5mIFshq61qN0Ijs8amUG7J5LNDhvg=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr10273818vsi.191.1547466270389; 
 Mon, 14 Jan 2019 03:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20181228033323.32308-1-haibo.chen@nxp.com>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jan 2019 12:43:54 +0100
Message-ID: <CAPDyKFrOW5tM7ztKzQ2akp6xvVsX72NAc1zmRzcFnt5Q9YrhtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
To: BOUGH CHEN <haibo.chen@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_034431_794284_51EC28E6 
X-CRM114-Status: GOOD (  12.38  )
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
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 28 Dec 2018 at 04:26, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> Add imx6ull compatible string
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

I also amended the changelog by adding some more information about why
this is needed, according to the comment from Fabio.

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 9201a7d8d7b0..540c65ed9cba 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -15,6 +15,7 @@ Required properties:
>                "fsl,imx6q-usdhc"
>                "fsl,imx6sl-usdhc"
>                "fsl,imx6sx-usdhc"
> +              "fsl,imx6ull-usdhc"
>                "fsl,imx7d-usdhc"
>                "fsl,imx8qxp-usdhc"
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
