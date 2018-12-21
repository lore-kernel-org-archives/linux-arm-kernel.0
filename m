Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:25:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4471921905
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bfr81iiL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIfXcROn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4471921905
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8D3n2I2xjr/5ZyhSRWczvQdBSyR3sT51ixjnUiohAp4=; b=bfr81iiL5WwqVT
	wOVoCooU8qHTeGoDFXjZXICMLLasYhQ3H5SvIudAzBF5LeZPkSASH7hviu7bsimDTA4w8tbLFXT5A
	xdeZq25FSlSDQjFI5hAh7PgAR6N3Xv8MGE+HG2iO5UVohSuG4KmWTUbOl2FT2p0zrsTwmb1Ft4nv2
	Pvy/L6YwakUd6f/cO/qAUv9l5opd9ObIRiZCUksRSiT5c8KnUt3qrIf2NUeFZpb975NFg4GfS/s97
	4pzoUObt6GxehSSlPQ7FTNXBWTaRkXtb8zHSSHtPchCbjE4YasrtT/IfKde9FwjDExA3KNcUSGXYo
	9yl8L8DZ2ceU4GILeRQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaAUx-0007pb-A8; Fri, 21 Dec 2018 02:25:11 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaAUt-0006TY-7Q
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 02:25:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id c123so1836351pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=X6F7WHewRmSB+0zYUOGks/Qs3AJ8DVric08tIiEoe54=;
 b=XIfXcROn0Jt/yJJzX9jVnEen3RYkTNPcn16h3neo5cCez7uqraJz8zvNNigm6nsPkt
 6Ee4ZNrmKaTOad12Il5x63wG6qgMfvzRXq4Z/uO8pSFSaibrWXrbsu0LtClYvsgZg67L
 Oy0hGOIwViH6FlU6+BtF23mqzl1hSI7W5GBSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=X6F7WHewRmSB+0zYUOGks/Qs3AJ8DVric08tIiEoe54=;
 b=rJRbkF0ZvcWN4obmYRl1V1oCm1RrY5J0V6mArzaQs/tM5XhDXU7lCG5sF95wdLFIBG
 53Ez1UD5z2hr1txRDKajY0vn9eSYFG+nBnELy/zfaq3jS/6YRgkiIMZQyVNwzkyhNdBl
 py5MElIX9DbZEyPwrhVmEG9A8y+c6abFc0JQNq/2KYBz8uXrPQOkmmaeflj+DbT4pPnD
 c+XHh9e7rZrBl6zw0Z0zzqzoPLgrwv2t5qfWGD3QtJamxeBC0gcr73IC2ovC77b29Bmo
 JuvHYb1/RsWkOIBJX8WIakPTXAJCvFVZ3FcuX5k7ycgQojChcVlYQ3QkyuSlSjfuaorf
 lJkw==
X-Gm-Message-State: AJcUukf4EK201SxVmm4wD9KIE+8W098z6Oi+NOioa5yMH21F4zxF/FoE
 iwidjVUeAIjvICEA5VKdojzyj0Gqfw==
X-Google-Smtp-Source: ALg8bN6fXi2DBsVSwHbHDjv5g5zYgUgkZWuBwJ4lq0k57Z1U7gpLGUQSpyH2ClLEwesWHgkL/fx5hQ==
X-Received: by 2002:a63:4819:: with SMTP id v25mr631328pga.308.1545359095690; 
 Thu, 20 Dec 2018 18:24:55 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:810:d868:55e9:25e8:dbda:255b])
 by smtp.gmail.com with ESMTPSA id l5sm23272380pgp.82.2018.12.20.18.24.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 18:24:54 -0800 (PST)
Date: Fri, 21 Dec 2018 07:54:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20181221022444.GA3233@Mani-XPS-13-9360>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
 <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
 <20181220171244.GA22403@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181220171244.GA22403@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_182507_270677_DDA4158A 
X-CRM114-Status: GOOD (  19.22  )
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
Cc: devicetree@vger.kernel.org, jejb@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, john.stultz@linaro.org,
 liwei213@huawei.com, vinholikatti@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Thu, Dec 20, 2018 at 11:12:44AM -0600, Rob Herring wrote:
> On Fri, Dec 07, 2018 at 11:21:49PM +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> > similar to HI3660 SoC with almost same IPs. Only major difference interms
> 
> s/interms/in terms/
> 

Ack.

> > of UFS is the PHY. HI3670 has 10nm PHY.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > index a48c44817367..a327c1e24365 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > @@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
> >  Required properties:
> >  - compatible        : compatible list, contains one of the following -
> >  					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> > -					host controller present on Hi36xx chipset.
> > +					host controller present on Hi3660 chipset.
> > +					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
> > +					host controller present on Hi3670 chipset.
> 
> From the description, sounds like having "hisilicon,hi3660-ufs" as a 
> fallback would be appropriate?
> 

I don't think so. As per my understanding, fallback should be only used
when it can make the device functional. But in this case,
"hisilicon,hi3660-ufs" will not make the HI3670 UFS functional. So, I
will stick to "hisilicon,hi3670-ufs" only.

> >  - reg               : should contain UFS register address space & UFS SYS CTRL register address,
> >  - interrupt-parent  : interrupt device
> 
> Don't document interrupt-parent. It is implied.
> 

Ack.

Thanks,
Mani

> >  - interrupts        : interrupt number
> > -- 
> > 2.17.1
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
