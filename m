Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80714C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D1C20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h5WdAX7b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qMy6pf2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D1C20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cdhe5WzVO5CXVL/2f2n97NUn9k5vfIdk57Sk8Lr0TVI=; b=h5WdAX7bmlvHJz
	izImIFjt6RUPw+S8/9kEw/48nGovTehwY4RAzDp5q7BxSWpHYH7f4jG0Kcbnv8EqmfxZ/+lk7d5+G
	Pn1UTRomxoxKUhBjdrwi+z3PJx+msaPjEDzg7EARS7enL/QY5mX8F/NPL8vkdAE6ZOY6XDKs2z8yR
	AaKpDsp2g1Sl9bc51YS7tNTp5HVrmaTb9X+vHLyj0GyELrV57AMvotsYwsQMLsMF/s0rTQr+wLLXY
	F7WiXpsvqPOS8we5XGUa42VrBVnj8dN7VfrjStevZy40iLP2CjTNZ2mCIPJLtdLO1G98aNgehjoIW
	nPCMQLZeXfpvsyyWaRuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEsT-0007qm-KJ; Fri, 22 Feb 2019 17:44:49 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEsQ-0007pC-BX
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xtaqdMrkSnRisdv1S4SungaMmKyG1cSHneWpykJPtQM=; b=qMy6pf2DnXW21TicHwmc3M1qKm
 m+HYr1z6PSXfHjfKOGQboRihaOkzcmkOZWZ4adinHd0cDrdKezc/YuRVgeO2AqfjqhHYFidX7xu8j
 aJ0gQfadsYgLCFBtkW3PxoC77jldDh7WH9fVf9+CUb7loCwkQc5nro0LPR1EjgRfjLCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gxEsF-0000vg-PS; Fri, 22 Feb 2019 18:44:35 +0100
Date: Fri, 22 Feb 2019 18:44:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next v3 3/4] enetc: Add ENETC PF level external MDIO
 support
Message-ID: <20190222174435.GL5894@lunn.ch>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
 <1550847859-17346-4-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550847859-17346-4-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_094446_545076_6B86D053 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 05:04:18PM +0200, Claudiu Manoil wrote:
> Each ENETC PF has its own MDIO interface, the corresponding
> MDIO registers are mapped in the ENETC's Port register block.
> The current patch adds a driver for these PF level MDIO buses,
> so that each PF can manage directly its own external link.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
