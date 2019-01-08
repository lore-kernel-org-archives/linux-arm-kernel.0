Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC701C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3B22063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RWsN/nqb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAWJuuy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3B22063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lEAmvYFRBW5AUKAAnGA0sqa7FB12v+uqwVaI9d8iHso=; b=RWsN/nqbxDHrR4
	HIofc1MWCiYEP6pr6kmdAmwdAI3BWiRTGxi1cR7k4vHS+agX+WNw+blLPhgMDZ4QVxVe29gZnhghd
	Y7Xe0W1llHEi2Vs9y2bD8tdRKpZc1FoPodp3oZ1LaxR7WRmf63aGjgpnWuyvHTGgHOSmCaqlK6Y7d
	jpz/GaBTOzK5CUrdkkNYYh26WlSKQ7EdgwMS/xEIk7FiqqQYroyeppMAWn1BFyhOL7omKEacuVZ39
	LlPm9BrPEC0J4uKIOpS8RieQU5hoab3l14ySnBWxet2uY+rtPfrCGKLSDq8zBl+LJ/rXaYcDrj1KQ
	u7TmyXLGMlsbbv00iJvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxHH-0005Zm-Kr; Tue, 08 Jan 2019 19:43:07 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxHC-0005Yq-Qq; Tue, 08 Jan 2019 19:43:04 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so5283740wrw.5;
 Tue, 08 Jan 2019 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NGhmqtwpW09+58wJoPUk4sUkN4/4hC9lANeaIGoHhmw=;
 b=BAWJuuy+VMMMxDyiA6bZBotyYFndDRzKQSl/+/Zl3HAu3xjVGBG7ePayiV55wVrQ6W
 kof7CFd+cb/r8BuxV7Uj0aJFGhCUg9LaYWKyp+OmJ/YtP3OrdWCLGKBohEaTJmSdJPo6
 FSNcmzCSORVE9g89xgTMzCWoD9FX+aJxL2m+POTCjIBzfz7sJsBB9NpndA5yaSfACCaA
 +Yz6BVJr5jwv8Ld9SqS9ED7ZMaEDtAaKJR+Li7RNeUSMyXqjYqZV/dbyl30gYF/wgirn
 BuNwqd2ur7LUUX4r0n9ZLtIcNsUjJ8ziJcOft0jAwbs3izjlkvBw6MqiCqLglYVoxqcL
 ov5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NGhmqtwpW09+58wJoPUk4sUkN4/4hC9lANeaIGoHhmw=;
 b=g+uZHj+uM3SnDEWAiMEIgnsbfpYoELhA4YiTuSupdpOdXXd6cunWRhCKUwxnjvkTcS
 MVUDaBfZRctwZ0wB3blRv4K5FAuvJRhqLX18/vwqkMgpQzb8ByTXGz8h3diwwa++vTpK
 KpGuPoR+6HD8T/V3Yzh79JurkYmLluNlMy2Wt88BoIX8gJkIfsYmKJSszQwt0O0cZPVD
 +zM2wh+a+WxWowzmB3qNFG+7NS2krHzdZCjdrkvvReoli9dhyaIMHXm3dQwhkftnWUaF
 0iWei0QSEwmhpNvDIN84jT7NmzBb+JAgrNogpbKqUUXmACiY9g9EPpgRp/mbZ1qFw1Ol
 MD6g==
X-Gm-Message-State: AJcUukeCjAl3XPoErDm/B2TiabRIUrI2hAKmSMboXFy6wnnUGH5Gn/If
 q7qo92Sdf3Eu7kKai/ke3c4=
X-Google-Smtp-Source: ALg8bN4ko+R3ZR1sJxtv68ES5ZQ+eMFiSrQvreP1TJLCvt5Tuag+caHf4y6qbkkcGauQKP1cNGBGlg==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr2295302wru.316.1546976580875; 
 Tue, 08 Jan 2019 11:43:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:50e8:fa09:6b66:e3da?
 (p200300EA8BE2E40050E8FA096B66E3DA.dip0.t-ipconnect.de.
 [2003:ea:8be2:e400:50e8:fa09:6b66:e3da])
 by smtp.googlemail.com with ESMTPSA id g9sm10429472wmg.44.2019.01.08.11.42.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 11:43:00 -0800 (PST)
Subject: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To: Sean Wang <sean.wang@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
 <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
 <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <8f58fd47-f7ff-399d-4c20-76fe4d72ba9a@gmail.com>
Date: Tue, 8 Jan 2019 20:42:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_114302_901199_6A8D9D98 
X-CRM114-Status: GOOD (  14.33  )
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
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08.01.2019 20:29, Sean Wang wrote:
> On Tue, Jan 8, 2019 at 11:07 AM Frank Wunderlich
> <frank-w@public-files.de> wrote:
>>
>>
>>> In mtk_phy_connect() I would say this complete block can be removed.
>>> All this is handled internally by phylib.
>>>
>>>       dev->phydev->autoneg = AUTONEG_ENABLE;
>>>       dev->phydev->speed = 0;
>>>       dev->phydev->duplex = 0;
>>>
>>>       phy_set_max_speed(dev->phydev, SPEED_1000);
>>>       phy_support_asym_pause(dev->phydev);
>>>       linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
>>>       linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>>>                        dev->phydev->advertising);
>>>       phy_start_aneg(dev->phydev);
>>>
>>> Could you please test this?
>>
>> seems to work well, no warning in dmesg
>>
>> traffic 940Mbit sending, 900 receive
>>
> 
> The change to phy initialized valve determined by phylib looks good to
> me and simplify the mac driver a lot. You could have it in v2.
> 
>>> And a further proposal:
>>> Instead of the open-coded dev_info() in mtk_phy_connect_node()
>>> you could use phy_attached_info().
>>
>> have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it
> 
> I think it can be done in a separate patch
> 
>>
>>> Calling phy_start() in the ndo_open callback is fine, you can leave
>>> it there.
>>
>> have it re-added
>>
>> pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc
>>
>> regards Frank
> 
When talking about improvements: Also this

if (dev->phydev->link)
		netif_carrier_on(dev);
	else
		netif_carrier_off(dev);

in mtk_phy_link_adjust() isn't needed. It's done by phy_link_change() in phylib.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
