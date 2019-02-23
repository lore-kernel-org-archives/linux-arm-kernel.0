Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BDD206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LifmieKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BDD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0jRve5tm4GP9zV7rv7dLaMCcGKUWMFPDP//55M9GFq8=; b=LifmieKimCWySu
	iQXdcnBtRGwP/DZDQ+NIxKyQIadrAoHDHolDUZT7nT0Sp0TYuF9ayd/udTMfBtiVq5bIr6wwTlYIy
	DMN3epbrT7eSZu3ziLUPSjPmbKlGl0NnNsg2NYL3WbHsGgjNquidNowciflHSOqgQt4ktfAuOS10P
	ZVW+HNAoaXIIAPTJ5mK7504cd7/A5ALrSoL8SOI/uqJOVt7Csx5FvnrsQkrkTPXU3SqgpvLxokdmc
	T9SPA2jqmxjC3q7f/KtVoUyL7lpenv2p3bzbGSgOiskZgQAp6BVCFqRM1Uq5Cqg+w5UA8t2EsXSyU
	u5mutJ4uJW39u9hHPUIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKzw-00011C-L0; Sat, 23 Feb 2019 00:16:56 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKzt-00010j-Io
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:16:55 +0000
Received: by mail-ot1-f67.google.com with SMTP id v20so3395506otk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 16:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F8pvHTiqZxkrzj+jeHGL8VNP+pTt1XygpHzuLbyse8U=;
 b=V+FJlcLAKY0q2LbpyapUXiAXmrSVh1oOpTPapm+HLb+gHju0YRAcDadxWjbKK6zaLr
 Uxahf3tkFEd4oWDHwozpUDa86c2TSh8/R1TED6WQ7WFyA+oVV667NnBWaEzz1+w1Xcev
 3uF/88mVDc+jKIndkRO7uIl8yEuOtnjll5qO38/Kcd/gTIm2VCJ4KUX15xzb34sWvwxu
 By8QB6+vLmyfBs/q7yLWczPifkMBDROu5PwQNxVi1oTeTMWM5bkWsM8oWvBALuEWuLOb
 FdfM9I4adfaI+9TwiJUlUYKzr4QOLpJXzhx9mqsnO/Er31l2I4qdrlztdpfIVLNd7A92
 1XGw==
X-Gm-Message-State: AHQUAuYOoIXtAOdYxtBmye4RlqwKZ7JjPewNfaOiSy8ZeYLuaZM/fAHN
 h7tvwr+G4vRLXC96HYGolw==
X-Google-Smtp-Source: AHgI3IZ7ykq6tSp1sxYCkSiTkxCeQO8FV3VpbHXPfdAXtjoc6CEuOBfyqst636PffD3Kdw5r1cPFjg==
X-Received: by 2002:a9d:e8b:: with SMTP id 11mr4413934otj.155.1550881012482;
 Fri, 22 Feb 2019 16:16:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d67sm1252991oig.36.2019.02.22.16.16.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 16:16:51 -0800 (PST)
Date: Fri, 22 Feb 2019 18:16:51 -0600
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Message-ID: <20190223001651.GA22381@bogus>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_161653_620266_E11BF422 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, peppe.cavallaro@st.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 09:28:04AM +0100, Christophe Roullier wrote:
> Add properties to support all Phy config
>  PHY_MODE	(MII,GMII, RMII, RGMII) and in normal, PHY wo crystal (25Mhz),
>  PHY wo crystal (50Mhz), No 125Mhz from PHY config.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> index 1341012..f42dc68 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> @@ -24,9 +24,9 @@ Required properties:
>  	       encompases the glue register, and the offset of the control register.
>  
>  Optional properties:
> -- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
> -- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock
> -	           by RCC

You can't just remove properties.

> +- clock-names:     For MPU family "eth-ck" for PHY without quartz
> +- st,eth_clk_sel (boolean) : set this property in RGMII PHY when you do not want use 125Mhz
> +- st,eth_ref_clk_sel (boolean) :  set this property in RMII mode when you have PHY without crystal 50MHz

s/_/-/

'sel' I assume is short for select, but the naming here and description 
don't really tell me what I'm getting.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
