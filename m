Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71523C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B8721721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxrBIdky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8721721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kPLeY4fdaxvPy2ShUbzmMriE1A+CeLAnsKGWN8mJqOI=; b=BxrBIdkyyRlflU
	7IyOP/+qWwqZ1ubBXDmj8vOYa8nNNSxQ0M9UnO3o00eh3/ph444ixxgsgs+pG3XASYHQJ+llHG0c8
	N5R1kmcnLJfZWY34Fa9fd6dg++lmdHFGNs2HmCpkAdU8Hez8kpDlAL03kEK4ekJIUDiG1ZPKtlTUB
	L9Z6gE5tN/6Uu4cKRn1F2EG9bD4o1v3asaufZRG/OnQVFfS29TlwBZarWEe8VlaZSUJl67pPbAWRF
	bZzuDR5WSh5kJvoM68Mj8NJZGSFsJtDeOvI3WlNjCKbzUbEUPuOs/baVfMU86YVcNqKsfJB1Mo4Sr
	+RsSMqCr6KxlGn6UD6CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltUn-0004gt-BO; Tue, 22 Jan 2019 10:41:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltUj-0004gK-Ga
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:41:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B84EA78;
 Tue, 22 Jan 2019 02:41:23 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DAE53F6A8;
 Tue, 22 Jan 2019 02:41:22 -0800 (PST)
Date: Tue, 22 Jan 2019 10:41:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 0/2] KVM: arm/arm64: Add VCPU workarounds firmware register
Message-ID: <20190122104119.15a80ae6@donnerap.cambridge.arm.com>
In-Reply-To: <20190122101657.GE3578@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190122101657.GE3578@e103592.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_024125_552824_5BB0B429 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 10:17:00 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> On Mon, Jan 07, 2019 at 12:05:35PM +0000, Andre Przywara wrote:
> > Workarounds for Spectre variant 2 or 4 vulnerabilities require some
> > help from the firmware, so KVM implements an interface to provide
> > that for guests. When such a guest is migrated, we want to make
> > sure we don't loose the protection the guest relies on.
> > 
> > This introduces two new firmware registers in KVM's GET/SET_ONE_REG
> > interface, so userland can save the level of protection implemented
> > by the hypervisor and used by the guest. Upon restoring these
> > registers, we make sure we don't downgrade and reject any values
> > that would mean weaker protection.  
> 
> Just trolling here, but could we treat these as immutable, like the ID
> registers?  
> 
> We don't support migration between nodes that are "too different" in
> any case, so I wonder if adding complex logic to compare
> vulnerabilities and workarounds is liable to create more problems
> than it solves...

That is a good point, and we should keep an eye on that it doesn't get
out of hands here. Indeed it is not clear yet how many users really
want to migrate between hosts with a different CPU or platform.
But ...
 
> Do we know of anyone who explicitly needs this flexibility yet?

I think there is a good use case to migrate from a vulnerable host
to one which implements mitigations or isn't vulnerable in the first
place, in which case we want to allow migrations. The scenario here
would probably to migrate VMs away, update the firmware, reboot
the host and migrate the VMs back.

For the other direction (increasing vulnerability) we deny it here,
which is in line with what you think of?

Cheers,
Andre.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
