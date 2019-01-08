Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55768C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254C920883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwWkgNBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd6o7INQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254C920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jesSdcdobOz5vJJxwOp/Y+7k0oa3CNQdVzO2FL057V0=; b=HwWkgNBVvOtAsj
	RAu6TPHaxr6e4C9Q6s9MLQPhgfBpPaC8o6P/e6VCAin9m0+Kt+X9rnk3qEBj6tkerbdIEwDRtlcdl
	bpu6rrgGm9zm4xiuDJdB4LbZThPRD0yzVwbCXPJ027zGJ8v2gGpGik5SUAtQTrrsoCOivLl+hGFyz
	k5GmS9vNl6o/W6jA5q7b8BEaYNdQj6Ton8o3GbkGxvPD0HpuoMGEf6yCEJGZzgjl8+tv3ue4O4O8i
	75kZ6Wp5HTY6ldyire3H5feiULV7Jjnx/3c8a6EYgFlqpf0p2TGaOb1WFH39HjcqcFvtWmugfb9zm
	e9mGAJOzlN2aG9GV7MsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggx2n-0006kT-Un; Tue, 08 Jan 2019 19:28:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggx2i-0006gX-OF; Tue, 08 Jan 2019 19:28:06 +0000
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 08D6920883;
 Tue,  8 Jan 2019 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546975683;
 bh=VsCLYAm+CafoFhM0L1/+hpueaKDfj6J79TTWPqJHGow=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=sd6o7INQyi4T6Nn0Pd5mmqsyeeMOYQH1Pw97BKKQZOPHd3mNLNqHTrfp9WvacyISP
 iJa/D7nQH2GilnSwiwMqNPLws2rUFBdCwyt85U+x6qoII3QFPmyNr6JFl7YhP2XNHq
 x3vXjNTkQj3kd95VjyM1eOejF/j+NeamTbBGFRFA=
Received: by mail-wr1-f49.google.com with SMTP id j2so5269427wrw.1;
 Tue, 08 Jan 2019 11:28:02 -0800 (PST)
X-Gm-Message-State: AJcUukeayQ1IpK1HpBdiXghigea1+Bb6q3WMus27eHUcsF6IMfBv3S7m
 XGWRtw8rViP6nCrUrlaDpiBRFuuTHjDNxTROF3I=
X-Google-Smtp-Source: ALg8bN6fvK9f9HUj4dXlagiLnTQUWuzG2yB+iTPbtaupNPjiAu5uGcvXHwEZPEHf/mCO7fPbVzMK2GZoNpBogJoi3Zk=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr2501964wro.78.1546975681453; 
 Tue, 08 Jan 2019 11:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
 <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
In-Reply-To: <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 8 Jan 2019 11:29:14 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Message-ID: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Subject: Re: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To: Frank Wunderlich <frank-w@public-files.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_112804_811090_DCD520EA 
X-CRM114-Status: GOOD (  15.42  )
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 11:07 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
>
> > In mtk_phy_connect() I would say this complete block can be removed.
> > All this is handled internally by phylib.
> >
> >       dev->phydev->autoneg = AUTONEG_ENABLE;
> >       dev->phydev->speed = 0;
> >       dev->phydev->duplex = 0;
> >
> >       phy_set_max_speed(dev->phydev, SPEED_1000);
> >       phy_support_asym_pause(dev->phydev);
> >       linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
> >       linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> >                        dev->phydev->advertising);
> >       phy_start_aneg(dev->phydev);
> >
> > Could you please test this?
>
> seems to work well, no warning in dmesg
>
> traffic 940Mbit sending, 900 receive
>

The change to phy initialized valve determined by phylib looks good to
me and simplify the mac driver a lot. You could have it in v2.

> > And a further proposal:
> > Instead of the open-coded dev_info() in mtk_phy_connect_node()
> > you could use phy_attached_info().
>
> have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it

I think it can be done in a separate patch

>
> > Calling phy_start() in the ndo_open callback is fine, you can leave
> > it there.
>
> have it re-added
>
> pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc
>
> regards Frank

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
