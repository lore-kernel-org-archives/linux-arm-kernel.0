Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C34206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R3TEr/yE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TThC2NrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C34206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KYONBNlzwxVcmcmqQBJGq86WMBoekkKnWYrpaTJTOrg=; b=R3TEr/yEE3cI99
	RaRwhrSGqo3EMAe8JQoxZtCdx9OeTgEgKr9QrQ2MGEhdLmcv8RRQ3DZ/suCLxZ6DIZbbvVV3tT0MW
	EGO3huoybRSMxxnxWMpMgrscuouh1H+FiT7s525lmAnaWo/gc8ANlSny3tvFsidBUKTgMaE6Tg1Ms
	1clmjtFlrGq593yEmp3jnHFFsNeUxAhdOa09Vl5YLew9Wsake8tyqESEURTjWRqZhYM5j4KqnRo47
	VGn6a6n+CtESki7iSCI78vXEJuLwRvSOSoMINWDY5nl+YEPr9fIynmBCU5P3EhJqx654AAWl1WXRR
	9xJxcC2WouevoAnCt8CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdZ2-0002q5-Js; Thu, 10 Jan 2019 16:52:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdYs-0002fg-4w
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:52:11 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A297C21783
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547139125;
 bh=z/w9M120qfzoGFhYAoTHYRZwCnuD+5s3xDd2gbRIfto=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TThC2NrFvMV40aB1zN+uIHGOAee8v3vvtij2eyNJ4ebYH4l+Vlwf4AGTZBJ+5LE4G
 5BxHtGTNoWD8gIn+bJm8ObTgpjq17DYGUuiR5Vktc0qqnZndGjRw96k/jVGbJ9rEWt
 x5kS5NRfPCsS0CcATdG2sVT1fiSFEiCvPPdIG9JE=
Received: by mail-qt1-f182.google.com with SMTP id k12so13893618qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 08:52:05 -0800 (PST)
X-Gm-Message-State: AJcUukdI0H1KpTmBvDHzww6g+fNP2HL1+hfJex3P1ZE9NRH+ojhOF4wE
 GRTP5UjnsGRTIRS8qYp8N8I1VymOvA6O2F+xfA==
X-Google-Smtp-Source: ALg8bN4+f7rp46fHMGSP0y+9dv5TXnpKYQTqRQUTW3eUrTnqctsm7/H5/iCmPc7PJKZ6c14eIaKTwTJBeh2Ca5Ph2g4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr10539706qtf.26.1547139124898; 
 Thu, 10 Jan 2019 08:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
 <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 10 Jan 2019 10:51:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-=3s-7=srOOzGwzPAstLnvO2c0MzjaP4sKiuyEyDL8Q@mail.gmail.com>
Message-ID: <CAL_JsqK-=3s-7=srOOzGwzPAstLnvO2c0MzjaP4sKiuyEyDL8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH
 Vendor Prefix
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_085206_685531_BBEA3A3F 
X-CRM114-Status: GOOD (  13.90  )
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

On Thu, Jan 10, 2019 at 2:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add vendor prefix for EBS-SYSTART GmbH.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389508584f48..27a3da1e3a54 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -383,6 +383,7 @@ SUNW        Sun Microsystems, Inc
>  swir   Sierra Wireless
>  syna   Synaptics Inc.
>  synology       Synology, Inc.
> +ebs-systart EBS-SYSTART GmbH

Alphabetical order

>  tbs    TBS Technologies
>  tbs-biometrics Touchless Biometric Systems AG
>  tcg    Trusted Computing Group
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
