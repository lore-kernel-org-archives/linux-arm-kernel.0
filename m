Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA15C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F52E217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZwHKOZUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F52E217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GyvtfK6OzMBLs/cT/ZBDR2H6Cwp9i4OfI9CSjdC9e8A=; b=ZwHKOZUPdUB+h1
	IGeAR5g2LZfAlyggQ15nP0OBI0i/WtALZjDyFOQ8vCYRSvmHEugKGYZ8Dd488cprbrbHTwDqyX98m
	DcrU0g4Ocej68DjUZYmyACH4uX1RIu9jj7BC2Q8V9uwKG4HolxkHxycTQZTUKasaDqJKPh3BMx+YS
	WWLRvGxOPrrrHRJqrn4OINhiqeLKpCNkBMS9WXKdwoY++o7LBRiSU6SiQNLcYX75yLbJJLJfKKK6Y
	o1QV+vHHldis7V5w6QKLNZ2w+CP/p3VMPvqWEkbMjt+G72H6FcQgBnhZ8UoKKxH+HnIbuOfNvbLZH
	gQId560SbhNmMqQlkHBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvpDF-0000ZE-MY; Mon, 18 Feb 2019 20:08:25 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvpDB-0000Ym-6y
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:08:22 +0000
Received: by mail-ot1-f65.google.com with SMTP id g1so30280073otj.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 12:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yhKD54KFzTOfa8P48/HBjpVRuzRUrFZL/Y6dFBlM10Y=;
 b=I4ZpFu91JhAH6LvQs/7trC8rWqyaQAGuH1vXikXW+umKIU4a+5LFAw+d1IpEAPpCPx
 5ew5v0WYk2YIweAlzBAJGu4ZC893x9aPxmwZAr2x9xIly+JYjJ1BKrYLoSxR7NMV1j1M
 odaQ7fAJZbcyPjB0dCIJwbb99etJg/aNLW2KxueNLHL7RcIwICY5RZvB4wTsIiXDFsfI
 5W31PBwVD4Vh6CHpJ/FOjQK2+AtOpNP8QY4ZOKsDYB6VIFtupvYzzlElWHhA8Veqz+85
 EjCUjn2Tv5yFN/SC34VmSMj7V4aa3jAoV9LhtEU52ygkDJuMMU06sBVkNbRzQCO9nGVT
 ANbg==
X-Gm-Message-State: AHQUAuYn/KLh3lWRO+aY1oRDU63TUZv1Qm0yv9fbqnICLj6kl4pV1Euw
 C9OC9v2Ywbo1TibVAtOAkw==
X-Google-Smtp-Source: AHgI3Ibc3csWKg+9fThFwFG6QwOJP4Gr6B1wsnSrBNtF9UrbUphfNfi0Kbh8ty6edhhviPbUe9gZhw==
X-Received: by 2002:a9d:3a22:: with SMTP id j31mr15561164otc.238.1550520497666; 
 Mon, 18 Feb 2019 12:08:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s12sm4263255otk.0.2019.02.18.12.08.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:08:17 -0800 (PST)
Date: Mon, 18 Feb 2019 14:08:16 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add HI3670 reset controller
 binding
Message-ID: <20190218200816.GA9606@bogus>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
 <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_120821_254231_F3BA5FDF 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, robh+dt@kernel.org,
 john.stultz@linaro.org, p.zabel@pengutronix.de,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 11:19:54 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> driver is reused for HI3670 SoC and the binding is documented here which
> uses the fallback approach.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
