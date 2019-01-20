Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F6C6369F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA4920861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Onn3y/KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA4920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0kiEQu0cnl9gT96DrFt3Jq830HMtSqzFbN8J9OM4gng=; b=Onn3y/KRi2hB99
	WsCScP4ZX0hOKV6cBKZBE8qrvPf7Bb23Ylaep6cr4X9Z/vl4/GAFI6oPFXxX+/TvUrb2Bs6Pj9SdO
	dFz+NPynEqesCx+YgRKZaFFalHnVQBQJeulU2OJnp0ufELRKaBbsfw+NFtzb5b2apQykuReXvFeT4
	6EskjvMxZhJzpitFmF0boZmYs7PPPLH/voYNajzAhjnDZoz33jcJvTd7UIzqKVAFo6eyZCa4MWVXq
	oe51BnpyIlYHFz2f52eRaBNLjaQr+uA+y7sSzNktMEYgoYaMivV0MDucu/gJpeQ3YHHW2XwMAmjH+
	B/UsNO8wx/JWVlSjvSbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glDHk-0001lN-MC; Sun, 20 Jan 2019 13:37:12 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glDHf-0001kW-FF; Sun, 20 Jan 2019 13:37:09 +0000
Received: from [91.14.82.116] ([91.14.82.116]) by web-mail.gmx.net
 (3c-app-gmx-bs40.server.lan [172.19.170.92]) (via HTTP); Sun, 20 Jan 2019
 14:36:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-1c369adc-b489-43dd-87c9-5b43d49561c5-1547991406711@3c-app-gmx-bs40>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Aw: Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Date: Sun, 20 Jan 2019 14:36:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
 <1547775975.4221.11.camel@mtksdaap41>
 <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:o3i0L9O9z+MQlz+k1jSJjzY4FAThw+MOKUvQv5koO7oJGjqZ2m6zlGK/O/V5qwkb37qaC
 ICMcZwO9jhaDqZAj2oFvflIvZeqrW5aXVKcWzgFa0sNDZmoMfS12yqfk1Ubsaz08vjjj5nP/oraS
 EpRpASe0FNiR+CwF40kmXRhD9FobgrXZDLtoMkin1OYB62yS5/XInKlMgROz3Ph1tbX8fQ39R8yF
 HNNfmjZtIejybkJnABXRzcmR3BOLGNq5YOLIRjwli15zQxwsOZyHXOKHNzZhXcUvX9kLbYrpbKWB
 zo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqCeU4qORIw=:P01+qOOUmzzjPAfj1IeNZ+
 9R28epdTR5zX7z81bqBfysFGYKLHrgAwbFjgeSPDvMuxbK7Tcjc4W8KW1Ue0aU4yMxtCkYgEZ
 tEgp0tSejn4+lQZiG4ZVL7DUZNFhn2HmCEzWnCqpkv7qnZH/2A7PM38QOFCm4Bynm4bDpHnnr
 ijcXKzw4rr3Pi1KX6n6V70Lhn6MvlyqhVcfYS82EKG6JuHCSeN0lyvQRGIMiSTb0sIHi8PIk5
 vV1mh0wi/gLrcgFuf9ftroQGDybGyyGu5wW0zBCRqMv5ZI8DZaD12+fW/26cnAEpGDBZSDfCD
 6ubVKBwnW/aJck4bFYTHzwVZnL+a7FTOOCl7UKTChfPuSI6i3DDqroEBoL6n5B6o/k1DPPZwZ
 RNFgxTYcbNy1yYKtsdIHiZH0fxTbMIlUwXz2CfiMjyrJOADG/sws0ixukXTDh5Rw13yCnA4oQ
 vcJunUsEM9eiNqHTv0RdQbA5ig/4pRL8jFxVno4OVZIrAXPXE2kTZNwBmab0ASvXZA6gO6N8O
 lgonbmiTeM8iT2i720Bbuk9d4wwbfInf9MvfJTK3CjdTamM7if09TRRhexXMKrsruxnBwse4n
 OJH1zRI1IvZlk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_053707_810686_F7F3CA4A 
X-CRM114-Status: UNSURE (   4.88  )
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
 linux-mediatek@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tested with mmsys-Patch, but same result, no fbcon, tft is switched on but i see no kernel-log

after boot is finished, i see X-server, until this point i see only black screen

regards Frank


> Gesendet: Freitag, 18. Januar 2019 um 09:39 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> may it be the not yet fixed mmsys compatible problem?
> Frank, did you test with my last series [1]?
> [1] https://patchwork.kernel.org/cover/10686345/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
