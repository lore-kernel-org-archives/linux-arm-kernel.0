Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD55C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03BB2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jQXezAZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03BB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V/mgmuTR+8bUG11ink7heSJVLSSmA+g2wFCegRXdaWc=; b=jQXezAZC0kpXqI
	m5pZjg8UdUUSyNQwN50LoHDi8hgneU0eWL3gPqZTkLzFd4X3BPOWqvsqnpPNmTw+UHieBg5MnA1iq
	rzCdqswkDXKIImABMrE9R1P6hO/iCIvq9Mtc9M9G7OzJAD+TsQFSY+72bnBp/dlonyKi0y6AaXttW
	nqcwZRivaEG54przSu6vNuRzv3Ku9nHnE6b1C6pslDx2RVEb1+D0WsuRCj5w475vrpIieCOkF2aaW
	2+ycSk1iT6OBbHyrSbpMzQb12xqbNrh88QT67G/+wnFkbJSz6ETl9W2fui+fQlhMevpp7Gbljr4iw
	iAN8fZ2PUFF2DZDjmvDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVE19-0005Z2-9W; Fri, 07 Dec 2018 11:09:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVE14-0005Px-KO
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:09:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9249CEBD;
 Fri,  7 Dec 2018 03:09:43 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170EA3F5AF;
 Fri,  7 Dec 2018 03:09:41 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Workaround for Cortex-A76 erratum 1165522
To: Marc Zyngier <marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <da3f6f5a-9d39-3b51-661e-723742727f35@arm.com>
Date: Fri, 7 Dec 2018 11:09:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_030954_671530_E0113F61 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 06/12/2018 17:31, Marc Zyngier wrote:
> Early Cortex-A76 suffer from an erratum that can result in invalid
> TLBs when the CPU speculatively executes an AT instruction in the
> middle of a guest world switch, while the guest virtual memory
> configuration is in an inconsistent state.
> 
> We handle this issue by mandating the use of VHE and making sure that
> the guest context is fully installed before switching HCR_EL2.TGE to
> zero. This ensures that a speculated AT instruction is either executed
> on the host context (TGE set) or the guest context (TGE clear), and
> that there is no intermediate state.
> 
> There is some additional complexity in the TLB invalidation code,
> where we most make sure that a speculated AT instruction cannot mess
> the stage-1 TLBs.

For the series:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
