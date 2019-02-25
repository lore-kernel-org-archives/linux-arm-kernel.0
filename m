Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D229C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:33:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217D920842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imNaubb9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fbvQibqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217D920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l9e2zjBus3CDBnNrq39cgBz8jSAskQBE384G4MzWUWU=; b=imNaubb9LxJFQu
	6Fff8FmTbuWBmuKHmgS3535aXLJyDvClbNmbWwfmQkUmy/K6WgjLPwq0Mz4Mqmo5z87f0W16vPWGU
	lyxYTzfl9RqHwyOSeQ4S48Nvf3J5LJOQh7norrDE2/GVryDIflKXC+TB3dB64zRVhs+hdHKNhV6fX
	wHCBwBQcWhkivH/spCAYULRPIR0vfr0B/wdsXGLucn5jtIb4hYK9774e8jCbZe8f35plPebnbvxZ8
	Dy/4WF3I+diEL04sUsMlbrHUN/cbP50cA1WwN6uUbD/BRYyw4f5q1ledqvZDe9DiFQXqVQ9tAVGoY
	n9MrQuO31sHtgi9IVXEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyM0I-0005Im-7F; Mon, 25 Feb 2019 19:33:30 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyM0A-0005Hy-KN
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 19:33:24 +0000
Received: by mail-lj1-x243.google.com with SMTP id t13so4139011lji.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eX6EJTdHV8W5AjvTP6REm4fH1/SpIVw5AXuQai7r+rs=;
 b=fbvQibqKvsZ6TRQfCU6cGibqZcZ87dkwtjA8KtIPZ6wWDDn704Ai3q33CF+FYWFp1c
 sxWyiI9MXYFsIaoDQUeuHfpjNrWYoqijK1OEaLSWBKHhpSDvvpYxxKVmTMd+1GI4omWm
 22LCyZVVQG/NRJmjY8D8dym5KoSNrBHDpldadFcV0k5XWgOo561ObwwPgdFMdtAtap1X
 3l6HAXBEjULMRIwwuqlKs97RTSoaAD/XeICSI9VgvLN9rWGIcLEeV76PQM68ffaypbht
 RJwK4pdHwk9qKGVB95p88b7GnaCgiq9J3vazjHpU+xB/TOAUVYxGaG44oG6BmC6o4olr
 H5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eX6EJTdHV8W5AjvTP6REm4fH1/SpIVw5AXuQai7r+rs=;
 b=JFHl72oF9U4vWXg73xKb//DVjm3PadERZnGXrC0TegZWrM7WJkYrAOXxSY4x4WS1SP
 3KuFVEPKIW6I5bY2//oATU4eRQzosoioBjWtmgBj3yLucbKY4OHxkX7buoBxmQAvqvst
 tfHaqYi2dXXCmuJpObbOWAm8J8VP95ppHadUhmdnPkVUd+/SYH/eh5/PdSop3zHBnKh/
 3YnVSlrZmA5gCCFbTDIurzLcjcZO4+Wh991M0Otyv9I+PluO9TGWdzQTP9wYYGt/vnxH
 VT7DPgrtc62ANnEgB/I4kZxNF5TddpBdL5nTDiRyX2NKJty5bPD47ozqG/3fqqMlgDJV
 UtjA==
X-Gm-Message-State: AHQUAuboT+QzE2hj2bwxW1GYgKFs1WwVg2nlrZS3kRcfdYToOOIrnt6y
 gjzDGN6rSfPljWoLMJzZbOcvoW0VetE=
X-Google-Smtp-Source: AHgI3IbIilnOZiPAqOZ5AONrpIASHaGfLRcB3yWwGkOBQBfwSU28ZmV8PkOeMH01udfQTWuRrqP3bg==
X-Received: by 2002:a2e:98c8:: with SMTP id s8mr10931450ljj.84.1551123199758; 
 Mon, 25 Feb 2019 11:33:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.85])
 by smtp.gmail.com with ESMTPSA id j14sm2739819lfc.28.2019.02.25.11.33.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 11:33:18 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To: Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
 <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <95344724-214f-20b7-b629-149ddf396117@cogentembedded.com>
Date: Mon, 25 Feb 2019 22:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_113322_801241_A39638F9 
X-CRM114-Status: GOOD (  25.27  )
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

On 02/25/2019 09:21 PM, Vignesh R wrote:

[...]

>>> HyperBus specification can be found at[1]
>>> HyperFlash datasheet can be found at[2]
>>>
>>> [1] https://www.cypress.com/file/213356/download
>>> [2] https://www.cypress.com/file/213346/download
>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>     Table 12-5741. HyperFlash Access Sequence
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
[...]
>>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>>> new file mode 100644
>>> index 000000000000..d3d44aab7503
>>> --- /dev/null
>>> +++ b/drivers/mtd/hyperbus/core.c
[...]
>>> +int hb_register_device(struct hb_device *hbdev)
>>> +{
>>> +	struct resource res;
>>> +	struct device *dev;
>>> +	struct device_node *np;
>>> +	struct map_info *map;
>>> +	struct hb_ops *ops;
>>> +	int err;
>>> +
>>> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	np = hbdev->np;
>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>> +		return -ENODEV;
>>> +
>>> +	hbdev->memtype = HYPERFLASH;
>>> +
>>> +	if (of_address_to_resource(np, 0, &res))
>>
>>     Isn't the direct mapping property of the HF controller, not of HyperFlash
>> itself?
>>
> 
> As I said in the cover letter, I could not find many examples of HF
> controllers, but couple of them that I studied provide MMIO access to
> flash. So, reg property of flash node would represent local address on
> the HyperBus and controller node would set up ranges properly to provide
> translation from CS to SoC address space.
> For example see patch 4/5 where reg property would indicate CS and Size
> of flash. This scheme is similar to whats described here [1]
> HBMC controllers usually have different MMIO regions to access flashes
> connected to different CS. So using ranges for address translation along
> with flash node describing local address works pretty well.
> 
> My understanding is that this part of code will be common for most MMIO
> based HB controllers and hence made part of core layer. But, if
> controllers uses different IO space for read vs write, then this needs a
> bit of thinking. In that case, mapping needs to be moved to controller
> drivers.
> 
> [1]https://elinux.org/Device_Tree_Usage#Ranges_.28Address_Translation.29
> 
>>> +		return -EINVAL;
>>> +
>>> +	dev = hbdev->dev;
>>> +	map = &hbdev->map;
>>> +	map->size = resource_size(&res);
>>> +	map->virt = devm_ioremap_resource(dev, &res);
>>> +	if (IS_ERR(map->virt))
>>> +		return PTR_ERR(map->virt);
>>> +
>>> +	map->name = dev_name(dev);
>>> +	map->bankwidth = 2;
>>> +
>>> +	simple_map_init(map);
>>
>>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
>> mappings in the separate memory resources.
>>
> 
> Hmm, could you point me to public datasheet of the controller?

   See chapter 20 in [1]. Note that it's not the same SoC I'm developing for (R-Car
gen3 family, with NDA docs) but should be mostly the same RPC-IF core.

[1] https://www.renesas.com/us/en/doc/products/mpumcu/doc/rz/r01uh0746ej0200-rza2m.pdf?key=74862185b5e22ad09e648d21a35de615

> simple_map_init() provides default implementation for map operations
> which is overridden, if hb_ops is populated.
> I think, Renesas RPC-IF can populate custom hb_ops struct and use
> appropriate MMIO base for read vs write, while still reusing the map
> framework. Wouldnt that work?

   It probably would...

[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
