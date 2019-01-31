Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B00C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:03:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982E120869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pj5/h0sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982E120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NXgA+9aSX94qEZeUXhjG4yszNSipwckfLM3Tg1nO0+M=; b=pj5/h0sanAucRs
	vrzXTF0YX9+A7NgRZ/PLsCyDN/eFn4S/kY9Kjurbzt7tCeqvAsi8BBeKTRJWa/lcl9fYJ3x73H+8H
	Wqwo1RBKHOciB3ZptnPjhonjETYUUiLYZ09nWsIyDnu5SQVwJFa7Blv8WV5qkQ8Z6FvrsYTCqtdVT
	TsFAzCE2qDrOX46hju4gNG8NX7fYcqVfgQ5ZhkPeY4Ome1N2oa3Q0Vu336rS7SgDFQcPowCqHZ1jt
	OCOkLR5j8qenWzYkHa2Fqf6jDZE4uIbmGyFeVq0Zf3oOTALpx4bvrcfHruYAAc6QQbQEp1NIeGQ6P
	zGie155EEj8G/hrLUuzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCwb-00066x-MG; Thu, 31 Jan 2019 14:03:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCwR-00062f-4g; Thu, 31 Jan 2019 14:03:45 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 178168AE76;
 Thu, 31 Jan 2019 14:03:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F5BD19C7B;
 Thu, 31 Jan 2019 14:03:40 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 400E418005AD;
 Thu, 31 Jan 2019 14:03:40 +0000 (UTC)
Date: Thu, 31 Jan 2019 09:03:40 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
To: Dave Young <dyoung@redhat.com>
Message-ID: <132532178.73826890.1548943420033.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
MIME-Version: 1.0
X-Originating-IP: [10.18.17.201, 10.4.195.7]
Thread-Topic: arm64,
 vmcoreinfo : Append 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to
 vmcoreinfo
Thread-Index: MeYcyy/BryvY1DbyP+TvAzZpMJsM/w==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 31 Jan 2019 14:03:41 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_060343_282551_0473FADF 
X-CRM114-Status: GOOD (  27.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 lijiang@redhat.com, bhe@redhat.com, ard biesheuvel <ard.biesheuvel@linaro.org>,
 catalin marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 bhupesh linux <bhupesh.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



----- Original Message -----
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
> > https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
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

With respect to the crash utility, this is the first time/architecture where the
determination of MAX_PHYSMEM_BITS cannot be determined.  

> 
> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> tree,  need to make sure to document this as well.
> 
> 2. MAX_USER_VA_BITS
> Does makedumpfile care about userspace VA bits?  I do not see other code
> doing this,  Kazu and Dave A should be able to comment.
> 
> I tend to doubt about this.

With respect to the crash utility, this won't be required because there is
the exported "vabits_user" variable.

Dave Anderson


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
> > diff --git a/arch/arm64/kernel/crash_core.c
> > b/arch/arm64/kernel/crash_core.c
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
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
