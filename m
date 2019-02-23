Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA78C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38EC20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQr/aggI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDDGKAZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38EC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Mu/imHiCXzOnpzGfVCb2XAu07G0gJZ4PeoMbMpd9tY=; b=cQr/aggInB3qmE3ppWEYzQYDP
	5oOWYdf25CT7a+Z5GfZkqmXaXg/oNeqCrwdSeyBHtzAtmxEtNeLYNul6QTJjtFEGGE2vkxrpGvU2/
	bREBk/wLOCKqR3YE5Ag+4YzlKZDME5gIBHb95HGVvhAYlXvSSuQ9TR97xIBlcsKvG99jIfRqddawR
	Zy+oDrdxfG1rVDR9TWnVHjGkay3VDHv+0L6b3B+hHMAqIOu9sIB+CEDcKwjNlY1JBG1iyTEiT8UVw
	3MD5kufz/AYQBBL2nGXNelqjglJAGhEnnvLAY3S/S7FaNdU4D1RBXpy4R812lYg5mWJrrukuDMwPM
	iQfGbZLCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxWwx-0004fN-SA; Sat, 23 Feb 2019 13:02:39 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxWwu-0004f2-VZ
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:02:38 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so4266929wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pg0qPK/7ic2gH9jCLEPOmJCLbTatvZOgY7K0zD6ap84=;
 b=gDDGKAZuArjq6zH7AdO381l6tZQ0mA17Ns6KM1gW7kJjrP52DucMMNvcbVd6LwYqoH
 FQ8oev6BeEhCihNvxvDvyw7/jLweE2TjE4kYz2xjm4g2VpPKJOEsswhPd1qMnyRxw+0Q
 8RjoP1yBRIlso0RBQSEXj6DpN67LwZBw05COWOaccsQ2hFswYAfbVqrWtaYUgDQPFFq3
 y2Tel7JUVlhuuY8tD84Mug6Nuk65/Ix3pNmWkdqz02/Nti9NC5HjzvNgTFJXsW1HlUof
 Et70iVdBBtAk4WaogtIrSbwP0/SZx4MwSNN2Pzq0GaI8rUG5Y//Oav9zJro1MEWhMpHd
 M3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pg0qPK/7ic2gH9jCLEPOmJCLbTatvZOgY7K0zD6ap84=;
 b=tGXAQhGPVjlwp/hyqxKoRhOQs9H5ARBgReKI7jY77mcCIcV3zGrMyCsPUuS8B+L8Dk
 pE5K9A69L4ozY1m9cZu6u7Aa+Z1MQDULlFemQ5qd/Lug0m/aD/vYy7Vdu5WY2npcwchf
 Mryi2WXrMbo02YW7loYaebxM5Urycl83Htm231Pk8Hgs0fJFEkUPCOQ+WbG9w9uYTeYp
 QmMclzF7uprfkO5WcFH0uVsL/HAa4+dMPLCnIU9KUOgDmR4AF5fMal2vJOAue371cTVX
 6tIJdPkAmRuA7aqpNlphIW08rD9LMlcQ6fBrHKi5vMAFBCfSGPet3d52YQ60rT2K7v7E
 XL9w==
X-Gm-Message-State: AHQUAuYNH91sygnRMevfOw9kv9UWp5XRKWajgJDfmzO3wS4AqHRZ0QPG
 wxkLGeHGenCGEQFZfogD5rENy0KQ
X-Google-Smtp-Source: AHgI3IafQmx5S97alHBOL+5ck2HzfLd15NpluXmi1je7R91f/uutzucXtPLr56bjrFDKMrKTFXNxfg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr5440121wmk.152.1550926954757; 
 Sat, 23 Feb 2019 05:02:34 -0800 (PST)
Received: from [192.168.1.18] (bkp90.neoplus.adsl.tpnet.pl. [83.28.183.90])
 by smtp.gmail.com with ESMTPSA id l129sm2918259wml.42.2019.02.23.05.02.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:02:34 -0800 (PST)
Subject: Re: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led
 device driver
To: Rob Herring <robh@kernel.org>, Stefan Mavrodiev <stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-4-stefan@olimex.com> <20190222195109.GA17753@bogus>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <07d9d8f2-6263-8966-19da-ecaa761b3db9@gmail.com>
Date: Sat, 23 Feb 2019 14:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222195109.GA17753@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050237_033717_FFD3DB05 
X-CRM114-Status: GOOD (  21.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/22/19 8:51 PM, Rob Herring wrote:
> On Fri, Feb 15, 2019 at 01:50:08PM +0200, Stefan Mavrodiev wrote:
>> This adds the devicetree bindings for charge led indicator found
>> on most of X-Powers AXP20X PMICs.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
>> new file mode 100644
>> index 000000000000..5a83ad06796d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
>> @@ -0,0 +1,74 @@
>> +Device Tree Bindings for LED support on X-Powers PMIC
>> +
>> +Most of the X-Powers PMICs have integrated battery charger with LED indicator.
>> +The output is open-drain, so the state is either high-Z or output-low. The
>> +driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
>> +other cells.
>> +The LED can be controlled either manually or automatically. Then in automatic
>> +(controlled by the charger) there are two indication modes:
>> +
>> +Mode-A
>> +======
>> +- output-low:		Charging
>> +- high-Z		Not charging
>> +- 1Hz flashing:		Abnormal alarm
>> +- 4Hz flashing		Overvoltage alarm
>> +
>> +Mode-B
>> +======
>> +- output-low:		Battery full
>> +- high-Z		Not charging
>> +- 1Hz flashing:		Charging
>> +- 4Hz flashing		Overvoltage or abnormal alarm
>> +
>> +The control and the mode can be changed from sysfs.
>> +
>> +For AXP20X MFD bindings see:
>> +Documentation/devicetree/bindings/mfd/axp20x.txt
>> +
>> +Required properties:
>> +- compatible : Must be "x-powers,axp20x-led"
>> +
>> +Supported common LED properties, see ./common.txt for more informationn
>> +- label : See Documentation/devicetree/bindings/leds/common.txt
>> +- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
>> +- default-state: See Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Optional properties:
>> +- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
>> +			 If omitted, then the control is set to manual mode.
>> +			 On invalid value, Mode-A is used.
>> +
>> +
>> +Example:
>> +
>> +	axp803: pmic@3a3 {
>> +		compatible = "x-powers,axp803";
>> +
>> +		...
>> +
>> +		led@0 {
> 
> What's the 0 for? A unit address without a reg property is not valid.

It was done on my request, but now I see it was an omission.

Since this node describes a LED controller, then it should
be called "led-controller".

>> +			compatible = "x-powers,axp20x-led";
>> +			status = "okay";

And below part should be in a child node.

Stefan, please compare
Documentation/devicetree/bindings/leds/common.txt and
other LED bindings.

>> +			label = "axp20x:yellow:chgled";

Moreover "axp20x:" part should be removed from here added in the driver.

Please refer to drivers/leds/leds-cr0014114.c on how we
do that now.

>> +			linux,default-trigger = "timer";
>> +			default-state = "on";
>> +		};
>> +	};
>> +
>> +or
>> +
>> +	axp803: pmic@3a3 {
>> +		compatible = "x-powers,axp803";
>> +
>> +		...
>> +
>> +		led@0 {
>> +			compatible = "x-powers,axp20x-led";
>> +			status = "okay";
>> +
>> +			label = "axp20x:yellow:chgled";
>> +			x-powers,charger-mode = <1>;
>> +		};
>> +	};
>> -- 
>> 2.17.1
>>
> 

-- 
Best regards,
Jacek Anaszewski

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
