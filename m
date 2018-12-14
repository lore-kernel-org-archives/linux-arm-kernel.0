Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:01:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6338E20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z1uby3fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6338E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+kQmzv1DP/5Ad9FWW+g7MgRw2ViJYEcqN9Zk5xCaHgU=; b=Z1uby3fpfTmBjA
	IRDXYkVEg7jAtX87Pq3P0gScNS6Tc0l4qMVVZqN3LuWCSpIVa9NwjlAGqYbWQb+4JrGSWrpM/Q4ck
	SukpMuEZzygVtQsNBfIk/YbTrdqsh+ehAIeZ1STRXPFrtmoSND2Lw/I6hj+DxUV869fu+bEKdqpoF
	4eXsw2w8ADTe5HmmYn+SWgJranobj8ekGgqPFGWsj2TsED8eT5PAdtQdBg+5mbBne49Tf7kdCB4+n
	16lG23tpOzevMtQ+rEFSQesqqHJRy4WiDI63S4R5kLbO//hYc/zwPjyFE1A9FnbJfijkMvvzHSOeS
	ZMbgQt4yFOeuLX9xf4gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXdjY-00048x-Do; Fri, 14 Dec 2018 03:01:48 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXdjU-00048B-32; Fri, 14 Dec 2018 03:01:46 +0000
X-UUID: 668773d20f06480fbc8b31b94cf94e2d-20181214
X-UUID: 668773d20f06480fbc8b31b94cf94e2d-20181214
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <biao.huang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 342136261; Fri, 14 Dec 2018 11:01:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 14 Dec 2018 11:01:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 11:01:17 +0800
Message-ID: <1544756477.24219.164.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
From: biao huang <biao.huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 14 Dec 2018 11:01:17 +0800
In-Reply-To: <20181213123346.GF1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
 <20181213123346.GF1605@lunn.ch>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_190144_706269_2917E63C 
X-CRM114-Status: GOOD (  17.49  )
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

Dear Andrew,
	Thanks for your comments.

On Thu, 2018-12-13 at 13:33 +0100, Andrew Lunn wrote:
> Hi Biao
> 
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +		/* the PHY is not responsible for inserting any internal
> > +		 * delay by itself in PHY_INTERFACE_MODE_RGMII case,
> > +		 * so Ethernet MAC will insert delays for both transmit
> > +		 * and receive path here.
> > +		 */
> 
> What if the PCB designed has decided to do a kink in the clock to add
> the delays? I don't think any of these delays should depend on the PHY
> interface mode. It is up to the device tree writer to set both the PHY
> delay and the MAC delay, based on knowledge of the board, including
> any kicks in the tracks. The driver should then do what it is told.
> 
Originally, we recommend equal trace length on PCB, which means that
RGMII delay by PCB traces is not recommended. so only PHY/MAC delay is
taken into account in the transmit/receive path.

as you described above, maybe the equal PCB trace length assumption is
not reasonable, and we'll only handle MAC delay-ps in our driver based
on the device tree information no matter which rgmii is selected.

Since David already applied this patch, I'll send another patch to fix
this issue.
> > +	if (!of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps)) {
> > +		if (tx_delay_ps < plat->variant->tx_delay_max) {
> > +			mac_delay->tx_delay = tx_delay_ps;
> > +		} else {
> > +			dev_err(plat->dev, "Invalid TX clock delay: %dps\n", tx_delay_ps);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps)) {
> > +		if (rx_delay_ps < plat->variant->rx_delay_max) {
> > +			mac_delay->rx_delay = rx_delay_ps;
> > +		} else {
> > +			dev_err(plat->dev, "Invalid RX clock delay: %dps\n", rx_delay_ps);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
> > +	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> > +	mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
> 
> Why is fine tune needed? If the requested delay can be done using fine
> tune, it should use fine tune. If not, it should use rough tune. The
> driver can work this out itself.

find tune here represents a more accurate delay circuit than coarse
tune, and it's a parallel circuit of coarse tune.
For most delay, both fine and coarse tune can meet the requirement.
It's up to the user to select which one.

But only one of them can work at the same time, so we need a switch
flag(fine_tune here) to indicate which one is valid.
Driver can hardly work out which one is working according to delay-ps.

Please correct me if any misunderstanding.

> 
>        Thanks
> 	Andrew



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
