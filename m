Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D43C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132A92146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rfo7VIt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132A92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VyoTpK3Jo19bLa/vR6LctXCpWvUHFFV0O6h838LABFM=; b=Rfo7VIt/0WsftZMoZEzcwR/4a
	Fi6az+va+OY5u3M8oZVRFxlV+AHPYAYp/2hsx7d3mnlL1A45mR+TBmV0pPpUelP/Qggybc/+ZuYjP
	jYpLdSAfyO4XfHRyHuQeNduDWZEqTvllcRFZyJsRcS1bXQJo2PqrJclZB3GfEZVWld/nqhGxVvVPE
	Y+vKY/KmtHQzGEAuwRY7393bQ+3L9UlbNOuo8lb3VKbxqFz0s1D1zhccD5UC7PXB42vIeIRAfGGZw
	f3NQ+fWzDSnV+Udoy5Ss2FrFt25S61pRFBLAiIuz7EQbt17K3ulZ3ePvzhioUet/Qbi17E/iwxLkp
	52idiKW3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9ai-0002cD-B0; Fri, 08 Feb 2019 17:05:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9aI-00014U-I6
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:05:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E7880D;
 Fri,  8 Feb 2019 09:05:01 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948D33F719;
 Fri,  8 Feb 2019 09:05:00 -0800 (PST)
Subject: Re: [PATCH 0/3] Remove reference of TIF_USEDFPU on arch not using it
To: linux-kernel@vger.kernel.org
References: <20190208170315.10762-1-julien.grall@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <86210318-e09a-db32-3591-1dfb0f222617@arm.com>
Date: Fri, 8 Feb 2019 17:04:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208170315.10762-1-julien.grall@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_090503_884551_14AFFAB3 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Sorry I made an error in the patches sent. Please ignore this series and look 
for the "RESEND" version.

Cheers,

On 08/02/2019 17:03, Julien Grall wrote:
> Hi all,
> 
> This small patch series remove reference of TIF_USEDFPU on nds32, arm and
> arm64 as the flag is not inuse.
> 
> Cheers,
> 
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Julien Grall (3):
>    nds32: Removed unused thread flag TIF_USEDFPU
>    arm: Remove documentation about TIF_USEDFPU
>    arm64: Remove documentation about TIF_USEDFPU
> 
>   arch/arm/include/asm/thread_info.h   | 1 -
>   arch/arm64/include/asm/thread_info.h | 1 -
>   arch/nds32/include/asm/thread_info.h | 2 --
>   3 files changed, 4 deletions(-)
> 

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
