Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949BDC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C820684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WH6HpzEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I5MrAHqxJuU0Pa/arZAJLNK+nyvdbeDFbir3rG0DNm8=; b=WH6HpzEg/yJwRW
	emfMD7VqFayYfVYPzRrCVHvuYVLqv85ULkI19PSe4/l3LWRNfTC4fvyyISUtE8q5pSwviesvyMFVE
	zs30Vs/ccs5lhEpIelj0zMbGRqNI+rN71UWD3Jh32eeMevq/7MIGktX+bqBpFL0aQKhyJx5wKH10L
	+bAv/jk1kWWY1B2CjetJWNskFALK05zhvojK1OaLV9C2ZI4TInemgqiRc0CQvoINXfG1YLrw/SWbC
	AQnl/i0d3J+M6/1xNFlJrB2dWIVYcDrHxi56ZGrdBgdPrxB3VnCVRo4rd27Fa4ieZjzorI8p0bcOG
	rY/n8ja77C2jgKjtlsqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwXh-0000b5-EI; Tue, 22 Jan 2019 13:56:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwXe-0000af-2a
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:56:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961F7EBD;
 Tue, 22 Jan 2019 05:56:37 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858B53F614;
 Tue, 22 Jan 2019 05:56:36 -0800 (PST)
Date: Tue, 22 Jan 2019 13:56:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/2] KVM: arm/arm64: Add VCPU workarounds firmware register
Message-ID: <20190122135632.GF3578@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190122101657.GE3578@e103592.cambridge.arm.com>
 <86a7jt9cc2.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86a7jt9cc2.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_055638_120173_2F955E85 
X-CRM114-Status: GOOD (  18.60  )
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
Cc: Andre Przywara <andre.przywara@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 11:11:09AM +0000, Marc Zyngier wrote:
> On Tue, 22 Jan 2019 10:17:00 +0000,
> Dave Martin <Dave.Martin@arm.com> wrote:
> > 
> > On Mon, Jan 07, 2019 at 12:05:35PM +0000, Andre Przywara wrote:
> > > Workarounds for Spectre variant 2 or 4 vulnerabilities require some help
> > > from the firmware, so KVM implements an interface to provide that for
> > > guests. When such a guest is migrated, we want to make sure we don't
> > > loose the protection the guest relies on.
> > > 
> > > This introduces two new firmware registers in KVM's GET/SET_ONE_REG
> > > interface, so userland can save the level of protection implemented by
> > > the hypervisor and used by the guest. Upon restoring these registers,
> > > we make sure we don't downgrade and reject any values that would mean
> > > weaker protection.
> > 
> > Just trolling here, but could we treat these as immutable, like the ID
> > registers?  
> > 
> > We don't support migration between nodes that are "too different" in any
> > case, so I wonder if adding complex logic to compare vulnerabilities and
> > workarounds is liable to create more problems than it solves...
> 
> And that's exactly the case we're trying to avoid. Two instances of
> the same HW. One with firmware mitigations, one without. Migrating in
> one direction is perfectly safe, migrating in the other isn't.
> 
> It is not about migrating to different HW at all.

So this is a realistic scenario when deploying a firmware update across
a cluter that has homogeneous hardware -- there will temporarly be
different firmware versions running on different nodes?

My concern is really "will the checking be too buggy / untested in
practice to be justified by the use case".

I'll take a closer look at the checking logic.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
