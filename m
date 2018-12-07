Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F72C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:40:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7547720837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mvskZZDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7547720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zOHcs+YruPgU13GaE+sUEebKYb5yXtMHnXM9aoBdD9A=; b=mvskZZDj08v6yP
	tD4VE9PFyqVkLPo9JxkQ5lTbDIga60jzoFSq+k9CUKO12q4tayQEOsKbYHuejicDwE1oQZs8XfM5f
	0Khp81LWgJ98RKRLGCSC9720xGr/v2nldTKCpQ8RRCnsM1xdgw+errwURgA21iuzo9SHZRcKwGYTL
	LWFTxQF4zC6br2W+c5SCTv4cxLnEZkp4KZwKAnQV3nFZicfS/sS+SoR+DpuRBxK83UiWisR32m0a0
	wjM3JkKQtevf0RhPs7g4u7s+E+9NCMsBwadaDwDVGZ18Jmw0vhyaUxOYrhCUpqq8906QcmhYvdSJE
	p+bvJCDb5LCJKzms8juA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPjA-0005Lk-BC; Fri, 07 Dec 2018 23:40:12 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPj7-00046X-V5
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:40:11 +0000
Received: by mail-ot1-f65.google.com with SMTP id i20so5434199otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XyOqOJY4BnIwvTKXSdaA9jGeql9SaNqvcpghlgdK8rU=;
 b=fiQlROGD2Y/qd+XjgOsWfA8Z9sP950rOSihSPvXCGu3mvhqsooU+C8d6reYlbJjWo0
 AkeLkfGYKNM6909IK/HBLj7HkDE3mbTWFmVyMk8poyMyuohcsFfHOSZuXPhpsw6jWq5V
 NWow/C4jwXnyu9Oplp5tqapG+SLkU33uYgVfmISm8QRy8fVLRsU1o7NYwfSxbTULxQvj
 3aSzqfP2bsIH8uEcf3SPduq87cY6w27S5W6Ni4/6foHKB5F5zNEvHKEn5lWdKvhiCe9q
 lhGvYZ/URiojL52i8O+uhGX/et06YoO+g2+I+djHqvf9CIP20xidLc8KbnQO5HYCiEPq
 A6Nw==
X-Gm-Message-State: AA+aEWaaCAjRZbRJ8nzpEFXQ5CKc1cQDINdCM0hAoZuCLu0Bv4AkAb6i
 JfKraS7ijEfBD2JETCzTtw==
X-Google-Smtp-Source: AFSGD/U4Y49ev6bzFuxYTMZ2wYZWPqMz0+ZO3IZbz6G0EMcuqJ+vxaNAHMu2Pq0lMS1VQBr9c5chwQ==
X-Received: by 2002:a9d:2015:: with SMTP id n21mr2957154ota.289.1544225998071; 
 Fri, 07 Dec 2018 15:39:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w17sm2187881otk.12.2018.12.07.15.39.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:39:57 -0800 (PST)
Date: Fri, 7 Dec 2018 17:39:56 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Message-ID: <20181207233956.GA13852@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_154010_043213_73DB52F6 
X-CRM114-Status: GOOD (  15.73  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-serial@vger.kernel.org, jslaby@suse.com,
 olof@lixom.net, tglx@linutronix.de, overseas.sales@unisoc.com,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 07:21:00PM +0530, Manivannan Sadhasivam wrote:
> Document RDA Micro RDA8810PL SoC timer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> new file mode 100644
> index 000000000000..06cc2b00be12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> @@ -0,0 +1,21 @@
> +RDA Micro RDA8810PL Timer
> +
> +Required properties:
> +- compatible      :  "rda,8810pl-timer"
> +- reg             :  Offset and length of the register set for the device.
> +- interrupts      :  Should contain the interrupts.

How many?

> +- interrupt-names :  Valid names are: "hwtimer", "ostimer".

It's more than just valid names, but rather must be those 2 strings.

> +                     See ../resource-names.txt
> +
> +Example:
> +
> +		apb@20900000 {
> +			compatible = "simple-bus";
> +			...
> +			timer@10000 {
> +				compatible = "rda,8810pl-timer";
> +				reg = <0x10000 0x1000>;
> +				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +					     <17 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "hwtimer", "ostimer";
> +			};
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
