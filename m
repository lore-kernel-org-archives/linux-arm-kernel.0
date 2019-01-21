Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84454C312E1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 00:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBBE21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 00:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tEwYQ5kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBBE21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hLIbx07m7u6lxQ4Z50yOgVjrSAoe0pEE1hLSQ9IT8Js=; b=tEwYQ5kLfjmY//Pq+CnIkTFMv
	KF+NwfZ5Z2I9QzlVLEeMT+jEtCe4FaH5Y44PsVlm88Im0R9MKbmDuGoCyzBwJ0453hETUuTGqlhrF
	6N8jB+ZX48Jcbc19mfNmmLegvrOvW96lkw32tuf5Gs4BP0o+mH6OUcqheORBEA7cD6sn4v1qcj6zd
	IB545GBL3FJjeOBZR30h4+5A9kZuXOxr3Tse9x5VgA3CtzMqgrvvQZFT//ZeVTeWToRwzJS9bqunE
	LrOTawk8C52oRbwHlg/UVEvHmAu3DHVG8ptcDIOy3BJ+m7iCiDjAYcgDBCKmse8J1wGd3NnpD5t/V
	I1u+rGtjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glNbd-0004mg-KZ; Mon, 21 Jan 2019 00:38:25 +0000
Received: from mout2.fh-giessen.de ([212.201.18.46])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glNba-0004m6-1p
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 00:38:24 +0000
Received: from mx1.fh-giessen.de ([212.201.18.40])
 by mout2.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.91) (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1glNbQ-000Vr8-7Y; Mon, 21 Jan 2019 01:38:12 +0100
Received: from mailgate-1.its.fh-giessen.de ([212.201.18.15])
 by mx1.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.91) (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1glNbQ-0033OI-3s; Mon, 21 Jan 2019 01:38:12 +0100
Received: from p549d3f2a.dip0.t-ipconnect.de ([84.157.63.42]
 helo=zwei.fritz.box) by mailgate-1.its.fh-giessen.de with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.91)
 (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1glNbP-000OnG-Rh; Mon, 21 Jan 2019 01:38:11 +0100
Subject: Re: [PATCH] arch/arm64: Add the various compression methods to the
 default config
To: Will Deacon <will.deacon@arm.com>
References: <20190119185540.20526-1-tobias.johannes.klausmann@mni.thm.de>
 <20190119210221.GA30173@brain-police>
From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Message-ID: <c11ee6c4-3a7e-d1a1-4e17-0a4494f45e03@mni.thm.de>
Date: Mon, 21 Jan 2019 01:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:66.0) Gecko/20100101
 Thunderbird/66.0a1
MIME-Version: 1.0
In-Reply-To: <20190119210221.GA30173@brain-police>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_163822_089444_6E95A6AC 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 19.01.19 22:02, Will Deacon wrote:
> On Sat, Jan 19, 2019 at 07:55:40PM +0100, Tobias Klausmann wrote:
>> There is no reason having arm64 not select these configurations by
>> default!
>>
>> Signed-off-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
>> ---
>>   arch/arm64/Kconfig | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a4168d366127..91a5e1cd7279 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -140,6 +140,11 @@ config ARM64
>>   	select HAVE_GENERIC_DMA_COHERENT
>>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>>   	select HAVE_IRQ_TIME_ACCOUNTING
>> +	select HAVE_KERNEL_GZIP
>> +	select HAVE_KERNEL_LZ4
>> +	select HAVE_KERNEL_LZMA
>> +	select HAVE_KERNEL_LZO
>> +	select HAVE_KERNEL_XZ
>>   	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>>   	select HAVE_NMI
>>   	select HAVE_PATA_PLATFORM
> I don't really understand what this patch achieves. We don't have a built-in
> decompressor for arm64, as we defer to the bootloader to handle that for us
> instead. The Image.gz target already produces a gzipped kernel payload.
>
> What are you trying to do?


Yeah silly me, yet having a different behavior while installing: make 
zinstall <-> make install in comparison to x86 is misleading. Maybe this 
could be an option in the K config?

Greetings,

Tobias


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
