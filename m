Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:14:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1DC2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qPQ/Uu5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1DC2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4F6gIerz/YSGHmnXGmG4K1OVEXUz2EYgFRG2pnhBN7Y=; b=qPQ/Uu5NIJjOkL
	lz8K7g8qcPyDyXDywGiaMlHpoYxs2WPuvTmiWqrkVI++MyPh5mtxZJgjY/MbsOAVR1W9ziYNXKhLb
	LntwyIhKNwzWkkj9YuJ+dayObrYkuBn4YH7ZTGZx/u/r0I3K3XomU7fvrgfrP+xRDBZAZM704Scfr
	OE7uDnSffwh6jKP8Eohnxesz+cNe6IMCfmH1fQ0qjERJQhHeBAvwgRn7cgdSHHUhH+6Fdj1XgKEK/
	wX1GvsE3tSripBZm/enFgD61nFVRLMvmFzxlCFaQNm/tAuFuGZg474cl7ZOONjU/H9QlwO3BFTQeF
	6Qac643pvWQt/iUHIVYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggpLO-0003WJ-Ub; Tue, 08 Jan 2019 11:14:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggpLL-0003VP-9C
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 11:14:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE002EBD;
 Tue,  8 Jan 2019 03:14:46 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455623F6CF;
 Tue,  8 Jan 2019 03:14:46 -0800 (PST)
Date: Tue, 8 Jan 2019 12:14:44 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH 2/2] arm64: kvm: describe data or unified caches as
 having 1 set and 1 way
Message-ID: <20190108111444.GM10769@e113682-lin.lund.arm.com>
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
 <20181217150205.27981-3-ard.biesheuvel@linaro.org>
 <20190108110238.GJ10769@e113682-lin.lund.arm.com>
 <CAKv+Gu94dRFbjqckGG-oedsM=ET-wpkZtUo7-hPbVqeUELwffw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu94dRFbjqckGG-oedsM=ET-wpkZtUo7-hPbVqeUELwffw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_031447_329583_C57682BD 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 12:11:33PM +0100, Ard Biesheuvel wrote:
> On Tue, 8 Jan 2019 at 12:02, Christoffer Dall <christoffer.dall@arm.com> wrote:
> >
> > On Mon, Dec 17, 2018 at 04:02:05PM +0100, Ard Biesheuvel wrote:
> > > On SMP ARM systems, cache maintenance by set/way should only ever be
> > > done in the context of onlining or offlining CPUs, which is typically
> > > done by bare metal firmware and never in a virtual machine. For this
> > > reason, we trap set/way cache maintenance operations and replace them
> > > with conditional flushing of the entire guest address space.
> > >
> > > Due to this trapping, the set/way arguments passed into the set/way
> > > ops are completely ignored, and thus irrelevant. This also means that
> > > the set/way geometry is equally irrelevant, and we can simply report
> > > it as 1 set and 1 way, so that legacy 32-bit ARM system software (i.e.,
> > > the kind that only receives odd fixes) doesn't take a performance hit
> > > due to the trapping when iterating over the cachelines.
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/arm64/kvm/sys_regs.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > index 464e794b5bc5..eb244ff98dca 100644
> > > --- a/arch/arm64/kvm/sys_regs.c
> > > +++ b/arch/arm64/kvm/sys_regs.c
> > > @@ -1180,6 +1180,21 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > >
> > >       csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
> > >       p->regval = get_ccsidr(csselr);
> > > +
> > > +     /*
> > > +      * Guests should not be doing cache operations by set/way at all, and
> > > +      * for this reason, we trap them and attempt to infer the intent, so
> > > +      * that we can flush the entire guest's address space at the appropriate
> > > +      * time.
> > > +      * To prevent this trapping from causing performance problems, let's
> > > +      * expose the geometry of all data and unified caches (which are
> > > +      * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
> > > +      * [If guests should attempt to infer aliasing properties from the
> > > +      * geometry (which is not permitted by the architecture), they would
> > > +      * only do so for virtually indexed caches.]
> > > +      */
> > > +     if (!(csselr & 1)) // data or unified cache
> > > +             p->regval &= ~GENMASK(27, 2);
> >
> > Why are you clearing the upper bit the LineSize field?
> >
> 
> Ah, that needs to be ~GENMASK(27,3), of course.

With that fixed, the patches look fine to me.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
