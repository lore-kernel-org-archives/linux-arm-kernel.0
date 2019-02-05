Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF4C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A99F2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/zKOWH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A99F2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oc+61SRV0RH+yAD1DG2PDhoLMMG4I58EMvukiX1+MLA=; b=o/zKOWH1zeomkK
	NOpOKvsFyuoATRtYey+VjuxbB5TQwp6BMbavJD6r8FRKcBOiKICxCSVoLIhpmEn88FUjN5xkHwL/t
	mrm1sjurUZVIMQ84gY1FU1w8N7qR/qKtm/UY3WOXyFzZIMeukc1DajcUhgU7iJgvgoc3YHxY7IrYp
	qI5TK1UmZRoBUMh3NoXugpbB+78CZNH4p+K+yoUyTFpt+inJDl4uNoY2FfyQPbgv+sH/kuAT0+SxG
	WEJ8k7K/KwDjGAa0QL+yfpuLLnNnHJ4w7fQ/iDLUU1SoDqBOjNXJUrtFgd8chMEodv3xgJFdcl+IF
	vemvNO21sxEQhGY0PtYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0Ac-0006JE-Mn; Tue, 05 Feb 2019 12:49:46 +0000
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0AZ-0006I4-3k
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:49:45 +0000
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym03.jp.fujitsu.com with smtp
 id 2b0d_2067_b5f06637_4d59_4936_822e_149e347252df;
 Tue, 05 Feb 2019 21:49:31 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6ED08AC00A3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  5 Feb 2019 21:49:31 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local
 (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 48E016924AC;
 Tue,  5 Feb 2019 21:49:30 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw15 ([10.0.194.54]) with mapi id 14.03.0415.000; Tue, 5 Feb 2019
 21:49:29 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Catalin Marinas' <catalin.marinas@arm.com>
Subject: RE: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AQHUt/4CQp2oaDwKnkWlIUKhrVqG76XRLzTQ
Date: Tue, 5 Feb 2019 12:49:28 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A30C360@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <20190129181032.GC224095@arrakis.emea.arm.com>
In-Reply-To: <20190129181032.GC224095@arrakis.emea.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044943_407862_881ECE14 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: 'Mark
 Rutland' <mark.rutland@arm.com>, "'james.morse@arm.com'" <james.morse@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Catalin,

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: Wednesday, January 30, 2019 3:11 AM
> To: Zhang, Lei 
> Cc: 'linux-kernel@vger.kernel.org'; 'Mark Rutland';
> 'linux-arm-kernel@lists.infradead.org'; 'will.deacon@arm.com';
> 'james.morse@arm.com'
> Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001
> 
> Could you please copy the whole description from the cover letter to the
> actual patch and only send one email (full description as in here
> together with the patch)? If we commit this to the kernel, it would be
> useful to have the information in the log for reference later on.

Thank you for your suggestion. I will send one email with whole description.

> So this looks like new information on the hardware behaviour since the
> v2 of the patch. Can this fault occur for any type of instruction
> accessing the memory or only for SVE instructions?

This erratum is that any load/store instruction, including Armv8 and SVE, 
except non-fault access might occur a spurious fault.

> How likely is it to trigger this erratum? In other words, aren't we
> better off with a spurious fault that we ignore rather than toggling the
> TCR_ELx.NFD1 bit?

Although the erratum occurs exceptionally rare, this path is required 
to handle the issue pointed out by James and Mark in:
  https://lkml.org/lkml/2019/1/22/533,
  https://lkml.org/lkml/2019/1/22/642.

As James and Mark pointed, if the erratum occurs at EL1/EL2 before 
system registers, ELR and SPSR, are backed up, these registers will 
be overwritten and we will lose that information.

So, we set the TCR_ELx.NFD1=0 during EL1/EL2.
Please see the supplemental explanation in the end of this mail.

> The problem is that this bit may be cached in the TLB (I haven't checked
> the ARM ARM but that's usually the case with the TCR_ELx bits). If
> that's the case, you can't guarantee a change unless you also perform
> a
> TLBI VMALL. Arguably, if Fujitsu's microarchitecture doesn't cache the
> NFD bits in the TLB, we could apply the workaround but I'd rather have
> the spurious trap if it's not too often.

It is not necessary to perform a TLBI VMALL in A64FX microarchitecture 
to guarantee a change of TCR_ELx.{NFD0,NFD1}. 

> Could speculative loads also trigger this? Another option would be to
> toggle it during kernel_neon_begin/end (with the caveat of TLBI as
> mentioned above).

No, a speculative load does not trigger this erratum. 

Here are supplemental explanations:

Since this erratum occurs only when TCR_ELx.NFD1=1, 
we keep TCR_ELx.NFD1=0 during EL1/EL2.
By doing so, the erratum occurs only in EL0 and the 
spurious trap can be handled by the fault handler.

To keep TCR_ELx.NFD1=0 in EL1/EL2, there are two critical 
sections to assure the completeness of the implementation.
One is the transition from EL0 to EL1/EL2 and the other 
is from EL1/EL2 to EL0

For the former case, I set TCR_ELx.NFD1=0 at codes tramp_map_kernel. 
And there is no load/store instruction before setting 
TCR_ELx.NFD1=0 at EL1/EL2, so undefined fault will not be happened.

For the latter case, I set TCR_ELx.NFD1=1 at codes tramp_unmap_kernel. 
And there is no load/store instruction after setting 
TCR_ELx.NFD1=1 at EL1/EL2, so undefined fault will not be happened.

To handle the spurious fault in EL0,
I replace the fault handler for Data abort DFSC=0b111111 with 
a new fault handler to ignore this spurious fault caused by the erratum.

Thanks,
Zhang Lei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
