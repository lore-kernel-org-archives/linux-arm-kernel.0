Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC3B217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J743rRvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC3B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k9Wid7jM0YEFH5JLM0ePEAa5y9Hxhsuw6ePmGZuWcwA=; b=J743rRvoT44/qI
	n1NJbN6XBYDBKpus0izbT9hUwQ+mKAxRWGTaWWGHpVnWuvXzUFmyO+6htap26Dr81L1EO1s36728j
	MKcEWy3/AgvIsS1CwnaaDHRjuiOlfaFF9Ba44PtxM/mw6QDUmvRVs2XqQQbpwRGxvb30zBpAppFu6
	WIdFzYqMXfntkEuo103j2qJIMe0PgKAP82AVviqcRO5ct39jzMzppE7dkydSb1y6xiV4Pd5rTVDyZ
	mUlMf1JQmVXEN5is4gOCFZiv2gNA+z+W2Bc6dgAV7aOUeuWEkzJxPhDD86uH2sa0xuj2EP0BDrKTs
	mJaX4F+9jn/jMPHErIpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyc01-0003zc-Jf; Tue, 26 Feb 2019 12:38:17 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybzy-0003yh-0v
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:38:16 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B5619BB2F09F9F440D87;
 Tue, 26 Feb 2019 20:38:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Feb 2019
 20:37:56 +0800
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Zhen Lei
 <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
 <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
Date: Tue, 26 Feb 2019 20:36:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
Content-Language: en-US
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_043814_547736_2063A54A 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "Chengchuanning \(Hisi-Turing\)" <chengchuanning@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jean,

On 2019/1/31 22:55, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 31/01/2019 13:52, Zhen Lei wrote:
>> Currently, many peripherals are faster than before. For example, the top
>> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
>> when iommu page-table mapping enabled, it's hard to reach the top speed
>> in strict mode, because of frequently map and unmap operations. In order
>> to keep abreast of the times, I think it's better to set non-strict as
>> default.
> 
> Most users won't be aware of this relaxation and will have their system
> vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
> Invalidation in
> http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf
> 
> Why not keep the policy to secure by default, as we do for
> iommu.passthrough? And maybe add something similar to
> CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
> command-line argument or change the default config.

Sorry for the late reply, it was Chinese new year, and we had a long discussion
internally, we are fine to add a Kconfig but not sure OS vendors will set it
to default y.

OS vendors seems not happy to pass a command-line argument, to be honest,
this is our motivation to enable non-strict as default. Hope OS vendors
can see this email thread, and give some input here.

Thanks
Hanjun


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
