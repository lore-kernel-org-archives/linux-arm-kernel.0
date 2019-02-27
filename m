Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9001E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="put78HPu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At+BPDG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9001E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6nOv+cXruhGvpE1b7N98Gnh5RLih55i0HQCkv97zF/w=; b=put78HPuAKJr+z
	TqO0SOI9JUKknxRbeLgUae1AhnHPC+eK1DdFAGmRz0JQS83HDlA3gKXHDY6gSL70eswCxwPvOZTPa
	mxfVAERqGpTHfpTy7yL2qI0hFBp7a3hGfoNC530FJPjaJHRFLg7+3E4ASR9SSXku+AINj//j/mBk5
	mZG86mJV0/kuxXVFYP938zH3T3KWMpoWPaAJ48nnwm60Vp2X3QMvGAFde+LLtkKaxqJI6ixaySES0
	Ud4zH00aShkLF3xTN+Z59KUowRkk6DDL4tZeb+Py6mjrUMorRYG7EX4BA1fshbyljHlkKL2rEL140
	XgSvgbuizuuYVjQQ7CJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5Dc-0005QD-Vo; Wed, 27 Feb 2019 19:50:16 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5DY-0005PO-VO
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:50:15 +0000
Received: by mail-ot1-x341.google.com with SMTP id v20so15480179otk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GwU+PO/sAoS8OwKdICAhKM+GXnXwxYJ23F0pqlNkrWU=;
 b=At+BPDG53A0iOt2jKXdGW4NPfn1VkFhiBcVHu5xvNu0AATKLHtQm2EfauWdGaTXKk3
 ZjzUxR/KYCDUDXMRbOHbLvmEeqzdf9fYYIFuZF8UFIqo3N4XVJtGYTbOd/ypMVc8a3Es
 bY0ZdGlTI5eMv2TmXnGDtN4QqmJtqtqrgIvDuv/IypuPIAgtgoz+V8+veDTaePdW9fNm
 y5c1zGmcDxAeiIu6vMGZAg4tGXxbVi09hbJPmYmXijEgDRI38+Vkf06MRmiFUnd9he3r
 vPxPsj+78+ew7Bx47HzvrxcdEjcD0AwcGSeKZdhQf8s1eJgqhGC4QHgv5GSSl0eAjLPv
 oyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GwU+PO/sAoS8OwKdICAhKM+GXnXwxYJ23F0pqlNkrWU=;
 b=UwUYqdhPW6FGwsa6ku6onhRRrQPFNMuw7QgZOifmH4c1fP98q+m8rqC9g9LiNCTw91
 I1wv5kEtQurXxXfyckLzD2s3DhZtVYNowpS46LI770NmtjV2qzI1vkSLJZ9SKCQYPiQb
 ZCO6ijuYrrPEZBsSodxadxbvshXbRl4UQTb08gS6yyBFx9uelX4CQH7W4JaOpdFQ5Qzh
 og65a8hNv9bTRECbzo3DqWBbkKRA6q53SW+73krRgE887j3xwgBLsxLhcksuT2+vlRBI
 SjeDBvlOs4wsZ0DtjFOVU8qofjo2g4ZO9sUYOVlJDFzGJj6LRlUst07hVHOqmjimMjaP
 2T0A==
X-Gm-Message-State: AHQUAuY12Lut5ztkCALe9h6AR3rVUB4nlstmG7QnKbwzzjUUcqZMySOc
 M9KXOXBUiuq7U09AYTuT+jUBbWWfnVimm5nRX0Q=
X-Google-Smtp-Source: APXvYqz9Jgw3g5+1GD5mSQriugqhqBko9lxepiRb2DKF8Ixf9CIZPZUCDM697QOYfLAH84HexkvrL+nTIzHLM1j/nUw=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr3322079otn.203.1551297011061; 
 Wed, 27 Feb 2019 11:50:11 -0800 (PST)
MIME-Version: 1.0
References: <1551261844-23983-1-git-send-email-Anson.Huang@nxp.com>
 <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551261844-23983-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Feb 2019 16:50:00 -0300
Message-ID: <CAOMZO5Css2TvbbQ8cy6EA=2goHHDfDRzP1kVSe_vNaT0DtknLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7ulp: add mmdc support
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_115013_260553_29E80827 
X-CRM114-Status: GOOD (  10.04  )
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

On Wed, Feb 27, 2019 at 7:08 AM Anson Huang <anson.huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index fca6e50..fca4a01 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -286,6 +286,12 @@
>                         status = "disabled";
>                 };
>
> +               mmdc: mmdc@40ab0000 {

Node names should be generic, so:

memory-controller@40ab0000

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
