Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D600C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032CF20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MH85tF4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032CF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ac8jZUlOBQ3HVfHg9Idbni5kZFHY6nKek2/X/AHz5k4=; b=MH85tF4tmupWa3
	yVUfalPb0ehf8M7zKd+8nec6xEdzyI1RP4Ew43Cs2IHcnxc/xxpOscnAKHlC9Pw2C0h62v76eYRjK
	IUvNSltFhgo9vpKzmlE6Fq0B5fGcNFiyRuMH1R/wekuGtxBD+QSj5HWQeyQ7mJk/zpfgcPQx5P9Yg
	LVJZW61RSMUsCLsLf1xGKSzlqnqZEhZ9SigQdhmHLPBnuLJxWyxyUFVAuJfmUd7RwyesCYZoX+1ID
	jaByq+9zFsH4BmbRYvPpwPvNornlUOekmWe1YhIAwDKADl5bwy/0hLifGArlfZh/Hr2u7ghekmr5m
	7EoCPKIO3HQ7kViR7Bgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnfj-0006s7-Rl; Fri, 30 Nov 2018 18:37:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnfc-0006VW-3G
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:37:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0597165C;
 Fri, 30 Nov 2018 10:37:32 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746D23F575;
 Fri, 30 Nov 2018 10:37:31 -0800 (PST)
Subject: Re: Resend: How to handle the SMMU RAS Error in the kernel
To: gengdongjiu <gengdongjiu@huawei.com>, gengdongjiu <gengdj.1984@gmail.com>
References: <CAMj-D2DY_1eZUsbnqurx8j3q04Y8JKiM2CtPv+NTsswydo0TJQ@mail.gmail.com>
 <c8a1d0e7-338b-05e1-2d52-f13223515f49@arm.com>
 <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c769e2a5-f176-60fd-bcff-ef00e904736a@arm.com>
Date: Fri, 30 Nov 2018 18:37:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <7a93bf1b-7b7b-240e-bc74-68bf0ee18ac9@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_103744_141404_0C07430F 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: xuqiang36@huawei.com, robin.murphy@arm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi gengdongjiu,

On 21/11/2018 08:10, gengdongjiu wrote:
> On 2018/11/20 2:05, James Morse wrote:
>> On 17/11/2018 15:41, gengdongjiu wrote:
>>> In the current kernel, it only handles three kinds of error, which is
>>> memory error, PCIE device and ARM process. But now the SMMU already
>>> support the RAS, how to handle the SMMU RAS error in the kernel?
>>
>> What errors are being detected here?
>>
>> I don't know much about the SMMU, but I think we should start with a list of
>> errors that we want to handle.
> 
> In our platform, the SMMU RAS error mainly include below which flow the SMMU spec:
> 1. one bit ECC error, reported as CE.
> 2. two bits ECC error, reported as UEU.
> 3. fetch error in the SMMUv3 spec, reported as UER.

These are faults, but this isn't enough information for software to act on.

Are these faults in the device, host-memory, or memory that is part of the SMMU?
Was the error discovered during a read/write by the device?, (which one?) Or the
SMMU's page-tables, or command-queue.


> The 2 and 3 should be handled, but I do not know how do recovery to it.

Me neither. If we can come up with the errors that can be detected, we can work
out which ones can be handled.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
