Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1362220878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="InEKKMIQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPr0KYsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1362220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H10OIonwMhfFhvr+4fKMH6l2f633EjxpEwa7XPstE/8=; b=InEKKMIQMgnWZb
	erOGORMqvq/AqdWRsHOUO69/B7O3Orav0jl3NduMbf3h06R63zzAmPfqEWHBZ5OVKRGShy8OosBiD
	UxmCIYIPi3gd8VR8BgS2c5gwv/2IDxSHBHDJ5lOKcvyaHjux1hLj3mhGTuV3svZswO483V0wANY7n
	Jq+zLZXnkVqf11C0N6GMOPcgBCWwswbh+2MVYTzN0BnHLBVdnvL+wBLDLEB/2AxZrkQHj7V6kfXML
	8N/B5gMw9WtpL4L8YIvywI3CTrwjSZex4JsIua6EpzEM34AakEEezgmsPbKvjgRgr5jYGrU36F014
	KfAO3feA7wVPiEAp0log==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUc2L-0005H4-Dy; Wed, 05 Dec 2018 18:36:41 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUc2E-0004zQ-Fe
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:36:38 +0000
Received: by mail-ot1-x342.google.com with SMTP id a11so19552404otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WFWOscgui2UZhSuIZ9g7cKCUFmp/L3PC0pkkS2DQfso=;
 b=TPr0KYsyrEVJmo01NwhgeGkDPzOi0vkD1Sstxuno2Esfq3ySCllsdCpe0uvPDcSDuN
 Qlk4o9QWatdQAu3rZf/ysuDXru1seaTkAr5jchMaSPaWiN7mF407aNrPBiLDNGyh24Yq
 1F6Hs+b8IFZu6U1FHt7htc3/A/rgJwLjZvz27ZgS6A1kxm1d31twV/6HD+ViI76keOQJ
 ZbJVzHEa7sM0rvnhwUb1ePAQTOSikQ35mMQp6ckPaHjiKy4dT+b2gxpg5PLSbwcNEAhr
 Ymm4tRvK/ZZsX0mFzbQPJwex6hx+W9bM2xbuYT3do3p4XVfh9jFtQ51V6bQLtsoOWQ2e
 I3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WFWOscgui2UZhSuIZ9g7cKCUFmp/L3PC0pkkS2DQfso=;
 b=icspE7xyeoK5Ty8NuC5vIapGRUg5LZURAFe36/o8bXmLf7Q0D3dq5yaM2y0VXvVCfk
 xMXl1WeJdW0ZfJgn0knkbusOWfx9FvO/Ue+wBPm9PppwoZfZHA/FKtnBgAuRCMLqfr4Y
 9RMll8RrH/QxecNPpuXsC6gMXgT9qWP3wLUSS3/ZMi9ZjV2+068lOaHq06+TAQhE5ZDY
 GfUhjN7Q0RPDG0fn6sNDxx4Z1eNa+VWz6L6lCln3WJsDXT0Rd+IDNCGDluNLF9wzzPDR
 GhkgV8lZAlrbPT8xbVsuK2WKBBILGeepLbNkP/LJ0Ze87QYCIxSLINzzh0vHRZ8lTl6P
 ENwg==
X-Gm-Message-State: AA+aEWa9Ab5lLSmeSdlOkoOIjOskc3DZ68+FFPq5OArLH8XubcQRNixb
 x5u9yKXNT+xLshBBJDSfH+HaAaqp7hqOKCr9gy0=
X-Google-Smtp-Source: AFSGD/W1NTZQmf/NLsy5rmYwnAIyaSg53uxvOgW5kyw8m3O+wy95j3rjBvR2Y5j1BAoPb5N72s4w8kfNIXUx4F665I8=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr16671096oty.203.1544034983687; 
 Wed, 05 Dec 2018 10:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20181205181003.30404-1-marcofrk@gmail.com>
 <20181205181003.30404-3-marcofrk@gmail.com>
In-Reply-To: <20181205181003.30404-3-marcofrk@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 16:36:28 -0200
Message-ID: <CAOMZO5DL3maQTKuB2uE-4hJe+98BkrGG_YHw_5=N6DGD6UfkXQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6qdl: Fix memory node duplication
To: Marco Antonio Franchi <marcofrk@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103635_019212_66CF389C 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: Rob Herring <robh@kernel.org>, Marco Franchi <marco.franchi@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 4:10 PM <marcofrk@gmail.com> wrote:
>
> From: Marco Franchi <marco.franchi@nxp.com>
>
> Boards based on imx6qdl have duplicate memory nodes:
> - One coming from the board device tree file: memory@
> - One coming from the imx6qdl.dtsi file.
>
> Fix the duplication by removing the memory node from
> the imx6qdl.dtsi file and by adding 'device_type = "memory";'
> in the board Device Tree.
>
> Converted using the following command:
> perl -p0777i -e 's/memory\@10000000 \{\n/memory\@10000000 \{\n\t\tdevice_type = \"memory\";\n/m' `find ./arch/arm/boot/dts -name "imx6*"``
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
