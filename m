Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78364C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E62F206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIazZ/Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E62F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zhb4ASUvX7v+h19CHwuxkr0TIvWVRvom15yhtPm9JcM=; b=MIazZ/Yc6+hp+W
	hBUGwi2atOZZUgWSzx4EjvufeEq+qp+8yU4XzP+vmqXb1LuQOISqU8rh6XltN3qWiiZJWNQJCrIDy
	xx8JcAGRT5oGSZ8QTzUUmQNLB2zDdpLT9EpVLuqxrIqFm7badch4UKp6r+3b/EOF2ES/6OPVNvyVt
	Jo3Vx0YlD52ByuQk9DDVB/zwNf+iRqQoLCOXs5XmLWmlI2lkMSfKLneTbccLRRJclmufue7A/54Xn
	trReXJpk1BzpQGqQkGsE9rbrRl7y7Usam8fbs17D9ftOpq7btcC1A9nAOx67AvKXLRLmbS+gkzm4T
	PD7jodrQi6/Bn7YwscMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwiV-0007tS-3X; Tue, 08 Jan 2019 19:07:11 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwiR-0007sw-7F; Tue, 08 Jan 2019 19:07:09 +0000
Received: from [91.14.64.214] ([91.14.64.214]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Tue, 8 Jan 2019
 20:06:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Heiner Kallweit" <hkallweit1@gmail.com>
Subject: Aw: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
Date: Tue, 8 Jan 2019 20:06:53 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZJLH7Z5j6IMWKTHNDAq6EUnJKNx6pZWJhT+UxWNmhz4F977/b+WwiyKDgL3ti+DXmfHD9
 Wgmm718q0bGENdKngNx39qqL/Jp3zPJlxWjjAg3TMgcJyZxbMVwa42KqxvhopBSGaDfKFzEtVdbq
 94mzoVKfARAGMNQkTUiHctnr15Oku8WMu3ujAp34NEngjMyGn5IJS3FS7wb8EfN5n0dhA6il5IBb
 UWfdOKhMzUQVRga8dvv9xkMtwMNxjzh6m2ykbKU7Ad1M9HoU+knS2yCeGzIUQB6QY6QSdmDctroH
 No=
X-UI-Out-Filterresults: notjunk:1;V03:K0:gFXAB7BfwYo=:59sDYjgMRQNN0lLW5e66j5
 65hHbsys7LlrQ2dMTQjdy61Q7gYADs13JmEUcXQzg18QT963AePmLlQ2FxzuX6HA4dm0NXbBp
 PUAz7pAsq6nvlpoI/Q/ULuV7nO/uARLeX9cLZfWKXsEGX0UrzNXSM9AMrWOXWKx+24zFaw/Bi
 llQRkgl2clHzcC/mQ70SBRV8EfxUHo4MJXDLYBYQmQz1Sk/DSUR9Oq1xPMC+X8QZ90bVcS2xZ
 EWBHVz4+5kJdJnUNiQWh1LQJ1wjodl7O/GIKN6j4RaYzcpmBOu1fF792y+zz+Ez8puA1qnaeT
 gT3HI31hsbFIYVFEl8y0fyjyR+F7QPyucsx9iur5hScUFE2DkvehIq4ANXYhCbVGsXZpEmW+D
 Ii5xQMvTKedrgALOPQx5Xw7+FkD0WRGtQDquG+RG8ApRYejqeIgDxn4ndlDrSlNRMh2nKWdx6
 5h2qWvwT9KNF4lZH1CKsBj5lbXuGwecsGXvHujcWQLZkO4smvp5ltDFzCOvyySvz57H9o40rw
 Isvcjk3GMUM8i6pBiGiWo1AdfDD4V4BBWacLeCkCdwQLMjlTJc5GIUavebfE6DL9knfUfIQ8T
 vVLl3NvIEboqQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_110707_559667_E13B45B5 
X-CRM114-Status: UNSURE (   7.55  )
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
Cc: Felix Fietkau <nbd@openwrt.org>, Nelson Chang <nelson.chang@mediatek.com>,
 netdev@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> In mtk_phy_connect() I would say this complete block can be removed.
> All this is handled internally by phylib.
> 
> 	dev->phydev->autoneg = AUTONEG_ENABLE;
> 	dev->phydev->speed = 0;
> 	dev->phydev->duplex = 0;
> 
> 	phy_set_max_speed(dev->phydev, SPEED_1000);
> 	phy_support_asym_pause(dev->phydev);
> 	linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
> 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> 			 dev->phydev->advertising);
> 	phy_start_aneg(dev->phydev);
> 
> Could you please test this?

seems to work well, no warning in dmesg

traffic 940Mbit sending, 900 receive

> And a further proposal:
> Instead of the open-coded dev_info() in mtk_phy_connect_node()
> you could use phy_attached_info().

have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it 

> Calling phy_start() in the ndo_open callback is fine, you can leave
> it there.

have it re-added

pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc

regards Frank

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
