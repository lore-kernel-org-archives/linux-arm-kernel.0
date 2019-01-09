Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0B8214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKRDp+Un";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1bnovL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0B8214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PAery/ErWgb1RGWLetA/zrMVnTzanFk4D3yKlTe4dD0=; b=sKRDp+UnLEIJgBfMGnr+3p5409
	Fc+OZzxkc9wi5O+f5eW5mQTuVHyhISn23vMK+A7qhp0CB9m/RXsVpxdwtA7dUduYVJ1mDmQcwLeUQ
	0tVgaqnjluozoo+kNO5OAJ1omdEca8eDJhTrRt2WEgZBQEBYQLhuxUhMmDN0NaZpvh8P1csRyOpSV
	Fc+6IOqm40iGSMxkQ65bWXGXTYwORTmXVI6huIA4Mkng8+52c2RxI4ME0cFmRK4GBH+qSdYu1GEif
	NE+siJZojBURxEBJ4Wn/Zjh1JG32YRY5hXFU0H3w7dSJgqvoafCRLOquJibwXE5PoFdvygVzkT5B9
	fFa7ZLWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIdd-0001ao-Vz; Wed, 09 Jan 2019 18:31:37 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIdZ-0001ZT-N2; Wed, 09 Jan 2019 18:31:35 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so8680589wrx.9;
 Wed, 09 Jan 2019 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=sheBbn+PfpEMVz8/5nrRgnVPzMh1ftREYGKNb2yY60U=;
 b=Pm1bnovLWjxh9WaAgx8YVzLkn6cxgszAwORzrhtuRCPgue5Rl6a2vRW2eCjqI0kREB
 JuwCw5e2ubcFM7dYbAmIKHCL/owPqHpFLj1fPwVxuuuXYLgFoxqsNFzK/6UONE1QCo9f
 yZMlAjHIRnaTlN8V1hWjjq/rn7c7Ux7qHnDuk81ssgWyQR4ETSi1/937mK25E4QpfVdg
 H3GG//lyKmNfsPaSnk2x4oDbud/nA4aJjoT8RcRyQqOC1jwShTEWgO2jKi95z7zotjuF
 tW7e1TgrLsz07HCCSFVQMQA551dsssBgXMLG5Ppv4yWfPHN7fJ0JvdgP/6J51MyF7Xgp
 kIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sheBbn+PfpEMVz8/5nrRgnVPzMh1ftREYGKNb2yY60U=;
 b=mOo9E0XiiH2oye+jXofxUW8sMtrHdu2RYkqLaokMNlYv+JHaC/TKMTAtbSLvLndjKQ
 y6Q0bNYexnPqAjqGgD4/FSlCkorQroxt4oWvs7y4TYPJ+Hk3KnivBBc5EHDq8FltLT5j
 r+2zqkf3DU/VWFplFG8DabaaIRn5O3Icz+TlkLHNMrqpmSMMKe1PxITxAlhnoWBsgE3Z
 YwNiKFhuOmtMWbttWCVGNdaOtcKXmpiCvPPOIYl2VDrbr4EYH2hm442H8JBbaSB4/fXW
 sDc5ZMp/LI330mKIT1feLdYanFKkibNdGcOXhGAFbkkBG8D8C9WHmV0Sf6VZTUwPo8OO
 eYLA==
X-Gm-Message-State: AJcUuker822hXT/COwV7lbXqdmwzaWsYcubQW5mFR+fzPUrXn67EnOOr
 zkzc2dnI/31QkJaUceRDIKg=
X-Google-Smtp-Source: ALg8bN4NaUZqCRfMDvjqByIArR9MDac6FD7XQSvGnTLRESVNkjbDMb3nS3y9ZUs8YXRaaoPx9WdbAA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr6031538wru.222.1547058691763; 
 Wed, 09 Jan 2019 10:31:31 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc?
 (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de.
 [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
 by smtp.googlemail.com with ESMTPSA id c14sm13869999wme.13.2019.01.09.10.31.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 10:31:30 -0800 (PST)
Subject: Re: [PATCH v2] net: ethernet: mediatek: fix warning in phy_start_aneg
To: Frank Wunderlich <frank-w@public-files.de>,
 Felix Fietkau <nbd@openwrt.org>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@kernel.org>, Nelson Chang <nelson.chang@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20190109072028.30513-1-frank-w@public-files.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2d3d2d19-b149-76e7-8013-ffb124b62f2b@gmail.com>
Date: Wed, 9 Jan 2019 19:31:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109072028.30513-1-frank-w@public-files.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_103133_746551_50BF671F 
X-CRM114-Status: GOOD (  14.16  )
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

On 09.01.2019 08:20, Frank Wunderlich wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
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
> v2:
> optimization:
> 
> - phy_set_max_speed() is only needed if you want to reduce the
>   max speed, typically if the PHY supports 1Gbps but the MAC
>   supports 100Mbps only.
> 
> - The pause parameters are autonegotiated. Except you have a specific
>   need you normally don't need to manually fiddle with this.
> 
> - phy_start_aneg() is called implicitly by the phylib state machine,
>   you shouldn't call it manually except you have a good excuse.
> 
> - netif_carrier_on/netif_carrier_off in mtk_phy_link_adjust() isn't
>   needed. It's done by phy_link_change() in phylib.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
