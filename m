Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A059B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njETe/cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A059B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WqDAjjWgYGFAC7OntbGLsscQXBOajVxvzZPoY0qpTwI=; b=njETe/cBsoH3aEr+S5QVuQtt9
	R+KPuT79O2tApmVhxPOgJMv+rsMVKYMe6N3JMp1gV/zw4UpQvaMLtkTvkUkP/4AYIz3WEIBc1u33P
	0Z+nOay02qXBNlnF0FiJYPtJaUlgWr/8yKHwrmIsQdkTiq9QeRoyI2U7iKiuO5hde/Cv9d5/FlyiM
	ngwfVzxv9Jp2RZ6CmhpmFGCvvgiWVMDHx0pNZdhHmkNaYEI5Mw9CNmHPAQA2hkEmP/v0D/yv6jm1X
	tdM1C0bUAtwKwcQKk9TgnQysXqLc4lgYiN5XQNfF76SRAvqSBOBJ9V6nyiNtGTjdT6VpTxBfHJUiV
	PtH3M31yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpds-0005Vj-Iy; Mon, 03 Dec 2018 14:56:12 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpdo-0005Ul-S6
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:56:10 +0000
Received: by mail-ed1-f66.google.com with SMTP id f9so4530462eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 06:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXqCRHYkVkZXNFZ2/gMd/fM+paR1Au2ZW6ox8oxBoRM=;
 b=mFIAlx0ehd36irwJ5nmwts+VrazEPKuvnjvtZdcoA22IQMf9rDw7acBee17gNaKSc3
 QIFCC6ihleLJ3c3RFfXTYnehpyYSRKND36/jdiBcRphOvcwml5jcJ+fVOoFfmdE563OD
 /Ng7I4HQ55R4jlFkM+QnarxpwkUcNjQLObSpAkdBRo8XzA9Tuc3jx4WviIQz439wPqmV
 hl/Rrdl4AszI5I4ukJa9gdlKQYzftquc/Z3OEpMC4jvJfrewhIClA2u1czE5wGqDR/u7
 XIvpnxuh44DkRM2dIvPH8ZQdWnmwRgsdA7XP76nR5VDzeJAc1c/hxmTlMLMxgnLY9T5+
 d5DA==
X-Gm-Message-State: AA+aEWYVpbpYSGF1c+mLZif03UhRlb5Y5L0lvkZnMdrfrlvDctAqI+5E
 5JpZgOuA6KNjlERNbyUE/WfLiw==
X-Google-Smtp-Source: AFSGD/Wdy1N9UqJ7tsy4f5BeSWpvTOVwWGc93UuIvD/ypkqJy4H2zdRY81U7KTVm54pNvOdUcJcv1g==
X-Received: by 2002:a50:8f86:: with SMTP id y6mr15377367edy.131.1543848956967; 
 Mon, 03 Dec 2018 06:55:56 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id d5sm3999508edb.48.2018.12.03.06.55.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 06:55:56 -0800 (PST)
Subject: Re: [PATCH v2 1/6] ata: libahci_platform: comply to PHY framework
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
 <20181130153833.11421-2-miquel.raynal@bootlin.com>
 <0517746d-3fca-db57-8dca-8976910dad9c@redhat.com>
 <20181203154635.3c6df0d3@xps13>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c57d8bc7-141d-a915-4d5e-8504c522b4fe@redhat.com>
Date: Mon, 3 Dec 2018 15:55:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181203154635.3c6df0d3@xps13>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065608_914535_44067E2C 
X-CRM114-Status: GOOD (  30.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 03-12-18 15:46, Miquel Raynal wrote:
> Hi Hans,
> 
> Hans de Goede <hdegoede@redhat.com> wrote on Sun, 2 Dec 2018 14:19:49
> +0100:
> 
>> Hi,
>>
>> On 30-11-18 16:38, Miquel Raynal wrote:
>>> Current implementation of the libahci does not take into account the
>>> new PHY framework. Correct the situation by adding a call to
>>> phy_set_mode() before phy_power_on() and by adding calls to
>>> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
>>>
>>> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Much better. Some remarks inline.
>>
>>> ---
>>>    drivers/ata/ahci.h             |  2 ++
>>>    drivers/ata/libahci_platform.c | 19 ++++++++++++++++++-
>>>    2 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>>> index ef356e70e6de..982638b37fee 100644
>>> --- a/drivers/ata/ahci.h
>>> +++ b/drivers/ata/ahci.h
>>> @@ -254,6 +254,8 @@ enum {
>>>    	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
>>>    							SATA_MOBILE_LPM_POLICY
>>>    							as default lpm_policy */
>>> +	AHCI_HFLAG_MANAGE_PHYS		= (1 << 26), /* let the core manage the
>>> +							PHYs when relevant */
>>
>> Using a hflag for this is a good idea, but the MANAGE_PHYS names is a bit
>> generic, even if this is not set then ahci_platform_enable_resources() will
>> still enable the phy. So I would name this AHCI_HFLAG_SUSPEND_PHYS to make
>> clear this only influences suspend/resume behavior.
> 
> I understand and will modify the HFLAG name as you suggest.
> 
>>
>> Also see below.
>>
>>>    	/* ap->flags bits */
>>>    > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 4b900fc659f7..f5a64eb1fea8 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>>>    		if (rc)
>>>    			goto disable_phys;
>>>    > +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
>>> +		if (rc) {
>>> +			phy_exit(hpriv->phys[i]);
>>> +			goto disable_phys;
>>> +		}
>>> +
>>>    		rc = phy_power_on(hpriv->phys[i]);
>>>    		if (rc) {
>>>    			phy_exit(hpriv->phys[i]);
>>> @@ -378,7 +384,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>>>     * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
>>>     *    or for non devicetree enabled platforms a single clock
>>>     * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
>>> - * 5) phys (optional)
>>> + * 5) phys (optional), PHY handling during suspend/resume will be skipped if the
>>> + *    flag AHCI_HFLAG_MANAGE_PHYS is missing.
>>>     *
>>>     * RETURNS:
>>>     * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
>>> @@ -458,6 +465,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>    		}
>>>    	}
>>>    > +	if (flags & AHCI_HFLAG_MANAGE_PHYS)
>>> +		hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
>>> +
>>>    	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>>    >   	/*
>>
>> Interpreting a flag passed to ahci_platform_get_resources using a
>> AHCI_HFLAG_* mask is asking for trouble in the future.
>>
>> Since you are using a hflag for this, you can just drop this chunk / change
>> and in the caller of ahci_platform_get_resources() do:
>>
>> 	hpriv = ahci_platform_get_resources(pdev, ...);
>> 	if (IS_ERR(hpriv))
>> 		...
>>
>> 	hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
>>
>> Settting hflags like this after calling ahci_platform_get_resources()
>> is already done in several place.
> 
> Indeed, this is close to my first draft but after re-reading your
> previous review I understood you wanted this flag to be passed to
> ahci_platform_get_resources().

Yes that was my initial thought, but sine you are using a hflag for
it that is no longer a good idea.

> I do agree that the current form is a bit redundant so I will let users
> add the flag manually during the probe after the
> ahci_platform_get_resources() call, as suggested.

Sounds good, thanks.

Regards,

Hans


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
