Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF225C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:26:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE3020842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vAXYNygW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r00p6xUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE3020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vs9U7X39bjqjDdhkEbap3c0JSDUPDbWi8weH4/o+7Jc=; b=vAXYNygWPYdlWJ
	rNnSQZ8grzCB2yLu6AkoQXZj5/XrZgl0c5E0RljbWe9iS/jN/l33pmjTTBAE2Lt1w3Nhqj96pVcMl
	PI53CA2KWWCBd7yClon65EzooJTrxSjRoEfwnGQ3yY46Lfkr1TE+fr3fnkc+DFnqjSNANHK7QJKh/
	h+EnkENFx1/hVBgpMyBBfkrp7/5/Fh7HhoeAKMP+fEa4S3NR5QkXwYq6OQpwSJtwBDZ/6g/1SvbIT
	pxRgTiKBmSVCpx5bVxnN3CpiF2j5B1SB9TlJuyrY9eCV7Jy7bwp41w5rYXLDaBjwSy3De4CLobCT1
	o/+hu1lSvd/DwwnS0rkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyZwA-00012W-BX; Tue, 26 Feb 2019 10:26:10 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyZw0-0000u7-D1; Tue, 26 Feb 2019 10:26:02 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QAPoJH091285;
 Tue, 26 Feb 2019 04:25:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1551176750;
 bh=T372Cq9lmdmNNtnM60Jq1siPeD7EEYNpMZ4m+HjOyVU=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=r00p6xUlliasczHLu3wqbzN/oHU5zeSWA2ctj/8UPczMm+ug6DLj+dsX/fdsKlVJ4
 ugKyVt9O7/n24gQC0xt7v1T7XDIkZo26/W2M/6yOTryzQJNvtrfN9EwGDS3artQG5+
 feE/j8wn5uM/AiUWNOMMWnEhIUlYTyvUq6o9TxF4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QAPogY117052
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Feb 2019 04:25:50 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 04:25:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 04:25:49 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QAPixE030514;
 Tue, 26 Feb 2019 04:25:45 -0600
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris
 Brezillon <bbrezillon@kernel.org>, Marek Vasut <marek.vasut@gmail.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
 <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
 <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <1137312b-c326-9e41-4667-e2126649f384@ti.com>
Date: Tue, 26 Feb 2019 15:56:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_022600_524659_8BB1ED14 
X-CRM114-Status: GOOD (  24.04  )
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
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Nori,
 Sekhar" <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 26/02/19 1:03 AM, Sergei Shtylyov wrote:
> On 02/25/2019 09:21 PM, Vignesh R wrote:
> 
> [...]
> 
>>>> HyperBus specification can be found at[1]
>>>> HyperFlash datasheet can be found at[2]
>>>>
>>>> [1] https://www.cypress.com/file/213356/download
>>>> [2] https://www.cypress.com/file/213346/download
>>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>>     Table 12-5741. HyperFlash Access Sequence
>>>>
>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [...]
>>>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>>>> new file mode 100644
>>>> index 000000000000..d3d44aab7503
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/hyperbus/core.c
> [...]
>>>> +int hb_register_device(struct hb_device *hbdev)
>>>> +{
>>>> +	struct resource res;
>>>> +	struct device *dev;
>>>> +	struct device_node *np;
>>>> +	struct map_info *map;
>>>> +	struct hb_ops *ops;
>>>> +	int err;
>>>> +
>>>> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
>>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	np = hbdev->np;
>>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	hbdev->memtype = HYPERFLASH;
>>>> +
>>>> +	if (of_address_to_resource(np, 0, &res))
>>>
>>>     Isn't the direct mapping property of the HF controller, not of HyperFlash
>>> itself?
>>>
>>
>> As I said in the cover letter, I could not find many examples of HF
>> controllers, but couple of them that I studied provide MMIO access to
>> flash. So, reg property of flash node would represent local address on
>> the HyperBus and controller node would set up ranges properly to provide
>> translation from CS to SoC address space.
>> For example see patch 4/5 where reg property would indicate CS and Size
>> of flash. This scheme is similar to whats described here [1]
>> HBMC controllers usually have different MMIO regions to access flashes
>> connected to different CS. So using ranges for address translation along
>> with flash node describing local address works pretty well.
>>
>> My understanding is that this part of code will be common for most MMIO
>> based HB controllers and hence made part of core layer. But, if
>> controllers uses different IO space for read vs write, then this needs a
>> bit of thinking. In that case, mapping needs to be moved to controller
>> drivers.
>>
>> [1]https://elinux.org/Device_Tree_Usage#Ranges_.28Address_Translation.29
>>
>>>> +		return -EINVAL;
>>>> +
>>>> +	dev = hbdev->dev;
>>>> +	map = &hbdev->map;
>>>> +	map->size = resource_size(&res);
>>>> +	map->virt = devm_ioremap_resource(dev, &res);
>>>> +	if (IS_ERR(map->virt))
>>>> +		return PTR_ERR(map->virt);
>>>> +
>>>> +	map->name = dev_name(dev);
>>>> +	map->bankwidth = 2;
>>>> +
>>>> +	simple_map_init(map);
>>>
>>>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
>>> mappings in the separate memory resources.
>>>
>>
>> Hmm, could you point me to public datasheet of the controller?
> 
>    See chapter 20 in [1]. Note that it's not the same SoC I'm developing for (R-Car
> gen3 family, with NDA docs) but should be mostly the same RPC-IF core.
> 
> [1] https://www.renesas.com/us/en/doc/products/mpumcu/doc/rz/r01uh0746ej0200-rza2m.pdf?key=74862185b5e22ad09e648d21a35de615

Thanks for the info!

> 
>> simple_map_init() provides default implementation for map operations
>> which is overridden, if hb_ops is populated.
>> I think, Renesas RPC-IF can populate custom hb_ops struct and use
>> appropriate MMIO base for read vs write, while still reusing the map
>> framework. Wouldnt that work?
> 
>    It probably would...
> 


Looking at above link, I see there are two HBMC controllers on Renesas
SoC. One is a dedicated HBMC controller(chapter 21) very similar to that
on TI SoC and a SPI Multi I/O Bus Controller (chapter 20) that also
supports Hyperbus protocol.

AFAICS, passing custom hb_ops is good enough to support both HW needs.
Let me know if something is missing. I would greatly appreciate if you
could test this series with your HW.



-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
