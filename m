Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D616C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3E3214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IoKmil7h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsFBVisa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3E3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O4FP2yjkpmqgNGeF8goI76JRuA/W91haeTyqzqQnVfA=; b=IoKmil7hOLipRT
	nEGHZt3OLA29ng3BZ3cMyq59rkf7/CVlJEGzLcYkOiQlNMwJI9+pKfRN/skoj7rNPGnI9F5Ieq+h9
	bbYpxxs2bXjuNzmgHVWUhhKExMAoBaJedTdBHOb67PMpiZK7VL2BaGRxrXId5KxQLnb2dzrPeWBTY
	iRM6MwpXINqLiiHl1sCeifKV3eBs/pQagerZUKTpYxmr8jK2BT9u2nQ+GLb0Iucb8wwn+c0zJR4sR
	Gu9apvrOA+M2oKGhNxvdFpon4S+yE5gDj6va4gsqjPXYvlk0Smb+DWVZgl8J4waDCKGG2L7D9i7yd
	5D14Sm9n3A4D/0m9hcfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaA5-0001m3-3q; Mon, 04 Feb 2019 09:03:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaA0-0001ja-36
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:03:26 +0000
Received: from localhost (unknown [171.76.74.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A292F214DA;
 Mon,  4 Feb 2019 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549271003;
 bh=gCCaxUI2ihsRU8je4qmeQg7XDZWRUxyYtyadjn+1yu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BsFBVisap5WIzXG+1TD7mHBiNEAdJHQ0IloO4oSvpN5No458kgFYJUx+sg47Dxvqh
 LoVjjkNj+fPWfSCVXC9JhgNgVCe65JR9GCj0I8DX3fENuRoh1EdGfogiue1ah7PnOe
 SulgsHR76cmRWLe/hxe6DY/9azrTeZNwfgmZNzB4=
Date: Mon, 4 Feb 2019 14:31:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190204090154.GM4296@vkoul-mobl>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_010324_153996_C194CAAD 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Guodong Xu <guodong.xu@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 24-01-19, 12:24, John Stultz wrote:
> This patch series is based on recent work by Tanglei Han, and
> adds support for hi3660 SoCs as found on the HiKey960 board,
> along with a few patches I've been carrying.

Applied and fixed the minor style issues in patch 5, and retagged 3 thru
5 to dmaengine: xxx, thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
