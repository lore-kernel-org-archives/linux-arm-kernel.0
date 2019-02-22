Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F4920665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TtXIZMF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F4920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lPbk4LMEKRR11PsPuuSLQaV90/hVeJtUJLSusY6bZEc=; b=TtXIZMF2N41g7mAsmvzlMXRHT
	Gi8r1Z4PpilY3RTPBMINLpqXCzRQQ6CNGbwl/U16eF+TDzs9kgeZSGseXjtD2xISCzc+PcVmg+Wg6
	jMPyoFowqj4VihKussiB2d1sLJvEe38zwydw6wMwirPlwPKtuQ758Pm55gOAZ+1z539itZT8Q9DZP
	fe6O7ufNLD0lPeMWvP7ewyeyZm9txQPWcgaYB18qOGQy0YVuMtzVCCQPpjpNrdzjUJdzYXGpm2ZFR
	EMDiDlPieuBLu8LpjHWTagcgbwSrTX+ISwdWb+1x9zItsSmQ5TWWD6WEGaVSea6lkZKQ0qDUwd979
	IwfQjQ5iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDOs-0001hL-KR; Fri, 22 Feb 2019 16:10:10 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDOp-0001Bc-49
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:10:09 +0000
Received: by mail-wm1-f68.google.com with SMTP id j125so2468754wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 08:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SkHceDxYf4rP12qW8Jn8fWD+4xVQyxdG2zrwdDGtECo=;
 b=WOzqjN/MqtKGBVvS/gEvRmcxPE0lhLbScnXz5SYXRpit4VHWtHTr1q6dj1ZHDin91q
 26B367oE8PUG/y34dloUYMmG2TrbRqjAbn8g/0n4CwPSM6q1YCxXC5bn33QfzqQp/3/r
 CkrJnJfeWi4os8TcnzMWB/lFihNRTrUqUm04Fe3bcrC8JXuW5jwV4WQ/wX/zN7ZgQu78
 954OrAzQLAAxBOkvWaaZYC2c5Bp//+jIZ1BBPUxiqSuIvnsb2aIzrSDJvFjOFq4ZgdAF
 sUUSBCtmPtS9gD6WZ4dkHZBSkm280gzoFPO5EW1edVwGRsX6DBc++AdhUulRL8yDREeU
 xJcg==
X-Gm-Message-State: AHQUAubRO/z0M6gct6Yx9ImJzP/eoprbh2NQGlq1o/tIjjzijzbt9QT8
 2E8gtKLFP70MkDVprMyjFnsRlA==
X-Google-Smtp-Source: AHgI3Ibqj4skwjD05bQYPu/HSv9PjIdG275t6ZQMZ9IorOQFJUDhMwBpfq3F7hamnCaQh+Lv4rb/pQ==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr3185461wma.66.1550851805378; 
 Fri, 22 Feb 2019 08:10:05 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl
 ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
 by smtp.gmail.com with ESMTPSA id 132sm2916005wmd.30.2019.02.22.08.10.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 08:10:04 -0800 (PST)
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
 <20190222163114.0f4488fe@xps13>
 <c847985c-7117-6b31-ae78-4467871714c8@redhat.com>
 <20190222170348.12e45f42@xps13>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <09a58952-ca34-cbfb-d0a9-d6c9f8afcb8b@redhat.com>
Date: Fri, 22 Feb 2019 17:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222170348.12e45f42@xps13>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_081007_172230_E72960DF 
X-CRM114-Status: GOOD (  24.60  )
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
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/22/19 5:03 PM, Miquel Raynal wrote:
> Hi Hans,
> 
> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:52:55
> +0100:
> 
>> Hi,
>>
>> On 2/22/19 4:31 PM, Miquel Raynal wrote:
>>> Hi Hans,
>>>
>>> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:26:01
>>> +0100:
>>>    
>>>> Hi,
>>>>
>>>> On 2/22/19 3:53 PM, Miquel Raynal wrote:
>>>>> Right now the ATA core only allows IPs to use a single interrupt. Some
>>>>> of them (for instance the Armada-CP110 one) actually has one interrupt
>>>>> per port. Add some logic to support such situation.
>>>>>
>>>>> We consider that either there is one single interrupt declared in the
>>>>> main IP node, or there are per-port interrupts, each of them being
>>>>> declared in the port sub-nodes.
>>>>>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> ---
>>>>>     drivers/ata/acard-ahci.c       |  2 +-
>>>>>     drivers/ata/ahci.c             |  2 +-
>>>>>     drivers/ata/ahci.h             |  3 +-
>>>>>     drivers/ata/libahci.c          |  2 +-
>>>>>     drivers/ata/libahci_platform.c | 66 ++++++++++++++++++++++++++++------
>>>>>     drivers/ata/sata_highbank.c    |  2 +-
>>>>>     6 files changed, 61 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
>>>>> index 583e366be7e2..9414b81e994c 100644
>>>>> --- a/drivers/ata/acard-ahci.c
>>>>> +++ b/drivers/ata/acard-ahci.c
>>>>> @@ -434,7 +434,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>>>>>     	if (!hpriv)
>>>>>     		return -ENOMEM;
>>>>>     > -	hpriv->irq = pdev->irq;
>>>>> +	hpriv->irqs[0] = pdev->irq;
>>>>>     	hpriv->flags |= (unsigned long)pi.private_data;
>>>>>       >> What code-path is going to alloc hpriv->irqs for drivers using this code-path
>>>> which are not using libahci_platform .c ?
>>>
>>> I don't understand the question (or the remark behind the question),
>>> can you explain a little bit more what you have in mind?
>>
>> Sorry I got the code context wrong I meant to put that comment below this chunk:
>>
>>   > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>   > index 021ce46e2e57..18bce556d85f 100644
>>   > --- a/drivers/ata/ahci.c
>>   > +++ b/drivers/ata/ahci.c
>>   > @@ -1817,7 +1817,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   >   		/* legacy intx interrupts */
>>   >   		pci_intx(pdev, 1);
>>   >   	}
>>   > -	hpriv->irq = pci_irq_vector(pdev, 0);
>>   > +	hpriv->irqs[0] = pci_irq_vector(pdev, 0);
>>   >
>>   >   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>>   >   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>>
>>
>> Which AFAIK is a common code-path also used by ahci drivers not using
>> libahci_platform, and in that case hpriv->irqs will be NULL as nothing
>> initializes it.
> 
> Oh I see. What do you prefer:
> 1/
> * I add "irqs" besides "irq" in the structure
> * copy the value of irq in irqs[0]
> * use irqs instead of irq in the libahci_platform ?
> or
> 2/
> * Allocated one irq there if there is none ?

I don't really have a preference, Jens what is your take on this?

Regards,

Hans


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
