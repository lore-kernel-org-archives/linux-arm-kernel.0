Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B31E20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iuN/ppXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B31E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRfkUoxe2fGhdKjpjM34McUei9wZE06inaZG5CfYmUc=; b=iuN/ppXPQyl1Zc
	JT2C3arxNfHJhKHwwGSc6LXSm5Uk/oOuh1JuzMzCMfZJEtAN3Zeuna0M/cqkW5M2MWdWwqVAKlB7h
	uos7ZcHmUO+U2acjCA6V2oy/8QdnEPTKgDt82tsnaQuyRCXgQEWqPLppTxirJspwcPcYEJ/n6kOwg
	k8hQAesotjDZxSkpGYR35f+ZkBFldwxUVJUdqAOc9KKXptpfFP+0oJlTDZ/CkJg+0YzaV9PJEe3E6
	mu13gRUdBoOCnve7IrsUP3xQpVuEtH93BYA/RLPdjIzGNTKfX4WIA9jEyXiPzJgwFid1XQfIQZu8M
	kVhoLhljsKX+6xjoHJ6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp1Sm-0002sP-Fd; Thu, 31 Jan 2019 01:48:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp1Sg-0002rR-2w; Thu, 31 Jan 2019 01:48:18 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07B0EC0601ED;
 Thu, 31 Jan 2019 01:48:13 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-51.pek2.redhat.com
 [10.72.12.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC49298BF;
 Thu, 31 Jan 2019 01:48:04 +0000 (UTC)
Date: Thu, 31 Jan 2019 09:48:00 +0800
From: Dave Young <dyoung@redhat.com>
To: Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Message-ID: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 31 Jan 2019 01:48:13 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_174816_635495_F1B6630D 
X-CRM114-Status: GOOD (  24.56  )
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
 lijiang@redhat.com, bhe@redhat.com, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 anderson@redhat.com, bhupesh.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ more people
On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> supports these extensions can support upto 52-bit virtual and 52-bit
> physical addresses respectively.
> 
> Since at the moment we enable the support of these extensions via CONFIG
> flags, e.g.
>  - LPA via CONFIG_ARM64_PA_BITS_52
> 
> there are no clear mechanisms in user-space right now to
> deteremine these CONFIG flag values and also determine the PARange and
> VARange address values.
> 
> User-space tools like 'makedumpfile' and 'crash-utility' can instead
> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> the maximum virtual address and physical address (respectively)
> supported by underlying kernel.
> 
> A reference 'makedumpfile' implementation which uses this approach to
> determining the maximum physical address is available in [0].
> 
> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490

I'm not objecting the patch, just want to make sure to make clear about
things and make sure these issues are aware by people, and leave arm
people to review the arm bits.

1. MAX_PHYSMEM_BITS
As we previously found, back to 2014 makedumpfile took a patch to read the
value from vmcore but the kernel patch was not accepted.
So we should first make clear if this is really needed, why other arches
do not need this in makedumpfile.

If we really need it then should it be arm64 only?

If it is arm64 only then the makedumpfile code should read this number
only for arm64.

Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
tree,  need to make sure to document this as well.

2. MAX_USER_VA_BITS
Does makedumpfile care about userspace VA bits?  I do not see other code
doing this,  Kazu and Dave A should be able to comment.

I tend to doubt about this.

> 
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/kernel/crash_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e12d8c5..ad231be5c0d8 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -10,6 +10,8 @@
>  void arch_crash_save_vmcoreinfo(void)
>  {
>  	VMCOREINFO_NUMBER(VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>  	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>  						kimage_voffset);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
