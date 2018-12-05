Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D011EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A306B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HXfm157X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A306B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u4qHojE56urJY09tuZq5ZXSkw1w2bP/GBLjhJqcP9Hg=; b=HXfm157XmIIcnd
	DPvzFqRItjCYqxOVM5cTLocFLx/LqqEk7u+TxfYNxUZTKMscl6KoPFhT7NgzUvK+aj2P5KManSsku
	F/eAd4GCOchfbsV4SbT8hM3DVvwy2Xu/TSVLVWLcfSnNKICdmwKeGy696hFOdwbyNI2XTRq0/F1QW
	ZLaaVk1x62RiYMqOJlzQYQFDeG+4jIrFpaoEi4XOBiVTg35gFKOQBwuXywE90ZD2+h014yd82tj+b
	TdXSMe34kYQOehb0c7qcCo3s6iAdSCdqU3SyH+8Cx4qZubisRxoOzjYPL9nf1qUpSDdMBR5aqFpj7
	rGeXTapm193q+Ml2VGuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUb6l-0001z4-Ca; Wed, 05 Dec 2018 17:37:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUb6h-0001xu-QJ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:37:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA1AC80D;
 Wed,  5 Dec 2018 09:36:55 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 966433F575; Wed,  5 Dec 2018 09:36:54 -0800 (PST)
Date: Wed, 5 Dec 2018 17:36:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V4 2/6] arm64: mm: Introduce DEFAULT_MAP_WINDOW
Message-ID: <20181205173651.GD27881@arrakis.emea.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-3-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205164145.24568-3-steve.capper@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_093707_852576_221B5FE6 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: linux-mm@kvack.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:41:41PM +0000, Steve Capper wrote:
> We wish to introduce a 52-bit virtual address space for userspace but
> maintain compatibility with software that assumes the maximum VA space
> size is 48 bit.
> 
> In order to achieve this, on 52-bit VA systems, we make mmap behave as
> if it were running on a 48-bit VA system (unless userspace explicitly
> requests a VA where addr[51:48] != 0).
> 
> On a system running a 52-bit userspace we need TASK_SIZE to represent
> the 52-bit limit as it is used in various places to distinguish between
> kernelspace and userspace addresses.
> 
> Thus we need a new limit for mmap, stack, ELF loader and EFI (which uses
> TTBR0) to represent the non-extended VA space.
> 
> This patch introduces DEFAULT_MAP_WINDOW and DEFAULT_MAP_WINDOW_64 and
> switches the appropriate logic to use that instead of TASK_SIZE.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
