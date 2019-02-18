Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:47:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFD72084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srCY4NXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFD72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=spK6D6rOHUj+5kvXM5twD2FNznRGfkzkC4OZO2JKH3M=; b=srCY4NXBi61wOU
	vUSpdrK2Yra24BjXdgiNS+XCIMeBigoPxXVk9uV15RiayWI7g+sWqfg9y4ZqPxPWit+MgCZEOPy0G
	+SNpz3S4j9F1Xg82tqh7nCbVRxCxiA1o64QbXJpoJRODHmi8vjzRtuBzZR7ovOd21Jr0eqCuKX1uD
	8wftimLZyp4pTAKZWML6fEgTbRgu816GJaTf0o1DBMGx2E6VMyuXGMl2nFTnCYNrbVugCVt18B7FB
	PoX134CL1Hlc+hDvhBt7Pu/BqCnM9nu20bBwzIIQtw2Qs3V9PxHQlt8zYDXE+8NeQrxtSA8InjLiZ
	LEGLDx0tUf3EvZYyHOqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveaX-00062a-Ez; Mon, 18 Feb 2019 08:47:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveaU-00061v-5S
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:47:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E627A78;
 Mon, 18 Feb 2019 00:47:41 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78DF3F589;
 Mon, 18 Feb 2019 00:47:39 -0800 (PST)
Date: Mon, 18 Feb 2019 08:47:36 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] kvm: arm64: Fix comment for KVM_PHYS_SHIFT
Message-ID: <20190218084736.651291a9@why.wild-wind.fr.eu.org>
In-Reply-To: <f14b90b1-ca81-e57e-9c42-6c8a4608cf72@arm.com>
References: <1550108746-14704-1-git-send-email-yuzenghui@huawei.com>
 <f14b90b1-ca81-e57e-9c42-6c8a4608cf72@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_004742_211402_336A67BB 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: yuzenghui@huawei.com, wanghaibin.wang@huawei.com, christoffer.dall@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 10:11:38 +0000
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Hi
> 
> On 14/02/2019 01:45, Zenghui Yu wrote:
> > Since Suzuki K Poulose's work on Dynamic IPA support, KVM_PHYS_SHIFT will
> > be used only when machine_type's bits[7:0] equal to 0 (by default). Thus
> > the outdated comment should be fixed.  
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>  
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >   arch/arm64/include/asm/kvm_mmu.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)  
> > > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h  
> > index 8af4b1b..a12bf48 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -138,7 +138,8 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
> >   	})  
> >   >   /*  
> > - * We currently only support a 40bit IPA.
> > + * We currently support using a VM-specified IPA size. For backward
> > + * compatibility, the default IPA size is fixed to 40bits.
> >    */
> >   #define KVM_PHYS_SHIFT	(40)  
> 
> Thanks for the fix.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied, thanks.

	M.

-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
