Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B928C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6A821852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRzIdc5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FjZNKr5WU6Ypr57yZi556csZA8/DWJGFCmFr7iaJlyg=; b=QRzIdc5MSz+bhI
	hd+DdYVG7WS+NqOuZeWckfSLpRfL5qAREi/X/pxNsPmkwI4KH6AOLE4UWqvXPi1jnbb5tDWkPHMHm
	pgg+75icp9GwnYNtorhM2Lergh4MEBfVs/d51lCLK0Ouacx0XyiCyQbit9HFMQu5fC71wt+CSY0fy
	82bm4D45HoSmiOF7I8LgUF4zT6scCnFgb8Zgs3YYsChAJz7sHZ5DUVxWQwtuNlEvMdkJQsITzXzHM
	M1QA+6fwtOw5Q6H9ypkW0zSxbe8ubpphWjL+uvvDvobAR0YCGQQDUfCfCLQfBEGP/r4R1op5PuOMp
	tDMWnLWAyWkYTDdqmiJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGxp-0004bU-Lp; Tue, 18 Dec 2018 15:07:17 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGx3-0003mW-8L
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:06:33 +0000
Received: by mail-oi1-f196.google.com with SMTP id t204so2173415oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hMK+igEy7KsEb+Om4FKItxt2mUoYGrZdXguXLnxgbpA=;
 b=kTvvR73T6q0O2Synz0Svf5JTRiKuya2fB0pKvSVvBt1MiA+wkUQfD+I5JovCxVy8IC
 aEq2eJuWqbLRc3aHfKsBwR7f49IIstKTmtfjRsWKJcpUbUGiIhNaZ2nkvjoMA3HHSWJr
 yviV1jwQgLNstSptUbQjrBtX67NxJin/1HQn4Xv4TuJeAWj9LTPXjljjBx8AfEzU1jHO
 eSLGeenZBexMm+JzHhxEBcZw0XZtXmmklpgq85O0be56JPbR9E56qkFTA3yyV8BbQbCP
 5ZdCfsry4amOa64wwG6mO8xQUD5uw3Xid9dp49xgBR0RyKEapkL8GXhWAxh3HOSz3xdR
 1ItA==
X-Gm-Message-State: AA+aEWYCafJkvEYlOMofa1QoNsdpmUMS02YJVAROc7Zt3j7c063xnF4n
 Onf3s6+euwB9HNaBFWlw9B+wSKk=
X-Google-Smtp-Source: AFSGD/V3zLSMUXN/Y1bhpKJW33svgyTUvdk/HTt4B3v/LG+pAqYLHbzw9dCT2nkvcGXBWKKUeK8Mcg==
X-Received: by 2002:aca:e346:: with SMTP id a67mr8300426oih.81.1545145578505; 
 Tue, 18 Dec 2018 07:06:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 62sm7567725otu.42.2018.12.18.07.06.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:06:17 -0800 (PST)
Date: Tue, 18 Dec 2018 09:06:17 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: stm32:
 Document hwlock properties
Message-ID: <20181218150617.GA26851@bogus>
References: <20181217142215.17493-1-benjamin.gaignard@st.com>
 <20181217142215.17493-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217142215.17493-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070629_732624_DDD3EB54 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jason@lakedaemon.net,
 marc.zyngier@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>, tglx@linutronix.de,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 alexandre.torgue@st.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 15:22:13 +0100, Benjamin Gaignard wrote:
> Add hwlocks as optional property
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
