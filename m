Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A4DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:46:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7212087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AijC7iYA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZ0JCTky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7212087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BHwMZmNAD77oTEQGMicsV6abHpFMVQFLQ30LCt3+AOY=; b=AijC7iYAfMhcM0
	Jt8dg6XohgN4BrDYBEypYKlMX/S5QZ7zwYEBcw3xonXfyOcCMf9TvjQuRPXKYdaToVwPBvmY6psQW
	PjzrVC3dRsv5OHK+4U4JKrQRo3PXg4MW7nKN7CkMqJsDlvNa4OdfHMJ+4VfkbWMcOK3LNRrL7DXzz
	knwO0ytDZz0MlzUhq8aVHKbtbw9XswdTXGDLZhEPAgGBmwiHTu96kcNk9GT0lgZKuiHeJr5s4ASs0
	3AAJX0r8+OedCP9eaXEITiEjSg3BVKoL52Fna/C/E+4p37htWSw99FdkIwJKhXw0rR+fV33Ksnt9o
	G2BcG3jFj0NB8k1MrLYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgqJ-0000MY-Ns; Wed, 16 Jan 2019 08:46:35 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgqF-0000Lo-S5; Wed, 16 Jan 2019 08:46:33 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8kOTL009825;
 Wed, 16 Jan 2019 02:46:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547628384;
 bh=lV1oRpzpKFOU70CTWXbLuNLNOnXrBRjGFwpC5uu30uI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=HZ0JCTkyrzc6qwp8FkseWKpaV3F225E1mPS/T5idR9b9g2+UjZjNntl6l9Gta2hTY
 C9Y5rf4M1MylRc6vgd8DzbJaRRUxsV1YA8l9sVqwns4enjLa5YYA9TZH6rtaYBpa1n
 8V+HENqHUuSOGNUAe8q4suSek8OwzKYNIchsX/fI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8kO6D126573
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 02:46:24 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:46:24 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:46:24 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8kLe4026677;
 Wed, 16 Jan 2019 02:46:21 -0600
Subject: Re: [PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the
 utmi-avalid property
To: Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra
 <enric.balletbo@collabora.com>
References: <20190109171415.9954-1-enric.balletbo@collabora.com>
 <5125335.cuvu72hbmo@phil>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8a0ea28a-961f-130b-bd76-9dbda42ea417@ti.com>
Date: Wed, 16 Jan 2019 14:15:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5125335.cuvu72hbmo@phil>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_004631_946827_DB8FE407 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: groeck@google.com, linux-kernel@vger.kernel.org,
 kieran.bingham@ideasonboard.com, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, bleung@chromium.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 10/01/19 5:56 PM, Heiko Stuebner wrote:
> Am Mittwoch, 9. Januar 2019, 18:14:15 CET schrieb Enric Balletbo i Serra:
>> That property is no used in mainline and is not documented. The only
>> board using that property is the rk33-99-evb-rev1 and -rev2 in the
>> vendor kernel. The existence of a further -rev3 (which also looks way
>> better cared for compared rev1+2) indicates that the older ones are
>> probably some sort of preproduction models, where some wiring (on the soc
>> or board) may have gone wrong.
>>
>> It is also not clear why this is a hardware-description or a DT
>> property, so, as noboby seems to care of this just drop reading that
>> property.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

For some reason, I don't seem to have the original patch in the inbox. Can you
resend it please?

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
