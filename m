Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CC420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MTcrPYKL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0yeEVCrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CC420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V/PYpaiswUr7LWR9ZFAlNhZ8pZDmeylsL/zYbSb8xKY=; b=MTcrPYKLvnFWtS
	DoyIZRYrUgepLbTdzJYRbYVo2MJWDJK40zz2nv0psBHrMcywD8csaxrvko5bL9pJs58oA8+Y0x8ig
	kb+M/f04EUaX+qWQoMMbCCYcaHMOsUWTdulhnaku9x+kZ1rDitJJkfk9mN8vzR8Q0XidG2+Ft5yug
	WDz/rM6vFEN0CCrOqUlJ7FndxXMXRRjR5CSXL+kDLliSpvhC4v9mLWA1piGZ2yX48TaW30EWVLTHI
	wj+mvgIjabHDTcQPdTivAdmya+huN9mH3EGLPIs+asmdkCyTeVhpwS6Wyo12+mAOFlAkVsBMzk3CK
	NuW8+Syv4VduQi6HPj+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyKgE-0008OT-L9; Mon, 25 Feb 2019 18:08:42 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyKg9-0008NU-PH
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 18:08:40 +0000
Received: by mail-it1-x143.google.com with SMTP id z124so201086itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 10:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LuPrmiZn3Jzlwax8dphP4Ke/rqAVhfr7A6djLJF7N8U=;
 b=0yeEVCrUXwCCwnyAg6fEQtnUqEXilLkmBJ+FClhlMN7nr/r8yMhfy2NiTR6xpet1cG
 qtpKNE4S95cRAK/zU3TdlLs1VMxeM1WMNa4KaURM3h98psRaX7r4P4bMhp2UsBJbAFYn
 ruBSvRekcduqvemxKWT/4Dg+YrwqnghFU5kk6dj4IAYkwkVYCv1F5LgpFjKeC6Xd8vvM
 CxZJW5wiDJToV6cN8axLuOrIxq2CFNSD194DiLLTwO0r3kPvd8mozvVBkbAxEUQiiAgY
 j7nx5M1ym6Phwxk5pOGRfmfp0RX3ogazuvSBtHPdNxZHauHKHOqTZhP366PovyvTScCB
 OuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LuPrmiZn3Jzlwax8dphP4Ke/rqAVhfr7A6djLJF7N8U=;
 b=FNAR3dsjfgDbu079uhtB5kx6joDxWShzdMr7AV8gqzgX+2kPxuTS7Etq1fveGMcwbU
 cf4iljDSkPOUntcJUsAsEidvjDturRilbvmnCNTJ+1tyb6+1Wkdx+7bgWmMoimDOuzg2
 3Zj/+sEcRVgspgkxKUMuUottoTJQQ0tOxfxsLV66nMyndUMGmhv8s6HihOafkl9pfyTU
 j6qq1PStYuITwtpeqyJjMlEIiY1yr/QiDPsdNNNDF+uWmKgV+drKwwLJF01eogk6+yB4
 QlK4Dvxn8eZNyTMHr8hDUxOvMSak0MwFpxqb3XhDOCwe0gmWUtqyYnYr08JsWbHgwszC
 SCBA==
X-Gm-Message-State: AHQUAubBugchjWMutBkgpCd4bSew2zU3oq6CTcc+A6ds29icET3siiTI
 YYQmXBnsttHRHabiB9Q6SIhdkA==
X-Google-Smtp-Source: AHgI3IbBQhCvfL2ORtSpyhzVMuNflsynIaZvNjpfC/9T0I9+L59q+2e6+5WaEH8M8xDDDKxTFp1JxA==
X-Received: by 2002:a05:660c:fcc:: with SMTP id m12mr54707itn.25.1551118116238; 
 Mon, 25 Feb 2019 10:08:36 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
 by smtp.gmail.com with ESMTPSA id r17sm5356978ita.31.2019.02.25.10.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 10:08:35 -0800 (PST)
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
To: Hans de Goede <hdegoede@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
 <20190222163114.0f4488fe@xps13>
 <c847985c-7117-6b31-ae78-4467871714c8@redhat.com>
 <20190222170348.12e45f42@xps13>
 <09a58952-ca34-cbfb-d0a9-d6c9f8afcb8b@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd592577-c807-7e8f-1b08-7b28947c62c3@kernel.dk>
