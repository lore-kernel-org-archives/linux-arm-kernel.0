Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88143C0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:18:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AA521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6rHUeBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AA521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ocX2lZTFp2LtB4U3bt5x7jBwAEXgt6J7DGkZv+Xs/O4=; b=V6rHUeBOh/Wx5D
	PeVvkA1FWQyYJkqTj3Ro9UuDuUrRg+aZDsDg5Z5OJVoKexzIsij7vf+svPcpE0QF22YAVQpM08JNs
	DweQrkg9+7NQJ3aVbzr9FgBcCOgNEK7Iy4/X8sYuhA0JA0refR2QsIa2UIWQxZcjQWuiOrTy/BIrC
	YJcK3pcEP/7cPNNwUjA3Ci1YQ0r5Dj7HKM2/7fG/W0CRMfsUL/32UZ5eWMu3QQdTgWs1uHZlsI8hX
	km0cIU98das8QvG4wKYwRKCVO7JSA297yOuuV7ELIyqoMD3A37QZtf+cZUXH279vuXpXFQKYYB1WA
	EEHiIh+/BJmCZ4C5w8hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1v4-0003oL-3A; Wed, 13 Feb 2019 21:18:14 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1v1-0003ka-2e
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:18:12 +0000
Received: by mail-ot1-f67.google.com with SMTP id w25so6781032otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jQrVYHsBR1uaKP5KKxxDUsandP0CwxMnW0PWdLyJsDs=;
 b=ABNtnJn4DDihsVGHCYhfgH8HIaIN1HCSiN3bdgmkF4CxpXzWvs0kdZ/ppxAQOmTNTK
 qcC/27LborrJrKDdk899dKcIbvK2lv4iYrOWOq14z+eMp5IMMKagbDHM20cQNVvdeQkG
 P7jHgrNBeu3u0Kmj6YWNA5aJwDufhEhZHy+4mRJKXI5QDS5gFzWxg+2hlP91MoBI8bwS
 Tin1x+GM7YKaN8CNybIx7Mic9Eae8sZdrrJWNKu+er72IHBZAew3U5XZ4bDysrjoxw3q
 rJUq8WDUFFRZJcJOJYk8fbVnScvbsdfMZp91AFg+jayUfGESHz4jbiK+6JIG26GZJY4e
 R4xA==
X-Gm-Message-State: AHQUAuZKdo8RlXNgaQ3P6WcMGdtxi6JYHZbdeE4yrK2gYAax5/ynTQt6
 ERRMy+5YHCpCkX6LPEVyBA==
X-Google-Smtp-Source: AHgI3Iacg9lirau8paMoz/IhHP1zO45ukS41Z/dLIGCv1CQKNrlz+lsqYwlXnI/nLxLNKAUVWg78YQ==
X-Received: by 2002:a54:459a:: with SMTP id z26mr134495oib.69.1550092689607;
 Wed, 13 Feb 2019 13:18:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 21sm320929otj.6.2019.02.13.13.18.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:18:08 -0800 (PST)
Date: Wed, 13 Feb 2019 15:18:08 -0600
From: Rob Herring <robh@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm, iproc-nic-i2c"
 compatible string
Message-ID: <20190213211807.GA20560@bogus>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204231554.87666-7-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_131811_120698_A0CA4177 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> index d3a3620b1f06..02e82d20239e 100644
> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>  Required properties:
>  
>  - compatible:
> -    Must be "brcm,iproc-i2c"
> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>  
>  - reg:
>      Define the base and range of the I/O address space that contain the iProc
> @@ -24,6 +24,9 @@ Optional properties:
>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>      polling mode
>  
> +- brcm,ape-hsls-addr-mask:
> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
> +    'APE' co-processor

What's the data type and size? What are valid values?

>  
>  Example:
>  	i2c0: i2c@18008000 {
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
