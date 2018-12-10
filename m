Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB077C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51962084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XWlSYMrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51962084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xQFGw8wkhN0znWdcGV+xOlb3NYfIhxqzsFzCdENotO8=; b=XWlSYMrRgYnR0ZSFQiJGtNtLX
	DsCMNgy9vxUp1J5PWjHnQWE8FpDbW7oxLRE9zj82E7SBuFLZREbjYqVJyHrzKvclmw6jcqJBs2WmK
	odjVlRjCAMjDHzXT6pSJ62vAzBTmVxcziTGSyO9HWN+qjvZCflD6PfsMZDogqBrPmxA3TQicOTbMS
	F13Bi2UwDKV5T31W8gynGXSjvCJYILm8UvTuFE6Z2OnUGrSD1WlxaY54Z7hQT5b4a6YjPHaIlVZ03
	vDebMLl2PYLG4l64GsRqvxxKMAgieqE1igyre0NobN03ohk3bF20asfm/NeXtDlLdExote9FG4/2B
	4n4iSfarQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKQT-0001oi-DO; Mon, 10 Dec 2018 12:12:41 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKQE-0001bY-9c; Mon, 10 Dec 2018 12:12:27 +0000
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 10 Dec
 2018 20:12:39 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To: Boris Brezillon <boris.brezillon@bootlin.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
Date: Mon, 10 Dec 2018 20:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181210123809.5ade45c4@bbrezillon>
Content-Language: en-US
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_041226_341407_E3474184 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Jian Hu <jian.hu@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/10 19:38, Boris Brezillon wrote:
> On Mon, 10 Dec 2018 19:23:46 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>>>> +			mtd->ecc_stats.failed++;
>>>> +			continue;
>>>> +		}
>>>> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
>>>> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
>>>> +	}
>>>
>>> Are you sure you handle correctly empty pages with bf?
>>>    
>> if scramble is enable, i would say yes here.
>> when scramble is disabled, i am considering how to use the helper
>> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
>> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send
>> out the ecc parity bytes.
> 
> Even if the ECC engine is disabled?
> 
No.
When ECC engine is disabled, it can read the ecc parity bytes ; but 
there is another problem that i need to consider how code struct looks 
better when reading error with ecc opened and then try to raw read.
Is there a good idea?

>> so i would suggest using scramble.
>>
> 
> No, please don't force people to use the scrambler.
> 
>>>> +
>>>> +const void *
>>>> +meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
>>>> +{
>>>> +	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
>>>> +		return NULL;
>>>> +
>>>> +	if (virt_addr_valid(instr->ctx.data.buf.out) &&
>>>> +	    !object_is_on_stack(instr->ctx.data.buf.out))
>>>
>>> Can you please create helpers for that? I guess it will help removing
>>> these checks once the core will have a DMA-safe approach.
>>>    
>> I will use below definition:
>> #define BUFFER_IS_DMA_SAFE(x)	\
>> 	(virt_addr_valid((x)) && (!object_is_on_stack((x))))
>>
>> Is it ok?
> 
> Please define a function, not a macro.
> ok
> .
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