Date: Mon, 25 Feb 2019 11:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <09a58952-ca34-cbfb-d0a9-d6c9f8afcb8b@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_100837_969834_5B7B7D72 
X-CRM114-Status: GOOD (  22.93  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/22/19 9:10 AM, Hans de Goede wrote:
> Hi,
> 
> On 2/22/19 5:03 PM, Miquel Raynal wrote:
>> Hi Hans,
>>
>> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:52:55
>> +0100:
>>
>>> Hi,
>>>
>>> On 2/22/19 4:31 PM, Miquel Raynal wrote:
>>>> Hi Hans,
>>>>
>>>> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:26:01
>>>> +0100:
>>>>    
>>>>> Hi,
>>>>>
>>>>> On 2/22/19 3:53 PM, Miquel Raynal wrote:
>>>>>> Right now the ATA core only allows IPs to use a single interrupt. Some
>>>>>> of them (for instance the Armada-CP110 one) actually has one interrupt
>>>>>> per port. Add some logic to support such situation.
>>>>>>
>>>>>> We consider that either there is one single interrupt declared in the
>>>>>> main IP node, or there are per-port interrupts, each of them being
>>>>>> declared in the port sub-nodes.
>>>>>>
>>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>> ---
>>>>>>     drivers/ata/acard-ahci.c       |  2 +-
>>>>>>     drivers/ata/ahci.c             |  2 +-
>>>>>>     drivers/ata/ahci.h             |  3 +-
>>>>>>     drivers/ata/libahci.c          |  2 +-
>>>>>>     drivers/ata/libahci_platform.c | 66 ++++++++++++++++++++++++++++------
>>>>>>     drivers/ata/sata_highbank.c    |  2 +-
>>>>>>     6 files changed, 61 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
>>>>>> index 583e366be7e2..9414b81e994c 100644
>>>>>> --- a/drivers/ata/acard-ahci.c
>>>>>> +++ b/drivers/ata/acard-ahci.c
>>>>>> @@ -434,7 +434,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>>>>>>     	if (!hpriv)
>>>>>>     		return -ENOMEM;
>>>>>>     > -	hpriv->irq = pdev->irq;
>>>>>> +	hpriv->irqs[0] = pdev->irq;
>>>>>>     	hpriv->flags |= (unsigned long)pi.private_data;
>>>>>>       >> What code-path is going to alloc hpriv->irqs for drivers using this code-path
>>>>> which are not using libahci_platform .c ?
>>>>
>>>> I don't understand the question (or the remark behind the question),
>>>> can you explain a little bit more what you have in mind?
>>>
>>> Sorry I got the code context wrong I meant to put that comment below this chunk:
>>>
>>>   > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>   > index 021ce46e2e57..18bce556d85f 100644
>>>   > --- a/drivers/ata/ahci.c
>>>   > +++ b/drivers/ata/ahci.c
>>>   > @@ -1817,7 +1817,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>   >   		/* legacy intx interrupts */
>>>   >   		pci_intx(pdev, 1);
>>>   >   	}
>>>   > -	hpriv->irq = pci_irq_vector(pdev, 0);
>>>   > +	hpriv->irqs[0] = pci_irq_vector(pdev, 0);
>>>   >
>>>   >   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>>>   >   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>>>
>>>
>>> Which AFAIK is a common code-path also used by ahci drivers not using
>>> libahci_platform, and in that case hpriv->irqs will be NULL as nothing
>>> initializes it.
>>
>> Oh I see. What do you prefer:
>> 1/
>> * I add "irqs" besides "irq" in the structure
>> * copy the value of irq in irqs[0]
>> * use irqs instead of irq in the libahci_platform ?
>> or
>> 2/
>> * Allocated one irq there if there is none ?
> 
> I don't really have a preference, Jens what is your take on this?

Single array would be the cleanest, don't add an irqs[] beside the
irq.

-- 
Jens Axboe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
