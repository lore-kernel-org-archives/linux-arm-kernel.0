Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEEA20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kR2sGDYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEEA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GxAuRSdEQMGbmazvE8WWwXaRufhBfzul4635FJTCOEk=; b=kR2sGDYUuvXiIN
	tBaSJEyPYsZefryNV6RfO1rxWXvhD4rmFdosLAPKKWe3nNRpBLfq3t0aAoLZFOPzv0wueYAYOUqS1
	HSr9Oaaj6YB9xgBj6ZzYbmxsv13+337TRAEHwhgFVBdNtUwRJiocaJJJmQhNABxU3q71/ra2wJxKU
	2faF/34h70P+ExGfb5MghyR5nY8NwjRxXYb8kkAJaXBkIh6N0qh3gSsDRHPYuE6oPp/GhCG03icpI
	sDXH8wnw5r1gpn+QkUGPLyiS2MKa+y36twwJ6sNcMW0YfhL5f0rFhuniLF5k4+rQqKrY6aiZFO2j+
	1QFXoLlU6SXlcQ3CA9ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFo5-0000aB-Pb; Fri, 22 Feb 2019 18:44:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFo2-0000Zr-Kp
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:44:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5FBD80D;
 Fri, 22 Feb 2019 10:44:17 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858C53F5C1;
 Fri, 22 Feb 2019 10:44:16 -0800 (PST)
Date: Fri, 22 Feb 2019 18:44:13 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 2/2] KVM: doc: add API documentation on the
 KVM_REG_ARM_WORKAROUNDS register
Message-ID: <20190222184413.460753b7@donnerap.cambridge.arm.com>
In-Reply-To: <20190222172743.GD3567@e103592.cambridge.arm.com>
References: <20190222121818.30164-1-andre.przywara@arm.com>
 <20190222121818.30164-3-andre.przywara@arm.com>
 <20190222172743.GD3567@e103592.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_104418_697284_A50DE1C1 
X-CRM114-Status: GOOD (  28.07  )
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
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 17:27:44 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> On Fri, Feb 22, 2019 at 12:18:18PM +0000, Andre Przywara wrote:
> > Add documentation for the newly defined firmware registers to save and
> > restore any vulnerability migitation status.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/virtual/kvm/arm/psci.txt | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/virtual/kvm/arm/psci.txt b/Documentation/virtual/kvm/arm/psci.txt
> > index aafdab887b04..fe8930765cc7 100644
> > --- a/Documentation/virtual/kvm/arm/psci.txt
> > +++ b/Documentation/virtual/kvm/arm/psci.txt
> > @@ -28,3 +28,27 @@ The following register is defined:
> >    - Allows any PSCI version implemented by KVM and compatible with
> >      v0.2 to be set with SET_ONE_REG
> >    - Affects the whole VM (even if the register view is per-vcpu)  
> 
> Doh, ignore my comments about undescribed semantics in the last patch.
> 
> > +
> > +* KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> > +  Holds the state of the firmware controlled workaround to mitigate
> > +  CVE-2017-5715, as described under SMCCC_ARCH_WORKAROUND_1 in [1].
> > +  Accepted values are:
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL: Workaround not available.
> > +      The mitigation status for the guest is unknown.
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL: Workaround active for the guest.
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_UNAFFECTED: The workaround is not
> > +      available and not needed.
> > +
> > +* KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> > +  Holds the state of the firmware controlled workaround to mitigate
> > +  CVE-2018-3639, as described under SMCCC_ARCH_WORKAROUND_2 in [1].
> > +  Accepted values are:
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL: Workaround not available.
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN: Workaround state unknown.
> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL: Workaround available, and can
> > +      be disabled by a vCPU. If KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED is
> > +      set, it is active for this vCPU.  
> 
> Ah, so this is really not supposed to be set except for _AVAIL?

Yes, it's only used if the kernel offers the switch. The reason is to
allow the guest to turn it *off*, actually.

> > +    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED: Workaround always active
> > +      or not needed.  
> 
> But is the workaround available (i.e., SMCCC interface implemented?)

Yes, that mirrors return value 1 of the actual firmware interface
permanently enable or not require, but safe to call the firmware).

> The code assumes it is, IIUC -- i.e., it will happily upgrade _AVAIL
> to _UNAFFECTED.  That's bad if it means the SMCCC call disappears under
> the guest's feet.

I think migrating to a "better" system is an important use case, so we
should make it possible.
 
> (Not saying it does, just that I'm not sure.)
> 
> 
> For KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1, we apply an == check, avoiding
> this subtlety.

Because we only have two cases there at the moment, and NOT_AVAIL could
mean not protected. Since we require guest interaction for WORKAROUND_1,
we can't allow any change at the moment. This will change with the
introduction of UNAFFECTED.

Cheers,
Andre

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
