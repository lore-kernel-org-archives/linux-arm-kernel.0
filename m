Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1017C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7287520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZDCWTFXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7287520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfBaRkPeM1StoZGUYnhDi+3OqZauC+gQ4S5zlgQOpSk=; b=ZDCWTFXT1wUQV9z5OcMT8mBaN
	VvH57t3XVBO0nLbPv7htUNjQsdZDtambmCsacDS2ld+7uD1AiH52uYApStrJBG7Ef0ONTruaRnOgg
	LCOK6ApDIN8aKc569dSgbHJhwe5b3dYM0w2tY3gtxS9wR0GFsl0Sg1nVUzxG1AdUiL6CutLIeVXQL
	zQ9M+sMQMhWJiXuW3Kh3PNqTiF75Sca+sh/reTsojXEB5x4h1pBKl1ME9MYh3JBubKA0ezTjc0/Yy
	L8kM/KWGcG0mYb7COiFEcokerccKexfhRDS7jdy6b0AkbzRBYaRcLvL7+PTo5EfJ/NhQ9s+BJa2gr
	stTFIWU7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeWX-0007mQ-9M; Tue, 11 Dec 2018 09:40:17 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeWF-0006ut-MF; Tue, 11 Dec 2018 09:40:01 +0000
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 11 Dec
 2018 17:39:50 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To: Boris Brezillon <boris.brezillon@bootlin.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
 <20181211093933.2fab8cc3@bbrezillon>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <6abef955-5ce0-6213-b616-67a306d1fb31@amlogic.com>
Date: Tue, 11 Dec 2018 17:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181211093933.2fab8cc3@bbrezillon>
Content-Language: en-US
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_013959_730105_C9DB4B09 
X-CRM114-Status: GOOD (  15.69  )
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

Hi Boris,

On 2018/12/11 16:39, Boris Brezillon wrote:
> On Tue, 11 Dec 2018 09:56:25 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>> Hi Miquel,
>>
>> On 2018/12/10 22:50, Miquel Raynal wrote:
>>> Hi Liang,
>>>
>>> Liang Yang <liang.yang@amlogic.com> wrote on Mon, 10 Dec 2018 20:12:39
>>> +0800:
>>>    
>>>> On 2018/12/10 19:38, Boris Brezillon wrote:
>>>>> On Mon, 10 Dec 2018 19:23:46 +0800
>>>>> Liang Yang <liang.yang@amlogic.com> wrote:
>>>>>       
>>>>>>>> +			mtd->ecc_stats.failed++;
>>>>>>>> +			continue;
>>>>>>>> +		}
>>>>>>>> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
>>>>>>>> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
>>>>>>>> +	}
>>>>>>>
>>>>>>> Are you sure you handle correctly empty pages with bf?
>>>>>>>      >> if scramble is enable, i would say yes here.
>>>>>> when scramble is disabled, i am considering how to use the helper
>>>>>> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
>>>>>> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send
>>>>>> out the ecc parity bytes.
>>>>>
>>>>> Even if the ECC engine is disabled?
>>>>>       
>>>> No.
>>>> When ECC engine is disabled, it can read the ecc parity bytes ; but there is another problem that i need to consider how code struct looks better when reading error with ecc opened and then try to raw read.
>>>> Is there a good idea?
>>>
>>> When reading with ECC enabled, in case of uncorrectable error you
>>> must re-read without ECC, then check if the page is empty or not with
>>> the core helpers (nand_check_erased_*()).
>>>
>>> Is this what you meant?
>>>    
>> yes. when uncorrectable ECC error, i need firstly read out the ECC bytes
>> without ECC engine and then use the helper nand_check_erased_ecc_chunk
>> to check if blank page.
>> Of course, the precondition is without scrambler, or the bland page can
>> be detected by meson NFC.
> 
> Yep, raw accessors should disable both the scrambler and the ECC
> engine (see what's done in sunxi_nand.c).
> 

i see sunxi_nfc_hw_ecc_read_chunk and it will re-read the data for 
bitflips with scrambler off when ECC failed.
also we can do the same implementation and it seems to be the only answer.

> .
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
