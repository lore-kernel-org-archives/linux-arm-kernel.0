Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D68D2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRZjPJik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D68D2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Guiq9E4pM9oNSWLyPeOLq1cQR/4eAgACq+sOXf5rxn4=; b=QRZjPJik7ch4y8r95vxDJ1j+v
	N/+GPvZk7i98FYd9tQGl0ZFsSgFikFpbZP4RewT1z3tNVIwchtybiROJsQXDbn7JQ2UZqhSUBL+QM
	XflNIMhkaiIUOweRxSqZbfttPyb2/dYxu7MUTlCNBgs0x2c8kpovS6qUD6srfe2i2y/eDzZaS4i2L
	ofXgjG6m4Sei1UQwG/advP1Vfezy1Bg+2G/1lja+25xlbC2RYhXNHC7pPl6cjgXq3dCxXRGKNbRTp
	6V4t33kNj7mkzz6nJXYcWgzSPcummcbOtueTpehHqp/6twVYHZjRnoUHdC97mMSimV8dq/aSueIfO
	dL0PMKpRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaQW-0001uU-Vm; Mon, 04 Feb 2019 09:20:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaQT-0001u1-8q
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:20:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE377A78;
 Mon,  4 Feb 2019 01:20:20 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43793F557;
 Mon,  4 Feb 2019 01:20:17 -0800 (PST)
Subject: Re: [kvmarm:master 7/8]
 arch/arm/kvm/../../../virt/kvm/arm/mmu.c:1705:36: error: implicit declaration
 of function 'kvm_stage2_has_pmd'; did you mean 'kvm_stage2_has_pud'?
To: lkp@intel.com
References: <201902021846.dWX0ezZV%fengguang.wu@intel.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f915d215-7f04-b048-b7ae-4cd6183096ae@arm.com>
Date: Mon, 4 Feb 2019 09:20:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201902021846.dWX0ezZV%fengguang.wu@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_012025_320050_D5D5C28C 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: marc.zyngier@arm.com, kbuild-all@01.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/02/2019 10:50, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git master
> head:   a7d7d3ebc7d441ee48e1fd87d9a8abbf7d528127
> commit: 4cc936fd184a2641801c906ea320326317895397 [7/8] KVM: arm64: Relax the restriction on using stage2 PUD huge mapping
> config: arm-axm55xx_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 4cc936fd184a2641801c906ea320326317895397
>          # save the attached .config to linux build tree
>          GCC_VERSION=8.2.0 make.cross ARCH=arm
> 
> All errors (new ones prefixed by >>):
> 
>     arch/arm/kvm/../../../virt/kvm/arm/mmu.c: In function 'user_mem_abort':
>>> arch/arm/kvm/../../../virt/kvm/arm/mmu.c:1705:36: error: implicit declaration of function 'kvm_stage2_has_pmd'; did you mean 'kvm_stage2_has_pud'? [-Werror=implicit-function-declaration]
>            (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>                                         ^~~~~~~~~~~~~~~~~~
>                                         kvm_stage2_has_pud
>     cc1: some warnings being treated as errors
> 
> vim +1705 arch/arm/kvm/../../../virt/kvm/arm/mmu.c


Thanks for the report. I will fix this by adding dummy definitions for arm32.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
