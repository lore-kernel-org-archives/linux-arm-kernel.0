Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99389213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p85dujw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99389213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZnHpFzsiRgtPnZykXbEhs3o5cvUR1uusnnkubDdJJhQ=; b=p85dujw5Ag6Q++
	7PBkqwY9PMySE4Q908MCSYpWyNKAHRBEFJXR0MRJOM6xRa4zNDV8kvXXSZS7Ws1RGVLmaWwAZ3eIg
	6yENyv5ZaH6uFMGGxm6SKXqGO9HLqTrAOmUUBq9P707pwQ4njTi5BoE76GS7ULJXcFSRqcjz7vOO3
	6Mh1lk++diaX6aVSGDW8VY46lmHfMoukDyfl0qWWIUnKUTMAj8Wx1Wt2GWce7PkfqtuqZzuMe5wRJ
	APbGEeOJi6yJTlfZyNILez/fctZBOkvTFEoCAy03zFLH8MC3JVrhb/jlXyxL0tkV76V5Lh1VhSYXn
	r1CgXuPdY5STKRN+dRLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbT7-0004kj-TI; Wed, 05 Dec 2018 18:00:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbT4-0003Rt-2G
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:00:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AC680D;
 Wed,  5 Dec 2018 10:00:01 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6733F575;
 Wed,  5 Dec 2018 10:00:00 -0800 (PST)
Date: Wed, 5 Dec 2018 17:59:57 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 23/23] KVM: arm64/sve: Document KVM API extensions
 for SVE
Message-ID: <20181205175955.GT3505@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-24-git-send-email-Dave.Martin@arm.com>
 <877eh5i0wo.fsf@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877eh5i0wo.fsf@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_100014_120314_CBAB172E 
X-CRM114-Status: GOOD (  17.94  )
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
 Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 03:31:51PM +0000, Alex Benn=E9e wrote:
> =

> Dave Martin <Dave.Martin@arm.com> writes:
> =

> > This patch adds sections to the KVM API documentation describing
> > the extensions for supporting the Scalable Vector Extension (SVE)
> > in guests.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  Documentation/virtual/kvm/api.txt | 142 ++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 139 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/=
kvm/api.txt
> > index a58067b..b8257d4 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2054,13 +2054,21 @@ Specifically:
> >    0x6030 0000 0010 004c SPSR_UND    64  spsr[KVM_SPSR_UND]
> >    0x6030 0000 0010 004e SPSR_IRQ    64  spsr[KVM_SPSR_IRQ]
> >    0x6060 0000 0010 0050 SPSR_FIQ    64  spsr[KVM_SPSR_FIQ]
> > -  0x6040 0000 0010 0054 V0         128  fp_regs.vregs[0]
> > -  0x6040 0000 0010 0058 V1         128  fp_regs.vregs[1]
> > +  0x6040 0000 0010 0054 V0         128  fp_regs.vregs[0]    (*)
> > +  0x6040 0000 0010 0058 V1         128  fp_regs.vregs[1]    (*)
> >      ...
> > -  0x6040 0000 0010 00d0 V31        128  fp_regs.vregs[31]
> > +  0x6040 0000 0010 00d0 V31        128  fp_regs.vregs[31]   (*)
> >    0x6020 0000 0010 00d4 FPSR        32  fp_regs.fpsr
> >    0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
> >
> > +(*) These encodings are not accepted for SVE-enabled vcpus.  See
> > +    KVM_ARM_SVE_CONFIG for details of how SVE support is configured for
> > +    a vcpu.
> > +
> > +    The equivalent register content can be accessed via bits [2047:0]
> > of
> =

> You mean [127:0] I think.

Good spot.  Yes.

Possibly I meant "through the first slice of the corresponding Zn",
though [127:0] should make it clear both which slice and which bits
within the slice to look at.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
