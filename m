Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC2B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQbIVxRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC2B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Id4wkJQIFClz+w21QYPGrGeq/Sm+LYDPB7uJXltGsIo=; b=VQbIVxRq+GJ+zHCjt95MYPoYp
	RQlFeoMCGZ71wQd3Ng8LrBToAeLwk8XWawgePq2VAqaF6I7E4foLGHeMse6DNEHP/VTOqBaNhDvTA
	qWIH+R6ziLVm5wdyvXUhORbFVIU48coTM7GS5/l/NY4kXfjKC8yaM9xjt28T/c5UNfSEG2Hek/xWw
	Ltm7vFiiLasRD0wZjrMB/1cXwD/0KJJdBCN9YTDMBaxG8E0RraWQ3+h82O9xWZNXDr/coaYPpoMbi
	eOxt1IZ3zMAIc81ucB8rkbsaUOiXWCEhWqiRgGboZVunlHmDbzy5FAF61Ea1bohioWfD2jLQ/lzVO
	3zQ8wba/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0AC-0005S7-NM; Tue, 04 Dec 2018 02:10:16 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0A8-00049d-R1; Tue, 04 Dec 2018 02:10:14 +0000
Received: from [10.28.18.81] (10.28.18.81) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec 2018
 10:10:22 +0800
Subject: Re: [PATCH] pinctrl: meson: fix G12A ao pull registers base address
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>, <linus.walleij@linaro.org>,
 <linux-gpio@vger.kernel.org>
References: <20181203030533.10989-1-xingyu.chen@amlogic.com>
 <a240773f-7b05-d950-e5e9-23d7983c7f35@baylibre.com>
 <f2ceff1edcb2c103d0128a838ff630bb3c147bf5.camel@baylibre.com>
From: Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <e0fd351c-91ee-b662-80d6-ac4d2a8b6cb0@amlogic.com>
Date: Tue, 4 Dec 2018 10:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <f2ceff1edcb2c103d0128a838ff630bb3c147bf5.camel@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.81]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_181012_879807_26A085C4 
X-CRM114-Status: GOOD (  20.56  )
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
Cc: robh@kernel.org, jianxin.pan@amlogic.com,
 martin.blumenstingl@googlemail.com, khilman@baylibre.com,
 linux-kernel@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
 carlo@caione.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/3 18:36, Jerome Brunet wrote:
> On Mon, 2018-12-03 at 11:27 +0100, Neil Armstrong wrote:
>> Hi Xingyu,
>>
>>
>> On 03/12/2018 04:05, Xingyu Chen wrote:
>>> Since Meson G12A SoC, Introduce new ao registers AO_RTI_PULL_UP_EN_REG
>>> and AO_GPIO_O.
>>>
>>> These bits of controlling output level are remapped to the new register
>>> AO_GPIO_O, and the AO_GPIO_O_EN_N support only controlling output enable.
>>>
>>> These bits of controlling pull enable are remapped to the new register
>>> AO_RTI_PULL_UP_EN_REG, and the AO_RTI_PULL_UP_REG support only controlling
>>> pull type(up/down).
>>>
>>> The new layout of ao gpio/pull registers is as follows:
>>> - AO_GPIO_O_EN_N        [offset: 0x9 << 2]
>>> - AO_GPIO_I             [offset: 0xa << 2]
>>> - AO_RTI_PULL_UP_REG    [offset: 0xb << 2]
>>> - AO_RTI_PULL_UP_EN_REG [offset: 0xc << 2]
>>> - AO_GPIO_O             [offset: 0xd << 2]
>>>
>>>  From above, we can see ao GPIO registers region has been separated by the
>>> ao pull registers. In order to ensure the continuity of the region on
>>> software, the ao GPIO and ao pull registers use the same base address, but
>>> can be identified by the offset.
>>>
>>> Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
>>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>   drivers/pinctrl/meson/pinctrl-meson.c | 22 ++++++++++++----------
>>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c
>>> b/drivers/pinctrl/meson/pinctrl-meson.c
>>> index 53d449076dee..7ff40cd7a0cb 100644
>>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>>> @@ -31,6 +31,9 @@
>>>    * In some cases the register ranges for pull enable and pull
>>>    * direction are the same and thus there are only 3 register ranges.
>>>    *
>>> + * Since Meson G12A SoC, the ao register ranges for gpio, pull enable
>>> + * and pull direction are the same, so there are only 2 register ranges.
>>> + *
>>>    * For the pull and GPIO configuration every bank uses a contiguous
>>>    * set of bits in the register sets described above; the same register
>>>    * can be shared by more banks with different offsets.
>>> @@ -487,23 +490,22 @@ static int meson_pinctrl_parse_dt(struct
>>> meson_pinctrl *pc,
>>>   		return PTR_ERR(pc->reg_mux);
>>>   	}
>>>   
>>> -	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
>>> -	if (IS_ERR(pc->reg_pull)) {
>>> -		dev_err(pc->dev, "pull registers not found\n");
>>> -		return PTR_ERR(pc->reg_pull);
>>> +	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
>>> +	if (IS_ERR(pc->reg_gpio)) {
>>> +		dev_err(pc->dev, "gpio registers not found\n");
>>> +		return PTR_ERR(pc->reg_gpio);
>>>   	}
>>>   
>>> +	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
>>> +	/* Use gpio region if pull one is not present */
>>> +	if (IS_ERR(pc->reg_pull))
>>> +		pc->reg_pull = pc->reg_gpio;
>>> +
>>>   	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
>>>   	/* Use pull region if pull-enable one is not present */
>>>   	if (IS_ERR(pc->reg_pullen))
>>>   		pc->reg_pullen = pc->reg_pull;
>>>   
>>> -	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
>>> -	if (IS_ERR(pc->reg_gpio)) {
>>> -		dev_err(pc->dev, "gpio registers not found\n");
>>> -		return PTR_ERR(pc->reg_gpio);
>>> -	}
>>> -
>>>   	return 0;
>>>   }
>>>   
>>>
>> Doesn't it need an update of the bindings ?
> 
> Going even further, shouldn't we stop trying make multiple regions out of
> this, and have just one ?
> 
> On all the Amlogic SoC we have seen so far, all the regions a very (VERY)
> close to each other. It seems very unlikely that there something unrelated to
> GPIO in between.
> 
> It looks like everything is mostly there in the driver to deal with offset, so
> change would be minimal.
> 
> Of course, for  DT stability we will need to carry the legacy, but for newer
> SoC, such as the g12, does it really makes sense to have multiple regions ?
> 
Hi, Jerome
the ee gpio, pull and pull-en register regions are discontinuous, some 
addresses are reserved between them and maybe used for other module. For 
example [G12A]:
range of gpio register address offset:    (0x010 << 2) - (0x022 << 2)
range of pull register address offset:    (0x03a << 2) - (0x03f << 2)
range of pull-en register address offset: (0x048 << 2) - (0x04d << 2)

keeping the multiple register regions seems to be more flexible and 
friendly for Meson Series SoCs at present.

>>
>> Neil
>>
> 
> 
> .
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
