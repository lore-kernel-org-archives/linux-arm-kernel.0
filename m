Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB3E217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WAiFUHzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB3E217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=73jHPHeNBxMwQvi64JFQmKWywzH2cgDzTp+ljjZRSdk=; b=WAiFUHzsh8kNRL
	apg8gbPrS/kryW/OwgK+nondwEmxHavsA1lkmQH3c4hbdV6yrtrnV+z4YsUbxrZEu9mj7U8rA4puJ
	7RVe7wCr79qY/Y/TzQ49U/c0TNmNzOm5gszIz0/t4q/Ri1aJyu+nXA+fgN3tAqcgBoJz0vJabQeFR
	m1RAKy2e30Fydy1h61tz9yQ4BOBAr3h/jFhjQfDr9qV/oPQhuHoKnM/AD5kx1D26VPz8jA/qiLfkh
	WIpJtZYhtWsFBrExZulcWjQ4cCMq/2A8oS0oyFElw+zITmok9kVHOH0xj09cgL+8V/bSjgVWrFefn
	oOscAmtn52W13q2++now==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxyd-0008On-Ng; Tue, 22 Jan 2019 15:28:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxyZ-0008OA-AF
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:28:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91389A78;
 Tue, 22 Jan 2019 07:28:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810B73F589;
 Tue, 22 Jan 2019 07:28:29 -0800 (PST)
Date: Tue, 22 Jan 2019 15:28:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/2] KVM: arm/arm64: Add VCPU workarounds firmware register
Message-ID: <20190122152826.GH3578@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190122101657.GE3578@e103592.cambridge.arm.com>
 <86a7jt9cc2.wl-marc.zyngier@arm.com>
 <20190122135632.GF3578@e103592.cambridge.arm.com>
 <8636pkagps.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8636pkagps.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_072831_368523_C558738F 
X-CRM114-Status: GOOD (  26.84  )
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
Cc: Andre Przywara <andre.przywara@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:51:11PM +0000, Marc Zyngier wrote:
> On Tue, 22 Jan 2019 13:56:34 +0000,
> Dave Martin <Dave.Martin@arm.com> wrote:
> > 
> > On Tue, Jan 22, 2019 at 11:11:09AM +0000, Marc Zyngier wrote:
> > > On Tue, 22 Jan 2019 10:17:00 +0000,
> > > Dave Martin <Dave.Martin@arm.com> wrote:
> > > > 
> > > > On Mon, Jan 07, 2019 at 12:05:35PM +0000, Andre Przywara wrote:
> > > > > Workarounds for Spectre variant 2 or 4 vulnerabilities require some help
> > > > > from the firmware, so KVM implements an interface to provide that for
> > > > > guests. When such a guest is migrated, we want to make sure we don't
> > > > > loose the protection the guest relies on.
> > > > > 
> > > > > This introduces two new firmware registers in KVM's GET/SET_ONE_REG
> > > > > interface, so userland can save the level of protection implemented by
> > > > > the hypervisor and used by the guest. Upon restoring these registers,
> > > > > we make sure we don't downgrade and reject any values that would mean
> > > > > weaker protection.
> > > > 
> > > > Just trolling here, but could we treat these as immutable, like the ID
> > > > registers?  
> > > > 
> > > > We don't support migration between nodes that are "too different" in any
> > > > case, so I wonder if adding complex logic to compare vulnerabilities and
> > > > workarounds is liable to create more problems than it solves...
> > > 
> > > And that's exactly the case we're trying to avoid. Two instances of
> > > the same HW. One with firmware mitigations, one without. Migrating in
> > > one direction is perfectly safe, migrating in the other isn't.
> > > 
> > > It is not about migrating to different HW at all.
> > 
> > So this is a realistic scenario when deploying a firmware update across
> > a cluter that has homogeneous hardware -- there will temporarly be
> > different firmware versions running on different nodes?
> 
> Case in point: I have on my desk two AMD Seattle systems. One with an
> ancient firmware that doesn't mitigate anything, and one that has all
> the mitigations applied (and correctly advertised). I can migrate
> stuff back and forth, and that's really bad.

Agreed.

> What people do in their data centre is none of my business,
> really. What concerns me is that there is a potential for something
> bad to happen without people noticing. And it is KVM's job to do the
> right thing in this case.

Fair enough.

> > My concern is really "will the checking be too buggy / untested in
> > practice to be justified by the use case".
> 
> Not doing anything is not going to make the current situation "less
> buggy". We have all the stuff we need to test this. We can even
> artificially create the various scenarios on a model.

Agreed.  My concern is about how this will scale if future
vulnerabilities are added to the mix.  We might ultimately end up in a
worse mess, but I may be being paranoid.

> > I'll take a closer look at the checking logic.

See the other thread.  I have an idea there for exposing the information
in a different way that may simplfy things (or be totally misguided...)

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
