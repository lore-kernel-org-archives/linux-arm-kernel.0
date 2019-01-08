Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:37:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5852E20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUBzVcsH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuwAMB9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LoY8HF4l7FBGOw4b6qvKZVyMrI7XJdQTGwYazs5U1IQ=; b=AUBzVcsHkVeQc1GW5JNeQ7uL9L
	hTre9msXZBnBLVadqk+Szkx2HIaAotVaR1xNme29vZ1oH3A0e0Q4/xr+SZirOBA//Jl0onm7pNY1c
	7mvqr/O8IKcVjl93w6XQucVA/SZsgH720G46J7nTpfqb4cqHgib8CFZaTeJi2vs97/GtyUq0l5MBd
	7dxMj7LJIrtg4drGtFw7lfkP06rASp6ZNEQvQc+xt5YzCI7B/mceMYKfXpR3zqVLHx7YlCpmjIndB
	VCK994vVjGIrOrg7VXx3L0Sc+jN2dChz8MlIIttYRKU3DEGaLaBkspyX875T5rJizUqm/5TmdssX4
	pAoXJvqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwGD-0003ow-HX; Tue, 08 Jan 2019 18:37:57 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwFz-0003cn-Px; Tue, 08 Jan 2019 18:37:51 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so5083616wrx.9;
 Tue, 08 Jan 2019 10:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=r2oD1oZzoflkPdR2oIRWq1Duqfs2FKeqTyHvwkZ6Jt4=;
 b=GuwAMB9Q+kLSEebvNqoILD3fEUHGTB9fZ3MNKru/fJm7GtH/Zk2qcHkzK+j2nxv6gK
 U++B/1Q3lhfxwOX8hyMNGrc+Nc6gUJDF4UR9uF1Ut0TRsZq9tK8/bzqOHVCNVa35Ir7Z
 B6hLECFaxJUtDKGizIeKj5bqoscqINzUOSB8DJ7AysCkuzFALNOfEQsX5Zk740WegHVP
 JF80Wg4cOTBkm+DmJJi/uFl2OzhIGnJJ0k8M0+XMtgkrXhphLYDZ6rGV61bpRtAKTvuD
 t5ahgWy2ie8rAaOWyn9sRqy93OpHPcUFlF838c3P57cN4x+sg+jNXI1Sq0QR4GQQPvkX
 38jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r2oD1oZzoflkPdR2oIRWq1Duqfs2FKeqTyHvwkZ6Jt4=;
 b=i4DFJcEMppztJLRr3IQR2yI+i9s0kzdkGCC6xC2MRFVfSItUyhn1JE25qOiFkAK2oP
 fpsh9uy1T5meO5Uc3s9IqNyKJ9dQ9HC/SNjbX2uWoI1tXmo6MzBvUddJFJRTFZq15WB1
 tYcfSg3QqCybHjNP03wMgYDCQvZM/H2jBQbDhN3BtkDmja8jK8WKpGXtA0YHiTP+hh+W
 Nb/8eOPe/88gVSXVuagwraMYjetd5U5AVmetaJuLru9m9BsfQhBnFihafVG3f7t9nOae
 GgX3l0/vpGuHaR3u+Dv3cqS/gq3MB5uBqNE8VGBzCfw3qEJ4C6ZOWsByXGgYzRjSmsIF
 KNlQ==
X-Gm-Message-State: AJcUukeik97caHQ0EO0ZjK4IdM2XTphHDWUVbuvFCVJJB5hJJXcpQ6yq
 lz1ej6ad65+rguW1iB8CLBs=
X-Google-Smtp-Source: ALg8bN6ezASsIpEhk+WyHQVswFc1PcG+GOzbsI5WT5Vbl4AJ28Pi0n3QN/t0Wlur8O1+s/hEGcrrqw==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr2338469wrm.115.1546972661539; 
 Tue, 08 Jan 2019 10:37:41 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:50e8:fa09:6b66:e3da?
 (p200300EA8BE2E40050E8FA096B66E3DA.dip0.t-ipconnect.de.
 [2003:ea:8be2:e400:50e8:fa09:6b66:e3da])
 by smtp.googlemail.com with ESMTPSA id p10sm731378wrt.25.2019.01.08.10.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 10:37:40 -0800 (PST)
