Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744D22084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K472S5tH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x+cJFl7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QKsoIo4Nofef5H8XdCl1PtvB4diF8Yi16rllCsJuzOc=; b=K472S5tHsPPzS5
	Qsrvtx9PJvGdM9eO59k1zlxOyk7MH9RasaGt0emVYUn/mr2KF23C1zreLscHt2b+qShUC2kYN/tMt
	NwEnVEdXlPdoikuZ6JWVYCG+B30FdTBy8fDDILcv220FvY5HV7kOoKgTG4pLG82zE326dpHJcBqlY
	Ze2tSk+wcnhG6owv/v1Q89G4aKBj6t7LmKyliN6NjrI1osTYFXhqDQf6IBZ2u2B4DeHFcvXPzF7+V
	pnYPO7rtDaDcumXNuKdWuIo4P0YTDsHGpUV/Ai8dfH6NQ7VD6Ja6Gk1BG+FsNfAhDSAUvR2+omh3M
	SUTnk7ml9amEaUUKwj8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gywBv-00055Q-K0; Wed, 27 Feb 2019 10:11:55 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gywBl-0004vs-5J; Wed, 27 Feb 2019 10:11:46 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1RABV7i038275;
 Wed, 27 Feb 2019 04:11:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1551262291;
 bh=Qs2liJLGMWU770amCHkKQGol3ULiosdr5P4zmUSVilE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=x+cJFl7XHAd/Q0VcdtIi6a3sonDFIYCRG0lSyNGNXD1rBuSwWoyUsKj5CBB/8cGQJ
 BTh8FkhIeitAPTuAYeJGGNyMW8omGiGwSOa8PnS1c2AgODdB2zMDVx1OGwMED8nf45
 kHbZPsV1+ELWHypXKR+5FcUJvOyWC1ux3B5a+Ff8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1RABVYr024897
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Feb 2019 04:11:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 27
 Feb 2019 04:11:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 27 Feb 2019 04:11:30 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1RABPY8002039;
 Wed, 27 Feb 2019 04:11:26 -0600
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To: Boris Brezillon <bbrezillon@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
 <3952b327-3aff-a32e-4280-6ab24c32cfd9@ti.com>
 <20190227105937.527c6573@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <acde502c-63fb-e272-d701-4ee63eac4eaa@ti.com>
Date: Wed, 27 Feb 2019 15:42:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227105937.527c6573@kernel.org>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_021145_286488_E5721769 
X-CRM114-Status: GOOD (  23.73  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Nori, Sekhar" <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 27/02/19 3:29 PM, Boris Brezillon wrote:
> On Wed, 27 Feb 2019 15:22:19 +0530
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> On 26/02/19 11:46 PM, Sergei Shtylyov wrote:
>>> On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
>>>   
>
[...]
>>>> + */
>>>> +
>>>> +struct hb_device {
>>>> +	struct map_info map;
>>>> +	struct device *dev;
>>>> +	struct device_node *np;
>>>> +	struct mtd_info *mtd;
>>>> +	struct hb_ops *ops;
>>>> +	enum hb_memtype memtype;
>>>> +	bool needs_calib;
>>>> +	bool registered;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct hb_ops - struct representing custom Hyperbus operations
>>>> + * @read16: read 16 bit of data, usually from register/ID-CFI space
>>>> + * @write16: write 16 bit of data, usually to register/ID-CFI space
>>>> + * copy_from: copy data from flash memory
>>>> + * copy_to: copy data to flash_memory
>>>> + */
>>>> +
>>>> +struct hb_ops {
>>>> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
>>>> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
>>>> +
>>>> +	void (*copy_from)(struct hb_device *hbdev, void *to,
>>>> +			  unsigned long from, ssize_t len);
>>>> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
>>>> +			const void *from, ssize_t len);  
>>>
>>>    ... else these methods won't fly if you need to "massage" the controller
>>> registers inside them...
>>>   
>>
>> If accessing controller register is the only need, wouldn't a private
>> data pointer within struct hb_device be sufficient to hold pointer to
>> controller specific struct?
>>
>> struct hb_device {
>> 	...
>> 	void *priv; /* points to controller's private data */
>> };
>>
>>
>> Or do you see a need for separate structure for the HyperBus controller?
> 
> Sorry to chime in. Just want to share my experience here: properly
> splitting the controller/device representation is always a good thing.
> When it's not done from the beginning and people start to add their own
> controller drivers as if it was a flash device driver it becomes messy
> pretty quickly and people add hacks to support that (look at the raw
> NAND framework if you need a proof). So, I'd recommend having this
> separation now, even if the onle controllers we support have a 1:1
> relationship between HB controller and HB device.
> 
>>

Alright, will separate controller and slave representation. Thanks for
the feedback!


-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
