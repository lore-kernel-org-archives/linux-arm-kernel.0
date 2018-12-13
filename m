Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3585AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:37:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0798720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2W6kW7T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxGNlYUK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NTaRqw77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0798720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jlHxkHN5eOh2Ha6tN/3n0LYUD5mJiRp+xOoaM1dwmW0=; b=g2W6kW7TPxL8/w
	NUNJtJAbSsC5MXdyGWA1FMBcHhPK2+8Ho97hXUCAslC1ZltokpG1zWECXWxMn/4mdO+UOxm8FuWKa
	g2GeudwWaBTxvcrH6bOKw03XJiL3rJ+tCCNoNU0qErPO2ZcYIQR9Hpk2RjjlkCftBJUwvxtVTsX2Q
	dg/N8WpSVyhIsCf70q9AGx0BvG1f4lcWjL4iFe9KId6Y6gk8aXdM5f5l8mNLXpBHiyOEtdfu0DP37
	jddIsLvJz7zwPWg1i/g7wsyPkVjfN3MjvT/VoCgbt/PYoeAnkQjDGNYnmykGxH5UmnkYP/0Vwwiua
	9/ZKhKG7g1MkNyztKI2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQEw-0003VO-Tz; Thu, 13 Dec 2018 12:37:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQEv-0003VE-DS; Thu, 13 Dec 2018 12:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hT0m26R4vKY2hSuvgd9syT4EEIE8+/YSCvxwL6QL8B4=; b=KxGNlYUK0YmmffbRSczsZwi+F
 HlelBjYjUuX3NglaJoV/AWTBlLL+0kXvl/bUOS21dThKRwqujtMJj74m1tMCzjBU1gorn3O8TutLv
 LQ7oIydQ4+pXuIbSx4rnI1wdQSXNsl9uTexcEnNEet2PyM3X7ga1a85H/O5h4nKcUdvl4Vfu41Fch
 pLy3/lQX1PGrZQitV7SZwHI3joeMN9ZCRQ/HbuMzZv3mIabvlbhSCfdu3a+ZWgqAn6Vb04mJDXZPr
 IQ+z8BIe/ZLxzK4u/lFTqP+pxlQ9RtpO4aI8WG5SEGqJpwyHM0Wz8F8hgP0w8S2SjpvSB8G7begIZ
 2cfu4/Jxw==;
Received: from vps0.lunn.ch ([185.16.172.187])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQEs-0007nE-NP; Thu, 13 Dec 2018 12:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=hT0m26R4vKY2hSuvgd9syT4EEIE8+/YSCvxwL6QL8B4=; 
 b=NTaRqw77Qmr0rEnqKLjduHMMGWxPGXkgI1/a+rNtD7XW1s8oMe0RQ6U7MsGjUITrn9+RauUdo8nkDbCDYzpVInKy8wkEWrP0FD7j4AW8lcSwEvA2AmagbCcbYkf+yZJCvtr7jLiIUicnbfwwDGCKZKUkkv46jnUIeCQWkSuDuTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gXQEc-0002u0-Jh; Thu, 13 Dec 2018 13:36:58 +0100
Date: Thu, 13 Dec 2018 13:36:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Biao Huang <biao.huang@mediatek.com>
Subject: Re: [v7, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181213123658.GG1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_123714_794649_EE33DC99 
X-CRM114-Status: UNSURE (   7.97  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 netdev@vger.kernel.org, liguo.zhang@mediatek.com, joabreu@synopsys.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 yt.shen@mediatek.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +Both delay properties need to be a multiple of 170 for fine-tune rgmii,
> +range 0~31*170.
> +Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
> +range 0~31*550.
> +Both delay properties need to be a multiple of 550 for mii/rmii,
> +range 0~31*550.

You see "need to be" here, but the driver does not care. It will round
down. Please either make the driver check, or change the text to
rather say it will round down.

       Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