Subject: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To: Frank Wunderlich <frank-w@public-files.de>,
 Felix Fietkau <nbd@openwrt.org>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@kernel.org>, Nelson Chang <nelson.chang@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20190108160526.18928-1-frank-w@public-files.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
Date: Tue, 8 Jan 2019 19:37:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108160526.18928-1-frank-w@public-files.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_103744_361657_154CA3DE 
X-CRM114-Status: GOOD (  18.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08.01.2019 17:05, Frank Wunderlich wrote:
> From: Sean Wang <sean.wang@kernel.org>
> 
> linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:
> 
> [ 5.170597] WARNING: CPU: 3 PID: 1 at drivers/net/phy/phy.c:548 phy_start_aneg+0x110/0x144
> [ 5.178826] called from state READY
> ....
> [ 5.264111] [<c0629fd4>] (phy_start_aneg) from [<c0e3e720>] (mtk_init+0x414/0x47c)
> [ 5.271630] r7:df5f5eec r6:c0f08c48 r5:00000000 r4:dea67800
> [ 5.277256] [<c0e3e30c>] (mtk_init) from [<c07dabbc>] (register_netdevice+0x98/0x51c)
> [ 5.285035] r8:00000000 r7:00000000 r6:c0f97080 r5:c0f08c48 r4:dea67800
> [ 5.291693] [<c07dab24>] (register_netdevice) from [<c07db06c>] (register_netdev+0x2c/0x44)
> [ 5.299989] r8:00000000 r7:dea2e608 r6:deacea00 r5:dea2e604 r4:dea67800
> [ 5.306646] [<c07db040>] (register_netdev) from [<c06326d8>] (mtk_probe+0x668/0x7ac)
> [ 5.314336] r5:dea2e604 r4:dea2e040
> [ 5.317890] [<c0632070>] (mtk_probe) from [<c05a78fc>] (platform_drv_probe+0x58/0xa8)
> [ 5.325670] r10:c0f86bac r9:00000000 r8:c0fbe578 r7:00000000 r6:c0f86bac r5:00000000
> [ 5.333445] r4:deacea10
> [ 5.335963] [<c05a78a4>] (platform_drv_probe) from [<c05a5248>] (really_probe+0x2d8/0x424)
> 
> maybe other boards using this generic driver are affected
> 
Good that we added this warning to phylib, it seems usage of the phylib
API in this driver can be improved.

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 399f565dd85a..e48c06874a85 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -356,6 +356,7 @@ static int mtk_phy_connect(struct net_device *dev)
>  	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>  			 dev->phydev->advertising);
> +	phy_start(dev->phydev);
>  	phy_start_aneg(dev->phydev);
>  

In mtk_phy_connect() I would say this complete block can be removed.
All this is handled internally by phylib.

	dev->phydev->autoneg = AUTONEG_ENABLE;
	dev->phydev->speed = 0;
	dev->phydev->duplex = 0;

	phy_set_max_speed(dev->phydev, SPEED_1000);
	phy_support_asym_pause(dev->phydev);
	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
			 dev->phydev->advertising);
	phy_start_aneg(dev->phydev);

Could you please test this?

- phy_set_max_speed() is only needed if you want to reduce the
  max speed, typically if the PHY supports 1Gbps but the MAC
  supports 100Mbps only.

- The pause parameters are autonegotiated. Except you have a specific
  need you normally don't need to manually fiddle with this.

- phy_start_aneg() is called implicitly by the phylib state machine,
  you shouldn't call it manually except you have a good excuse.

And a further proposal:
Instead of the open-coded dev_info() in mtk_phy_connect_node()
you could use phy_attached_info().

>  	of_node_put(np);
> @@ -1821,7 +1822,6 @@ static int mtk_open(struct net_device *dev)
>  	else
>  		refcount_inc(&eth->dma_refcnt);
>  
> -	phy_start(dev->phydev);
>  	netif_start_queue(dev);
>  
>  	return 0;
> 

Calling phy_start() in the ndo_open callback is fine, you can leave
it there.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
