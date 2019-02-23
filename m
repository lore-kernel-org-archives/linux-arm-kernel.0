Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:19:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89357206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JyoTK559"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89357206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+2G84nodOFMrz+FY3w0z2JWUF14uuApTSa3jP4EZUk=; b=JyoTK559M2DS/3
	FgpxOao/JzLDGVJqDelrrnOiqJT9ulOVTO1RYWB421Z6pQZ+MwhUT3MN/uvNeiFeR3O11/mBZ/0KZ
	RgXqtX6l7vLcCZVxOgTM3IdGQj6pz4JIkfgX0OQBofcs8GPVPYNLNlBn6+pg28QA8/qMgSmgPetUS
	YfRfT+TJWBOC1gJkauSbwfhiP+8DFv8St6PXLQKY5Ym5zAR3lfRtu3cTwCotaoeFPbeamepCpqOz5
	H3cv7IMHfbvD58QhokueGTGxzmhqWYRMw9RwUcHD7Qys273RGSpUCCzuilx1pKyYwwRQZ90MIS5L4
	xhCg8odIHiT4nq3Envxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxL21-0001Pr-DR; Sat, 23 Feb 2019 00:19:05 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxL1z-0001PS-4v
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:19:04 +0000
Received: by mail-oi1-f196.google.com with SMTP id a81so3109456oii.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 16:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5jQBLpjkwgZ8uBCvuca4O9cQ1tXOhWWETW7U2gawY6I=;
 b=hO8OV2vjeereDav73wGFQBTS6ypdgr7wfHRts+YAB4irTPQv7EgcbaXmRYXrQwFf9+
 pIzA5boZ8viuMrVrY8acSur/J5bkMQ9TGpnliHVIr5Z6mUhQjMvVGjcckC7l9VJBzckW
 b06y5sKf2RVYGSZ9WKuXgHX6ffyNU7WTt2jrSwUwktliEKdUi+8EInx6vZExj/H/pYUH
 PG88DZuSTi5hwJO++akXqqHKL/P6YzBRgfDyKDoMzZDwzr9qVYRA2Q8kyRMIuYDu9vjI
 hTMv23YNEA/NojJ/bkk9k6QfD+NPCMGOczeV9thVcfrXLZHJkP2NZQ5vGMPhipIr2rlg
 GOMQ==
X-Gm-Message-State: AHQUAuZynn4NTpsg+F3M1JH3yF7dV8Gnvmm951JqC+KB6dcGReXEjk8e
 txH6MRcBW+pyynbCWalPrw==
X-Google-Smtp-Source: AHgI3IahrTjXgi23GLN8uwF4nfk7uwbH1B/sjY2AzOvkskMxs5MgIiuxY+82ViUqSqmwit2hQE8S2Q==
X-Received: by 2002:aca:cf93:: with SMTP id f141mr4293589oig.130.1550881142331; 
 Fri, 22 Feb 2019 16:19:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p8sm1437015otf.53.2019.02.22.16.19.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 16:19:01 -0800 (PST)
Date: Fri, 22 Feb 2019 18:19:01 -0600
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH V2 6/8] dt-bindings: net: stmmac: add syscfg clock property
Message-ID: <20190223001901.GA4107@bogus>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-7-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550824089-19961-7-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_161903_186985_7FB514CE 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, alexandre.torgue@st.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org, christophe.roullier@st.com,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 joabreu@synopsys.com, andrew@lunn.ch, mcoquelin.stm32@gmail.com,
 peppe.cavallaro@st.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 09:28:07 +0100, Christophe Roullier wrote:
> Need syscfg clock for MCU family in case bootloader does not
> activate it.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
