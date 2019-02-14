Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB91C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF70A2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1qwx5j6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zQh6uNDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hh7TmjpJYR41gpj4RuvpOj8F0uJ4RNdHfAXqbpEbSFE=; b=d1qwx5j65cNmkQ
	uW9RuPXttn8+eQyf5mrgU95gp0iJ9aaa8LlBoX/UGlXAb9ZKsZMrWTrDCS9P7HrQual7CtoFBuH4c
	Uliypf91gWHxReVEihjW0LDvaKbOvjRuT8bTKuDZ7Ug2C427DVsWxPJXYthW3nQb2/Y6q3DhEWBRb
	9bBWqUiTJ/1h0nn1L7XB8ZXocAVS211520xbBUuKvo1GRlAZw0MWPB/SpxoOaubnnJPjkEwAmBmEy
	iWkMhIq7gn7N8ECpTx8BidwsTcmL+m16fJ/Ia1csq1o4C0noqgCUdF5iEEldySrLZ8sxPHUbdqRtH
	8GBMRbrB0OEEibfy/nIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHG3-0000pJ-D1; Thu, 14 Feb 2019 13:40:55 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHG0-0000oK-3l
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:40:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dFkiC3dfv0iwknkOldbJAOIn/enUrVcnD3etEIIX/EQ=; b=zQh6uNDhF/TVBubu+BQxvQRcJ7
 qp1M14V4unCvoMEatFy6FINQ4eLL2RSRkXNty9wrhg3vfwwYPBKsZqq+x9x+REqhIud1cGKJEVl9V
 SDd2Ox6W40hitF8COVAHVrdAL/d6LnvCEegO8nQbNwvYdJoW2eldU+8+81/47CBphx4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1guHFo-0001g1-84; Thu, 14 Feb 2019 14:40:40 +0100
Date: Thu, 14 Feb 2019 14:40:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH  2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Message-ID: <20190214134040.GA5699@lunn.ch>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_054052_302358_3CCC95B2 
X-CRM114-Status: UNSURE (   8.39  )
X-CRM114-Notice: Please train this message.
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
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, peppe.cavallaro@st.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

 On Thu, Feb 14, 2019 at 07:45:57AM +0100, Christophe Roullier wrote:
> @@ -131,19 +185,19 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII:
>  		val = SYSCFG_PMCR_ETH_SEL_RGMII;
> -		if (dwmac->int_phyclk)
> +		if (dwmac->eth_clk_sel_reg)
>  			val |= SYSCFG_PMCR_ETH_CLK_SEL;
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
>  		break;

Hi Christophe

This code should handle all 4 PHY_INTERFACE_MODE_RGMII* values.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
