Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BD821852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HQO1ZqWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BD821852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ir8sEWvNVOwjd1A8+SmrqETYLSvewxiHt//JCJYsylQ=; b=HQO1ZqWyuAl9mw
	nAmQqdPCOh4zQNBooLT5PfqOfVK5O6TJQ26r6aJmSFHaTUk1BpwjfpvkDk14M7RFOF/hD0yjMd/7L
	VAg/2w9/swukpmWi1yYXaAiBWucJWz1GAQouXA2vFtXq1FPP5c72nD5duvB1eBwAzzXYk2w4l3lsu
	6Go4gco3H+5zaWyI935KeHPg2u4X9WXGcZ1tN3TxPR65qgV6WG+Sgu9EJ2JBp8Z7g+Ia+prNamRpq
	55mR50ADm87y71fo7fGs0dUiP+usQzCfysDcGvLhQhp/9Al9XIe5mxShs15g8OPEne/cLTc1s1r3p
	b8Ap/Rz5hic9zuXx7cig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybVL-0000HX-00; Tue, 26 Feb 2019 12:06:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybV7-00009l-G2
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:06:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D106F80D;
 Tue, 26 Feb 2019 04:06:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC343F71D;
 Tue, 26 Feb 2019 04:06:18 -0800 (PST)
Date: Tue, 26 Feb 2019 12:06:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 05/26] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
Message-ID: <20190226120616.GG3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-6-git-send-email-Dave.Martin@arm.com>
 <20190220152349.GE4763@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220152349.GE4763@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040621_817827_88AC1BAB 
X-CRM114-Status: GOOD (  19.59  )
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
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 03:23:50PM +0000, Mark Rutland wrote:
> On Mon, Feb 18, 2019 at 07:52:18PM +0000, Dave Martin wrote:
> > kvm_host.h uses DECLARE_BITMAP() to declare the features member of
> > struct vcpu_arch, but the corresponding #include for this is
> > missing.
> > =

> > This patch adds a suitable #include for <linux/bitmap.h>.  Although
> > the header builds without it today, this should help to avoid
> > future surprises.
> > =

> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm=
/kvm_host.h
> > index 7732d0b..84056a4 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -22,6 +22,7 @@
> >  #ifndef __ARM64_KVM_HOST_H__
> >  #define __ARM64_KVM_HOST_H__
> >  =

> > +#include <linux/bitmap.h>
> >  #include <linux/types.h>
> >  #include <linux/kvm_types.h>
> >  #include <asm/cpufeature.h>
> =

> From a quick scan of the file, we're also missing:
> =

> #include <asm/barrier.h>

[...]

> #include <linux/jump_label.h>
> #include <linux/percpu.h>

Done for those three.


> #include <linux/thread_info.h>

Since commit e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to
reduce guest/host thrashing", we do have <asm/thread_info.h>.

Since this header is not generic, this seems reasonable.  Is there
something from <linux/thread_info.h> used here that I'm missing?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
