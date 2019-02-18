Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53432C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2420F204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ny1FlmIh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DNzyc+qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2420F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3Sz0uxc42BjpcfM/sqbYxxoWNEVhpFEEtcy+Z+pIXLI=; b=Ny1FlmIhc/ghWVZIOj8leTdLW1
	phYoki7/uUOAd6gHyT5DzHbpkx4NKdFrYPfCairm1CnCK4lrO6lbyAXfpUxO4QxtcEj/LlQvMoV0V
	CUq0Q1ZGKrqyx9YqSP3RCxlkuzyogZ09ZdTu7cYErcO08NuK+Ripdhs+OGg3kDrwYFTpFfjWXtInR
	np1b+l3TScBAXWgbZrQWoYCrKUJy/YVXOvTWQin+eQNFXFKAL+0pNOGu9/ud+Wb/775KqEP3BBTZM
	OWbdwf4qMoMVa0LFRZQj2zIRr6knJ0qQduLj3/WnYv5W+SGfWbpVbK1Dj+HW3PZwn9JkRjqO4rEBH
	+2OXBKYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjbE-0001Lq-4S; Mon, 18 Feb 2019 14:08:48 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjb9-0001Jw-Fc
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:08:45 +0000
Received: by mail-ed1-x543.google.com with SMTP id m12so13917590edv.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=gFO8LwK33ywbW9SIa15Cb2gHG5oozM6OBAvVIPZVXeQ=;
 b=DNzyc+qYAb0NALeJg8RzVLqy5pj2aOWYWpkgh1UJ75D0mESwiTMtROi3ixJjqTPXgs
 VeRsa5L7avUdKK1tal1QfU61H8ifm6m51boKWdKoYDnEWmNsloICO2Vpm86J0eiGCUeY
 n9Mi2RwB6INJ/TVB8wv+hhPNizbA/eIruGJErj4amKoHGCpc3U97kMAlix7KAtYnzBwB
 gsC1NP5118CAiIHviDvpcjV0a2F4XvP1bkctr+D9jejS9NZjliNxCAqgBiNDZXsVtxIh
 W4CRh6NlpS4djp47IcObWOS/rfu28g2TO3oBZHS3PzN1yah0rakfKdtOSaN5qSeshENr
 O6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=gFO8LwK33ywbW9SIa15Cb2gHG5oozM6OBAvVIPZVXeQ=;
 b=ChP63387jBZa9FPt062RYKO70+7w4xzaBjavFKxEd77oW/X1QW4Va39WJcmueKXoBq
 8H2ZO8ApIKKjQGyCPC1ImSOGCSo5hA3GNaS8yXbAY0FUhRvBYyAKKWKAE2RG460Oqymh
 5IchvBF2hz0yuvm2Ai+sN1lonoZ5LNxGZIKPRnCTZrEtiohNOSnfJigomyfiD5cEw/6E
 2aHPy5aygzxS6NBSXWpctECwtvgJkeN42gkauJhuAj/605n/kaBlOPYIUQ6Djw4Ze9Ng
 4nPe1RXFq7TRSJ0R0+NVJtjUYIuVxymDLzCx6GjOrxK6gRTpbb82Ra4M8C49Wuu39OhS
 PSsA==
X-Gm-Message-State: AHQUAuaONKh9mFuJKUU9GQGTPx2+KcX+7Z+Rs7+udxVJ2s+dzDhFEosL
 JWxg8OrLw8gdSbJzVDY/dn7iWw==
X-Google-Smtp-Source: AHgI3IZ7ok34FpI0tRYpAXVimkuavzpjqGgMrAfeBtgkLwiOqtsdEYxrS6H+LQDmdFWUDrZAitMD6A==
X-Received: by 2002:a50:9927:: with SMTP id k36mr19279800edb.31.1550498921640; 
 Mon, 18 Feb 2019 06:08:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3053])
 by smtp.gmail.com with ESMTPSA id k4sm3094441ejj.32.2019.02.18.06.08.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:08:40 -0800 (PST)
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
 <20190215160457.GO28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190215160457.GO28278@localhost>
Date: Mon, 18 Feb 2019 15:08:38 +0100
Message-ID: <86k1hxur2x.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060843_583834_5634E609 
X-CRM114-Status: GOOD (  15.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Fri 15 Feb 2019 at 16:04, Johan Hovold <johan@kernel.org> wrote:

> On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
>> Add binding for Mediatek-based GNSS receivers.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> v4:
>> Use standard names for reset-gpios and gnss-fix-gpios
>> s/an/a UART
>> 
>> v3:
>> Removed the I2C and SPI interfaces references.
>> Removed the "mediatek,mt3339" compatible line.
>> Added the optional propertied (reset, fix)
>> Added the pin names for the optional properties.
>> 
>> v2:
>> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> Moved current-speed as an optional propertie.
>> Removed the status line in the example.
>> Added "mediatek,mt3339" compatible.
>> 
>>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> new file mode 100644
>> index 000000000000..12283d429baa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> @@ -0,0 +1,37 @@
>> +Mediatek-based GNSS Receiver DT binding
>> +
>> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>> +vendors and can use a UART interface.
>> +
>> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> +properties.
>> +
>> +Required properties:
>> +
>> +- compatible	: Must be
>> +
>> +			"globaltop,pa6h"
>> +
>> +- vcc-supply	: Main voltage regulator (pin name: VCC)
>> +
>> +Optional properties:
>> +
>> +- current-speed		: Default UART baud rate
>> +- gnss-fix-gpios	: GPIO used to determine device position fix state
>> +			  (pin name: FIX, 3D_FIX)
>> +- reset-gpios		: GPIO used to reset the device
>> +  		  	  (pin name: RESET, NRESET)
>> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
>> +- v-bckp-supply		: Backup voltage regulator
>> +  			  (pin name: VBAT, VBACKUP)
>
> As we discussed, I changed this to "vbackup-supply" (here and in the
> driver) before applying.
>
> Note that git reported some whitespace errors above too (spaces before
> tabs) that I fixed up. Not sure why checkpatch doesn't complain.
>
Oops, thanks for fixing it. I ran checkpatch again and it did not
complain. Apprently it's not checking for spaces before tabs in "txt"
files.
I'll add a step in my flow to apply the patches I create before sending
them to the list so that won't happen again ;)

> All now applied.
>
Yay ! Thanks !
Loys


> Thanks,
> Johan


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
