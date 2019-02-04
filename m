Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C686214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vxulax4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C686214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vyo9n7LMvTtgTm0TwtEkFsKwVcsBqIOkQr10DZRJ2dU=; b=Vxulax4XLQZ8Q3
	cRL0JvL8LOvyWOH7INwscOj+a0QxlN22uOLWp6dWz/jbkR7PYl2RY37Tr309ZijJArZtOjzHFb5v0
	LD7zWiL/xV3JM0+ycKroKNNPVcdDIjUDzfwsU47Orgl8ki6PwhdXHAxGiHu4CgHL6DQ8VHrMAxUZ2
	0EYksDPumtvvm7EWeVOcvDapWUmY2UBy5f0jWK8Upgx3JIK7OFPOeu3462cfGFrrFg0uGQZYrkSzg
	YuDRaEWU0EBlvhbUUpn29RfNgojE1Ev8vvEhD9aVuY7XA8OtMyiIjqtDoYx2eVMlxYDCWpD+ronAn
	EdraqNzpMjdaQhPMPpng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgkQ-0001Qs-0n; Mon, 04 Feb 2019 16:05:26 +0000
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgkL-0001QP-VO; Mon, 04 Feb 2019 16:05:24 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x14G54lC018436
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 5 Feb 2019 01:05:04 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x14G53go020096;
 Tue, 5 Feb 2019 01:05:03 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x14G4WDQ027622;
 Tue, 5 Feb 2019 01:05:03 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by
 mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2107862;
 Tue, 5 Feb 2019 01:04:34 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Tue, 5
 Feb 2019 01:04:33 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To: Dave Young <dyoung@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHUuQb/BT+pA4VdFkyjzG4/innmbKXP0wNA
Date: Mon, 4 Feb 2019 16:04:33 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.132.183]
MIME-Version: 1.0
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_080522_241160_640DBA9D 
X-CRM114-Status: GOOD (  24.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 "anderson@redhat.com" <anderson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/2019 8:48 PM, Dave Young wrote:
> + more people
> On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
> > With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> > supports these extensions can support upto 52-bit virtual and 52-bit
> > physical addresses respectively.
> >
> > Since at the moment we enable the support of these extensions via CONFIG
> > flags, e.g.
> >  - LPA via CONFIG_ARM64_PA_BITS_52
> >
> > there are no clear mechanisms in user-space right now to
> > deteremine these CONFIG flag values and also determine the PARange and
> > VARange address values.
> >
> > User-space tools like 'makedumpfile' and 'crash-utility' can instead
> > use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> > the maximum virtual address and physical address (respectively)
> > supported by underlying kernel.
> >
> > A reference 'makedumpfile' implementation which uses this approach to
> > determining the maximum physical address is available in [0].
> >
> > [0].
> https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
> 
> I'm not objecting the patch, just want to make sure to make clear about
> things and make sure these issues are aware by people, and leave arm
> people to review the arm bits.
> 
> 1. MAX_PHYSMEM_BITS
> As we previously found, back to 2014 makedumpfile took a patch to read the
> value from vmcore but the kernel patch was not accepted.
> So we should first make clear if this is really needed, why other arches
> do not need this in makedumpfile.
> 
> If we really need it then should it be arm64 only?
> 
> If it is arm64 only then the makedumpfile code should read this number
> only for arm64.

Sorry for the delay.

According to the kernel patch, some of arm32 platforms may need it
http://lists.infradead.org/pipermail/kexec/2014-May/011909.html
but except for them (and arm64), makedumpfile can manage with kernel
version and some switches to determine this value so far.

> 
> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> tree,  need to make sure to document this as well.
> 
> 2. MAX_USER_VA_BITS
> Does makedumpfile care about userspace VA bits?  I do not see other code
> doing this,  Kazu and Dave A should be able to comment.

The mapping makedumpfile uses on arm64 is swapper_pg_dir only, so
unless the config affects its structure or something, makedumpfile
will not need this value.

Thanks,
Kazu

> 
> I tend to doubt about this.
> 
> >
> > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/kernel/crash_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> > index ca4c3e12d8c5..ad231be5c0d8 100644
> > --- a/arch/arm64/kernel/crash_core.c
> > +++ b/arch/arm64/kernel/crash_core.c
> > @@ -10,6 +10,8 @@
> >  void arch_crash_save_vmcoreinfo(void)
> >  {
> >  	VMCOREINFO_NUMBER(VA_BITS);
> > +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
> > +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> >  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> >  	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> >  						kimage_voffset);
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> Thanks
> Dave



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
