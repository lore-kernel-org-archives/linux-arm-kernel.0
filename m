Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C0920873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pl+SnjT/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM5quWca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C0920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lLPyH6pLWJkSFGPuccS9P/+M34Qq7kL7g5qOl7qazUY=; b=Pl+SnjT/3EbbGP
	TzwGoCCfEgwwy1JlnVSnBefNgJ++MgHdAGKnMS9TLmR/NkFTeNAk+XuRMoA5v/2IVoUSL7L/UsgDV
	xjetK5HMEC4BIfWMYWjHIVB2sacR7ba/sg95KzfUKB0k68CENPKv4DYbGCXTSLBD6b09DJLcujLeV
	LphyXdzVjJITNWiCNcaNgRiJXJEi/MFQjcP/bxYN+E/QBepni//2KVZ1j+jQKOY0DSXl7gN0XUSXP
	oXeYWstAQRnWCrAADGrd6f358MaJdsu3JzVA1wHyw8GDSQvszgyUkqH0pbsbfb+BeMUa9SjTJYRaM
	w9PGybl16T2CA0QKC2Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkJ3Z-00005K-RH; Fri, 18 Jan 2019 01:34:49 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJ3W-0008WP-Cc
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 01:34:47 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so3004445wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 17:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4NXApdb4VZkR1BpezAsKTsF0j6KwZn7E2ruj2CswNGs=;
 b=aM5quWca8sv9RgLeiN6JxSZgvinlsuxMxpngbYCFswvivEzXVWv7XaxGKJNCSahxXS
 aJTzzu0Xe5O0ELsESOzL00IxDLM/jny5imPiwr8PG6p0569c9NIQHYIozbPfbE5aDzn2
 V9Ny7O1ii/PHaYc1VAfR0v7INsTPsb3DbovMO7a8Wkk3gwzuVfzlJC51f5OzXAZhb7zK
 EKUA6hua5Fybii7Yb6A0e7GNnPCCMRClkAKUjC9EHWLR/USm+fmL81uIR9ePSSnyBxEP
 r+D+EiJE8rIkvFRRzAJUsDS77UeRmem/WRJHuJ7sdGXLxYmOTQRXf+hlpzTp9367IHLC
 4f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4NXApdb4VZkR1BpezAsKTsF0j6KwZn7E2ruj2CswNGs=;
 b=JeqktMy+NU4UPYheUc8wHAobI/dhpBUj/20uLhEkTui5qwdWCMIgnG4esCtku7SsYS
 dkxLqEJ2xWRWrTCmmtvatk7JiyOeL9guu5ds6Y5GAdGLv5qHEJ7y/lu72ALb1ZmaE5V+
 cCatj2qofaHAqkYUlhdO4mkZDb6k5RCUvhtbNdALb5ZzNXtecbB2P4ev7RAIuTVuUfpS
 oHb4CcTFKND4S6n65MkN1PZay/J50SOgMn72odPQ9al9dthTvfK+7prtKTjimUrrOAUP
 E2Z1q/Z18ItuRJb+hldtdEtqBN57ynxHl06RCtwzmOHU7p8MZ3tYktzcTUYGLgiPIhHs
 aukw==
X-Gm-Message-State: AJcUukfF43NksnDXZ3nyLn7ZA9/4kpO2YvCX/+r+Ok0NRQprVdUT2W6a
 WVF/xktfWAPDxK+rqKQnrL0=
X-Google-Smtp-Source: ALg8bN7qeOATWvmoh+sJVuTYaCTP5z4hYkjp/n5ojBSBGKwWibigxCVoyhz5NtTQX2XWI4eNt7kPIg==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr14489333wmg.22.1547775278775; 
 Thu, 17 Jan 2019 17:34:38 -0800 (PST)
Received: from localhost (83-215-98-136.stmi.dyn.salzburg-online.at.
 [83.215.98.136])
 by smtp.gmail.com with ESMTPSA id v132sm42659333wme.20.2019.01.17.17.34.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 17:34:37 -0800 (PST)
Date: Thu, 17 Jan 2019 17:34:34 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v2, 3/5] dt-binding: ptp_qoriq: document "fsl,extts-fifo"
 property
Message-ID: <20190118013434.qwuiqi5iwo5gw2nk@localhost>
References: <20190117014936.48117-1-yangbo.lu@nxp.com>
 <20190117014936.48117-4-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117014936.48117-4-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_173446_431199_8542FFC7 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 09:49:34AM +0800, Yangbo Lu wrote:
> Documented "fsl,extts-fifo" property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Modified binding description.
> ---
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
> index c5d0e79..101fe5f 100644
> --- a/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
> +++ b/Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
> @@ -17,6 +17,7 @@ Clock Properties:
>    - fsl,tmr-fiper1   Fixed interval period pulse generator.
>    - fsl,tmr-fiper2   Fixed interval period pulse generator.
>    - fsl,max-adj      Maximum frequency adjustment in parts per billion.
> +  - fsl,extts-fifo   Required if hardware uses external trigger stamp FIFO.

Does this take a Boolean value?  Please explain the semantics.

Thanks,
Richard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
