Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:53:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3272084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uN/joJYs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyB0C6kU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3272084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ztmv7oEODFYD86kegFTG2iGca1KhVUt96RzV7DkicKM=; b=uN/joJYsYL+hMk1ydWalpk9CK
	wu8in4fCpVYNZ7nsP3mJ5R27fV2IW+xkG5EcT5WI4P+5f2BYa+UUTL3qK9JWuquoW1jbEQ1Wrq5gF
	9e4t0w5eKCNNCGKY4UPaNfdpAfIUVz1dXO77DxfcdvJSpWU4uOaBKlHljEaMkzBVS8p3PbOf+rpnU
	2tO6dSYdH92UA2/hh7GdXzK42aF7JtRc34Vq4K47bPs9LHGptnx7mXn53eQ6rEeEO3n0NwaWNnnSB
	BS+bdDjyX4948TptIRKO6R3fXPfbP2oyzAb9WbkWlDQcz2FKmPoUWxELNWGY6ej7Yyx2BwB+4O6hb
	X/+s35zbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYjyV-0003yk-7J; Mon, 17 Dec 2018 03:53:47 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYjyQ-0003xv-ND; Mon, 17 Dec 2018 03:53:44 +0000
Received: by mail-pl1-x644.google.com with SMTP id y1so5442777plp.9;
 Sun, 16 Dec 2018 19:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J4dI8m1fcRNCW+YsdRAhm8+jl/emh7cCQEO63STjzV4=;
 b=AyB0C6kU22Th0cpI1I+7q/Xq5afW6Cx7tfdTsHS87d/2LxX4CyO6X4ScIqncMm7BJI
 9ps7jdgNDRqNqWWjRJ0ZGFPCnYC2ubphOEPgV/44+m4B++bQlly/XY95NB/ZlZNR+S+Q
 kn/98q4HRL35jyvCAR8DZkz5J5n8OXSKSdlnyW1hDBDGG1FcR+6h8opCsUuHaeK0gqei
 Zn/G9Io1T+0yXZp8qUtVFSdBVRBgcir1V2TXFo7RIr28MPtbcRRJ/JwuRzOfLjLm8x+t
 N+jAYKb8jUC9bQ2H0dqqNqoGvdOsZHKmCDvZxuR0zVO/HiZRNjmd58d5NDQT8wTqXw0C
 s3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J4dI8m1fcRNCW+YsdRAhm8+jl/emh7cCQEO63STjzV4=;
 b=DvW6G8d6GCoEMnfy3le5NcEJTrNDKbuzfyLtTQQYWrxfSdmFZKXlWDyvQqjPF3eIRR
 aDK0UmVgkqUvUYZ0DQ54s1F/f7neKwejm7UTtXmb3h1tVOP8n+wFsWpRuEthsLd1QP33
 C86+SoIAHtNPjWa0yBOVW6o96OrhboOL9LPb/Qq0zMUb/LlXhOfWynTD+2qXlSMBW47c
 vB6o0eMY6Qgxn8EKBGjX4SIU9d7QbNg0TyEP3jXvja5WNO1b1RWEZoU8I8VvvnXaVB6W
 7MmmjalDmE751Dmmgc2MSis2qjBwkynu3zV69ZBq/quiy8VMjY5NadOtkSXjfJKT/cz4
 eERQ==
X-Gm-Message-State: AA+aEWasrklbP7tZA2pVnC0GNGwuhCYafCRCo7e4G8EGKCJCD7AmO4vR
 p27yP0730uYbBWcMLgCH/qtqXScl
X-Google-Smtp-Source: AFSGD/UuZGALPRNDEqtcPHmN7IJrZYqMOU6w7AvNs7RwrBkfX3Ner4JoVyMOyR77un2cyc7zllP2iQ==
X-Received: by 2002:a17:902:b40d:: with SMTP id
 x13mr11528032plr.237.1545018806362; 
 Sun, 16 Dec 2018 19:53:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 89sm18256180pfl.120.2018.12.16.19.53.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 19:53:25 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
To: Ryder Lee <ryder.lee@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
 <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
 <1545017947.7782.1.camel@mtkswgap22>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9fb38853-6202-c124-d254-f8d20b4d469b@roeck-us.net>
Date: Sun, 16 Dec 2018 19:53:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545017947.7782.1.camel@mtkswgap22>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_195342_784122_C925C300 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/16/18 7:39 PM, Ryder Lee wrote:
> Hi Matthias,
> 
> On Sun, 2018-12-16 at 11:31 +0100, Matthias Brugger wrote:
>>
>> On 07/11/2018 08:10, Ryder Lee wrote:
>>> This updates dt-binding documentation for MT7629 SoC
>>>
>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> index 859dee1..8682d6a 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>> @@ -8,6 +8,7 @@ Required properties:
>>>   	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>>>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>>>   	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
>>> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>>>   
>>>   - reg : Specifies base physical address and size of the registers.
>>>   
>>>
> 
> Could you take this through your tree?
> 

Why ? We usually take watchdog binding updates through the watchdog tree.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
