Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B502BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:12:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869D9206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cAuujjuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869D9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=myytboNslm6OCH5hnqx2TT/QbdY2eGCE3IG5GDnJUA8=; b=cAuujjuqxcz5G+dfad7WT/o8kq
	8JDGABj8Vjtho153iRj4J4d6SN4UCXWCPPzjPcZlpYHNInpejCYIQ+ycRE9qRH3l4+HHAIkyI5XeK
	5EHj5tmYou1Er8HXh5sdAR1pj1TF2p7fgc/bMf4CgogFD/RkbpmOvOGPdJKIck54Uf/+Vqn8Wk9pF
	BO2LaMAtx0vLPpP6l5Ly32/4YYe9ePH8cvhvcixs6sbYsTZXedHajtUEmNruXC8FASsX5DjUjWvYS
	y1ulzxT2LUPUZa8/8c7gWWJ+3ghsAwZav5rjXi+BDyMTeDuA9xcD3hjNulLDQe1Y0mpS0IgXin3yp
	QDQJf+0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggwny-0001Ir-Mh; Tue, 08 Jan 2019 19:12:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggwnu-0001IO-Bf
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 19:12:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EF5A78;
 Tue,  8 Jan 2019 11:12:44 -0800 (PST)
Received: from [10.1.197.78] (ostrya.cambridge.arm.com [10.1.197.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42C213F70D;
 Tue,  8 Jan 2019 11:12:43 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: question about broadcast invalidation and atc invalidation
To: Zhongmiao <zhongmiao@hisilicon.com>,
 "Liujunlong (June)" <Junlong.Liu@hisilicon.com>,
 Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "zhongmiao@huawei.com" <zhongmiao@huawei.com>
References: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
 <fb76a20b-0ff4-d64e-4f9c-c160254b07ce@arm.com>
 <8CD08B4737CACA4ABE0228F45E441A91638DE813@dggemm521-mbs.china.huawei.com>
 <29168a05-815f-1dc4-abb7-61c273ce4fb4@hisilicon.com>
Message-ID: <d4b74306-b9ae-2b60-0b9f-b351de845467@arm.com>
Date: Tue, 8 Jan 2019 19:12:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <29168a05-815f-1dc4-abb7-61c273ce4fb4@hisilicon.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_111246_398184_CC9B82D2 
X-CRM114-Status: GOOD (  18.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miao,

On 24/12/2018 06:44, Zhongmiao wrote:
> Hi Jean:
> On 2018/12/24 14:36, Zhongmiao wrote:
>>
>>
>>
>> Hi,
>>
>> On 21/12/2018 09:31, Zhongmiao wrote:
>>> Hi Jean:
>>> 	Now Soft need to make sure build atc inv cmd to smmu after Execute
>>> "TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The
>>> smmu automatically sends the inv atc command when smmu receive
>>> broadcast invalidation ?
>>
>> I'd also like to see this done by hardware, but it's not straightforward. I see two difficulties with turning broadcast TLBI into ATC invalidation:
>>
>> * TLBI uses VMID and ASID to target the TLB entries to invalidate, but ATS uses RID and PASID. The SMMU would need to do a reverse lookup to convert VMID:ASID into RID:PASID, and there may be multiple RID:PASID pairs associated to one VMID:ASID.
>>
>> * ATS flow control. Each endpoint has a limited number of in-flight ATC invalidate requests. If the CPU is sending TLBI too fast, the SMMU would have to buffer them or back-pressure the interconnect, while waiting for in-flight ATC invalidate to complete.>>
>> So for the moment the architecture doesn't support this. We use MMU notifiers to convert VMID:ASID into RID:PASID and wait for ATC invalidation to complete.
>>
> 
> I got it about this.But How does the software(application) know to go to 
> invalidate remote ATC? This entry may not be cached at remote ATC.

Software doesn't know which entry has been cached in the ATC, so it must
invalidate any address that could have been cached. The mm subsystem
calls mmu_notifier_invalidate_range*() or mmu_notifier_change_pte() any
time it changes or deletes a mapping, which means that we'll send plenty
of spurious ATC INV for entries that don't exist.

I don't think we can do much to optimize this. We could theoretically
rely on the PTE access flag to know if an address might have been
cached, and don't send an ATC INV if the access flag was already unset
when clearing the PTE. But the mm subsystem doesn't seem to have any
infrastructure for this at the moment, and I think that adding it would
be too invasive, and the performance improvement too small.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
