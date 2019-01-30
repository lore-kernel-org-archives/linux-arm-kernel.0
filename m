Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD089C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E78F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ouJC3bBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E78F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kmlC/Jz9xHTqKFsfVi1MG6B6je4raZAHLecKXU9iEEs=; b=ouJC3bBLVwkTqx
	XnPvIqUMZAdpYw4YrILYCWBrO9BBeNqRtyoN8zbcF/GF4qLGdWuA+FWIEVG8S2leMuX0hoO1f0Yvi
	AjpJ47XPLPqhNwKLFWhCoPgEqlLQ/WI96X7rg8pZoaeHp04bH9SH1Ct2Y+pPzpvd+HxZYyhEUjJyB
	ksLR64oKw8HwskNvXP17NKvQ3lzt7WjEkeMgwIaC1XeozrTaukCeY3sO2v14iCNC5AZ/Mx/lfJMnv
	54dXo2uF/TvzLbi+lAKxSAOAjDC9qpjk+vffAk1oCJhBKmt9n+WFNbZehxlSgzPnvFM0EwARxBWgg
	I0QFRzYjRNOPlRyOQWjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosY0-0000Vz-IS; Wed, 30 Jan 2019 16:17:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosXw-0000NX-Rv
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:17:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF60EBD;
 Wed, 30 Jan 2019 08:17:03 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2F33F589;
 Wed, 30 Jan 2019 08:17:02 -0800 (PST)
Subject: Re: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <3bb671a6-a7df-9c96-e4d3-09167df6dab1@arm.com>
Date: Wed, 30 Jan 2019 16:17:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_081704_904921_6202D2FD 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
 valentin.schneider@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Gentle ping for patches 3 and 4.

Thanks,

Julien

On 15/01/2019 13:58, Julien Thierry wrote:
> Hi,
> 
> First version of this series[1] was briefly in linux-next but had to be
> reverted due to a bug where schedule would end up being called while
> user_access was active[2].
> 
> After clarifications[3], rescheduling while in a user_access region is not
> allowed.
> 
> * Patches 1 and 2 implement the unsafe accessors for arm64
> * Patches 3 and 4 clarify this restriction in the API and attempts to
>   check against violations of the restriction.
> 
> Changes since v2[4]:
> - Rebase on v5.0-rc2
> - access_ok() is now done in user_access_begin(), so rework accessors
>   so access_ok() is not called in unsafe_get/put_user()
> - Split addition of unsafe accessors and the user_access_region check
>   into separate patches
> - Avoid reading SCTLR_EL1 in user_access_region check
> - Add build option for user_access_region checking
> - Reword clarifications on unsafe accessors API
> 
> Changes since v1[1]:
> - Add a way to detect code calling schedule within a user_access region
> - Make sure put_user/get_user arguments are evaluated before disabling PAN
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg674925.html
> [2] https://patchwork.kernel.org/patch/10634783/
> [3] https://lkml.org/lkml/2018/11/28/50
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/617080.html
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Julien Thierry (4):
>   arm64: uaccess: Cleanup get/put_user()
>   arm64: uaccess: Implement unsafe accessors
>   uaccess: Check no rescheduling function is called in unsafe region
>   arm64: uaccess: Implement user_access_region_active
> 
>  arch/arm64/include/asm/sysreg.h  |   2 +
>  arch/arm64/include/asm/uaccess.h | 123 ++++++++++++++++++++++++++-------------
>  include/linux/kernel.h           |  11 +++-
>  include/linux/uaccess.h          |  13 +++++
>  kernel/sched/core.c              |  22 +++++++
>  lib/Kconfig.debug                |   8 +++
>  6 files changed, 135 insertions(+), 44 deletions(-)
> 
> --
> 1.9.1
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
