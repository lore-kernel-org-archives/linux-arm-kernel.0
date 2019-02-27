Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11263C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:38:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2A12133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdE/Yo+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2A12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sUJ6ftV+TDyYV23+srSbXX3ivI4B1NST3ms2x1qCL6g=; b=kdE/Yo+rtCmkUl
	75ApecZTKLvLkwW/YnA1UXAFTK8DvbF2jgmXf36bfKmWzDOuw+AWNId+KvVuzVr/srXIDrjZXsHrX
	PeBGJGKnK7RWgg9mWevtJeyVEUjEhBbBLJmBRgQC+8KiJBcd3kVngP8eOA2Xytrwcm1H9tKGBqsoP
	fNIFHKDF4l31vp2Ue2RQRj2dIQBVgSvCmr3GNwgKACL4HN2U4rWnPO8xWIeHidnQKB8rr/6GE1cxU
	W8Z6c6M4a7Knh7/FWox6uIeCRUt1KogTxPYywax5WbeidW0r0dPADJH4R3JyJ+E4H/ZmQ5NSqiR/w
	VrbxETuQ7S+t3V/MiM4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzPR-0001dA-6q; Wed, 27 Feb 2019 13:38:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzPN-0001ca-Gu
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:38:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24710374;
 Wed, 27 Feb 2019 05:37:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B0F3F5C1;
 Wed, 27 Feb 2019 05:37:55 -0800 (PST)
Date: Wed, 27 Feb 2019 13:37:52 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 14/26] KVM: arm64/sve: Context switch the SVE registers
Message-ID: <20190227133751.GD3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-15-git-send-email-Dave.Martin@arm.com>
 <83fa5587-24a0-5bbb-c113-cddc74571ea2@arm.com>
 <20190226121321.GQ3567@e103592.cambridge.arm.com>
 <82b7b947-7e92-15df-5c71-6d562141264e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82b7b947-7e92-15df-5c71-6d562141264e@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_053801_567903_D8A554D9 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Will Deacon <will.deacon@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 04:56:36PM +0000, Julien Grall wrote:
> Hi Dave,
> 
> On 26/02/2019 12:13, Dave Martin wrote:
> >On Wed, Feb 20, 2019 at 04:46:57PM +0000, Julien Thierry wrote:
> >>
> >>
> >>On 18/02/2019 19:52, Dave Martin wrote:
> >>>In order to give each vcpu its own view of the SVE registers, this
> >>>patch adds context storage via a new sve_state pointer in struct
> >>>vcpu_arch.  An additional member sve_max_vl is also added for each
> >>>vcpu, to determine the maximum vector length visible to the guest
> >>>and thus the value to be configured in ZCR_EL2.LEN while the is
> >>
> >>"While the <guest> is active"?
> >
> >Hmmm, yes.  Thanks for deciphering that.  Done.
> I think it would be more consistent if you use "vcpu" over "guest". After
> all ZCR_EL2.LEN is per vCPU.

Yes, that makes sense.  Done.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
