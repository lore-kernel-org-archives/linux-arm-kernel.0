Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81825C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E700217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UkwKaohB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E700217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WJNmt8Kqar9g/75Hrq2yyVUZXVyZGHKI7QlI9KVgSqU=; b=UkwKaohBwZFY7D
	WelKP0yRFOP4k6SD79M9q9U/csqIQQXrB0aZuFaHIaGWUrul1XTv9aj+2XEUGGfkfJXpssmNjCX8D
	zp/h7nt9Km78jyEiul+jAUmSxskHQ6rcnWGBMU7g98izQl8xpkbhd3fBsz9MCrKt/x1OENI4D4W1q
	NSXYnMqs6HoI7DVahlBb433njLuY/vz3PNbw2ZPk9QH/QCbT9WjXse6BFUeVR9Mti/NIm8spBCmd1
	MwTzpRlymmzmy18tt2TRSDwH7gboTIN2wwhn+SnZRftnl3t+AlpmR4ubnTD9pz1rqCmHbvMTYqLpd
	3TXCyw9hyi8fM5n3VljA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga1sa-0005iV-Ka; Thu, 20 Dec 2018 17:13:00 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga1sX-0005hR-8P
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 17:12:58 +0000
Received: by mail-ot1-f65.google.com with SMTP id i20so2606660otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VTWNz/bdAjLOi56caOeWhwWjyxdwy/hu458gts3psvs=;
 b=PXDtGFF/GF6KxK8orEXNAqTkEKvNbasqMPMt+V29vDxVlyQqamwCWtnQ+ZYeqURdTw
 nhX8WitcsmAnn7YBNgGpr2nHirSDdBB9Aqt3vuSg3PMUuvENq+QsdsSfnGuGIzX/psKQ
 BKTSmZhu1E9D91UZe+sOAvD06Cd6Cr8w145faTaeUFAwGCFzTkHo02tGHVE2q2EEHyJJ
 bynAa7fXBEffOTykPeT8yze5ScUTkvhBCsBbTDhoczy9RJpaMNrXpy/za/ffNfFsQWkl
 biv6jTs2EhisZD7MmKPSEzlcsggAfkWBP/7ioxWW3T7J3m2wJO6enMu/9yCSNlHclmSr
 QQgA==
X-Gm-Message-State: AA+aEWahpqZ49181FEwuN7J8LsUE98z9/psKwjnmq1HnUohs3bNlhe/Q
 7xarD2AWYDVX1tpHsI/mgg==
X-Google-Smtp-Source: AFSGD/X9Y7jiW3SqvSCeoxBjW97zigIndQolgvi3K7GXy7UovibIGVQj+bucvS+BzWvrup/m65Smcw==
X-Received: by 2002:a9d:225:: with SMTP id 34mr20115952otb.224.1545325965947; 
 Thu, 20 Dec 2018 09:12:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n185sm10216814oih.18.2018.12.20.09.12.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 09:12:44 -0800 (PST)
Date: Thu, 20 Dec 2018 11:12:44 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20181220171244.GA22403@bogus>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
 <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_091257_295290_BAC5325A 
X-CRM114-Status: GOOD (  17.08  )
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

On Fri, Dec 07, 2018 at 11:21:49PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> similar to HI3660 SoC with almost same IPs. Only major difference interms

s/interms/in terms/

> of UFS is the PHY. HI3670 has 10nm PHY.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> index a48c44817367..a327c1e24365 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
>  Required properties:
>  - compatible        : compatible list, contains one of the following -
>  					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> -					host controller present on Hi36xx chipset.
> +					host controller present on Hi3660 chipset.
> +					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
> +					host controller present on Hi3670 chipset.

From the description, sounds like having "hisilicon,hi3660-ufs" as a 
fallback would be appropriate?

>  - reg               : should contain UFS register address space & UFS SYS CTRL register address,
>  - interrupt-parent  : interrupt device

Don't document interrupt-parent. It is implied.

>  - interrupts        : interrupt number
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
