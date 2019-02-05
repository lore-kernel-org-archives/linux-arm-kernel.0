Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74979C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:01:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420CA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ch9+u2Uz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1JqYOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420CA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txHxalRmi/NbgWgipREVu6oZ3baAyxwndCk323Ystvg=; b=Ch9+u2Uzv7U9oE
	KMwCAuFdwRMnMMKlu5cuxjoCmJIcgVdBvMt9LagwyLebQigIMooiTWHYTVAJ+qH6JxT6iDvPkfbsi
	Ngf2m/1g4KHNcLUfKEvAj0jEzRd3IVxQjPHF3Khq7D9mZpkjKsWS3YAOlmzbubCsKVOpLqzUv/LMQ
	KGDHR8MQuvezLxYp8DRCl2tCDRvsr2ymy/ovPmmAeIJH9d7kSv5srs+y7dWBsJE3g22L/sG0k1/ud
	IB8x067WS7NsYcv0VlJ1fbkOImkMiYRV1W4zTNtfRLhITpQNYvaGZ9PwjlwuDJkAEfDWBNziOjBVu
	LHAss1cr0zJt3NHE7ygQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqsrQ-0002YJ-IM; Tue, 05 Feb 2019 05:01:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqsrN-0002Xn-EF
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 05:01:26 +0000
Received: from localhost (unknown [171.61.84.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 120E72081B;
 Tue,  5 Feb 2019 05:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549342884;
 bh=2q/nWreDmf4PHQGRP8s50OMKY7xs6uZYZGwOVEnWQMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ay1JqYOB7/m2yMyXXi9AOLbK7QPHvmY6NHOFbzfnYxTVpRNJq/o++liD8gs3o9Diu
 EAFBc6VtUmJIxQZsL4xCx0lLhCEjqAWZCVicMx1RbAkwzaMWTzejNDAMYRNot3obTU
 Cc4xOjZAKHQY+MjWt00CbbsSbW1NtRpp/j8+35u8=
Date: Tue, 5 Feb 2019 10:31:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190205050116.GV4296@vkoul-mobl>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
 <20190204090154.GM4296@vkoul-mobl>
 <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_210125_497610_9F89A68A 
X-CRM114-Status: GOOD (  16.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>,
 Ryan Grachek <ryan@edited.us>, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04-02-19, 11:15, John Stultz wrote:
> On Mon, Feb 4, 2019 at 1:03 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 24-01-19, 12:24, John Stultz wrote:
> > > This patch series is based on recent work by Tanglei Han, and
> > > adds support for hi3660 SoCs as found on the HiKey960 board,
> > > along with a few patches I've been carrying.
> >
> > Applied and fixed the minor style issues in patch 5, and retagged 3 thru
> > 5 to dmaengine: xxx, thanks
> 
> My apologies for the style mistake. Your help is very much appreciated
> here! Thanks so much again!

No issues it was a minor one so didnt warrant a respin!
> 
> Just to clarify, are you planning on taking the reviewed binding
> documents (patches 1&2) via your tree?

yes sorry I should have clarified since this is multi-subsystem series.
I have applied 1 thru 5 that includes DT binding. I do that typically
for dmaengine driver patches with Rob's ack.

Thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
