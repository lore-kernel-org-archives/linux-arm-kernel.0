Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FBBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:26:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9F5218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lL0IYVOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9F5218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MgGK2mU+ocmBZZYIb9AUqqTjxoMfjow298xwljSw5kc=; b=lL0IYVOrPwM5bczxD8qxKBRmEx
	oOTiSD83s9Sx48qMaud5kKZIF7/1f0+lNqNotuUVtF/0kQqsWpp82/L+nSmhTr5AGXtzGWvzizkBk
	oQetxHRi+6HamjZDyo14xDJ0tHxHhNPB8CyZiIkrI39G42k3N1cr8n2A6qzASVNBH3fr3cg2kb+jg
	rUdjUxxaIMQN52n2Mpixr/ODeGo7jKPUbCrQsJC/6pcVZKvlzwhmHV4jrB5dLp6arkWpiPUPzcozf
	CqP2DDyQWnotIVZAtJnTRRr8IgUT0ojKnGqFDBx86mdW7vugihDv+K1M2iJycVyhSWmBARCeEkURs
	zoNiUaUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyprC-0006iU-5U; Wed, 27 Feb 2019 03:26:06 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gypr9-0006hQ-IK
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 03:26:05 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A38B7C429708B956B1C0;
 Wed, 27 Feb 2019 11:25:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:25:45 +0800
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump
 kernel
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5C760337.2070504@huawei.com>
Date: Wed, 27 Feb 2019 11:25:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_192603_778575_23F47F42 
X-CRM114-Status: GOOD (  12.34  )
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

Hi Will, Robin:
   Do you have time to review these patches? Hope you can give me some opinions.


On 2019/2/19 15:54, Zhen Lei wrote:
> This patch series include two parts:
> 1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
>    devices accessing. For more details, see the description in patch 2.
> 2. If the "ste abort" feature is not support, force the unexpected devices in the
>    secondary kernel to use the memory maps which it used in the first kernel. For more
>    details, see patch 5.
> 
> 
> Zhen Lei (5):
>   iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
>   iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
>   iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
>   iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
>   iommu/arm-smmu-v3: workaround for STE abort in kdump kernel
> 
>  drivers/iommu/arm-smmu-v3.c | 243 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 194 insertions(+), 49 deletions(-)
> 

-- 
Thanks!
BestRegards


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
