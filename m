Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:51:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493E72175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O/4NRrq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493E72175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LpCXdGNLxAsjPt5C6RarUDTTNf3fF2aECxPYPPEbzzU=; b=O/4NRrq0mmGjUk
	52SRFQZos8THsfz1XcS4aK2T1XN52Qv9L+W8EzTMQMxBC+VRxCiUYw6YNFnmWO//3mbx5fjVVr56e
	ofGG582xI833xDCc06kTniLRnWDlqO5SavbsZED68LWXszOOY1hu3M3/jS27LduGiMHH2/9cP/svO
	O2GsE5FLw+WqGbC/62fTaSHQcv/IxvMWccSkt1S5RfOu3mkxis2wsNji0OWyKnNVpYDWTt6NsGRBp
	n/E2NEwowV33UfuGZJl2GR8GLFTKcIhSCd8Ynr0H0PXnpn3qkz6uziss1mOr8jGKeByKSwYwlO8Wf
	0/kPEmN8I6BzVYP8T/Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhSe-0002nk-Fi; Mon, 04 Feb 2019 16:51:08 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhSb-0002nC-9h
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:51:06 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DF864108B84EE;
 Mon,  4 Feb 2019 08:50:58 -0800 (PST)
Date: Mon, 04 Feb 2019 08:50:56 -0800 (PST)
Message-Id: <20190204.085056.439064547458115258.davem@davemloft.net>
To: pankaj.bansal@nxp.com
Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190204141641.18272-1-pankaj.bansal@nxp.com>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Mon, 04 Feb 2019 08:50:59 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_085105_336716_7F3BB86F 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Pankaj Bansal <pankaj.bansal@nxp.com>
Date: Mon, 4 Feb 2019 08:51:57 +0000

> The two external MDIO buses used to communicate with phy devices that are
> external to SOC are muxed in LX2160AQDS board.
> 
> These buses can be routed to any one of the eight IO slots on LX2160AQDS
> board depending on value in fpga register 0x54.
> 
> Additionally the external MDIO1 is used to communicate to the onboard
> RGMII phy devices.
> 
> The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> controlled by bits 0-3 of fpga register.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>

Am I applying this to my networking tree or are the ARM folks taking this?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
