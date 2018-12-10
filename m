Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:07:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C8120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDrKYoeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C8120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8ybBW7YzVpDhkOXFYVuIZATStOZQalj1lBA2dBK0FY=; b=TDrKYoeq1ouviO
	1VjZ8PCmiyGxTWIW+3ssY9gwQK8oK3F6/VEzz9adA9uhYCgrSkOn8hghPU1TEKv5ZoF5hXT5kp510
	jcbIuJkxH7wMu+5POR2xXQq9kWszgvIt5kWN5YU86GiB1v0xiDpqVwmkRUTBRtuIbNDdFgyzJVXdN
	jJOF0UsAdfbWDD5y0I6Fju+mQ3QVAkLLcciMo/qh39zGdjFrtQrHiktvgAwygiYcJBon9A3F4eLhV
	rMMl0Whx+1BOOdA/c4Dqdf/MgJPn15klgVBxCuCMiX7s/ppny4U2iAmieSVtWmt/pYhtYZcy71cWL
	c72xwtiDt5zXVBksByBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPyI-0005mO-Aw; Mon, 10 Dec 2018 18:07:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPyD-0005lx-Rw
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:07:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A1FEBD;
 Mon, 10 Dec 2018 10:07:41 -0800 (PST)
Received: from en101 (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB68D3F6A8;
 Mon, 10 Dec 2018 10:07:39 -0800 (PST)
Date: Mon, 10 Dec 2018 18:07:33 +0000
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
To: Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH V5 5/7] arm64: mm: Prevent mismatched 52-bit VA support
Message-ID: <20181210180733.GA17080@en101>
References: <20181206225042.11548-6-steve.capper@arm.com>
 <81860712-ff5f-5a51-d39e-9db9e3d31a26@arm.com>
 <20181207152529.GB2682@edgewater-inn.cambridge.arm.com>
 <be06b735-c6b4-1520-73f6-02a3a8e8af45@arm.com>
 <20181210133640.GA31425@edgewater-inn.cambridge.arm.com>
 <20181210160348.GA4564@capper-debian.cambridge.arm.com>
 <20181210161826.GA11135@edgewater-inn.cambridge.arm.com>
 <20181210165538.GA26756@capper-debian.cambridge.arm.com>
 <20181210170831.GA28176@capper-debian.cambridge.arm.com>
 <20181210174234.GA24059@capper-debian.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210174234.GA24059@capper-debian.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_100753_912613_DA0B7CC8 
X-CRM114-Status: GOOD (  38.08  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 05:42:45PM +0000, Steve Capper wrote:
> On Mon, Dec 10, 2018 at 05:08:31PM +0000, Steve Capper wrote:
> > On Mon, Dec 10, 2018 at 04:55:38PM +0000, Steve Capper wrote:
> > > On Mon, Dec 10, 2018 at 04:18:26PM +0000, Will Deacon wrote:
> > > > On Mon, Dec 10, 2018 at 04:04:02PM +0000, Steve Capper wrote:
> > > > > On Mon, Dec 10, 2018 at 01:36:40PM +0000, Will Deacon wrote:
> > > > > > On Fri, Dec 07, 2018 at 05:28:58PM +0000, Suzuki K Poulose wrote:
> > > > > > > On 07/12/2018 15:26, Will Deacon wrote:
> > > > > > > > On Fri, Dec 07, 2018 at 10:47:57AM +0000, Suzuki K Poulose wrote:
> > > > > > > > > On 12/06/2018 10:50 PM, Steve Capper wrote:
> > > > > > > > > > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > > > > > > > > > index f60081be9a1b..58fcc1edd852 100644
> > > > > > > > > > --- a/arch/arm64/kernel/head.S
> > > > > > > > > > +++ b/arch/arm64/kernel/head.S
> > > > > > > > > > @@ -707,6 +707,7 @@ secondary_startup:
> > > > > > > > > >    	/*
> > > > > > > > > >    	 * Common entry point for secondary CPUs.
> > > > > > > > > >    	 */
> > > > > > > > > > +	bl	__cpu_secondary_check52bitva
> > > > > > > > > >    	bl	__cpu_setup			// initialise processor
> > > > > > > > > >    	adrp	x1, swapper_pg_dir
> > > > > > > > > >    	bl	__enable_mmu
> > > > > > > > > > @@ -785,6 +786,31 @@ ENTRY(__enable_mmu)
> > > > > > > > > >    	ret
> > > > > > > > > >    ENDPROC(__enable_mmu)
> > > > > > > > > > +ENTRY(__cpu_secondary_check52bitva)
> > > > > > > > > > +#ifdef CONFIG_ARM64_52BIT_VA
> > > > > > > > > > +	ldr_l	x0, vabits_user
> > > > > > > > > > +	cmp	x0, #52
> > > > > > > > > > +	b.ne	2f > +
> > > > > > > > > > +	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
> > > > > > > > > > +	and	x0, x0, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
> > > > > > > > > > +	cbnz	x0, 2f
> > > > > > > > > > +
> > > > > > > > > > +	adr_l	x0, va52mismatch
> > > > > > > > > > +	mov	w1, #1
> > > > > > > > > > +	strb	w1, [x0]
> > > > > > > > > > +	dmb	sy
> > > > > > > > > > +	dc	ivac, x0	// Invalidate potentially stale cache line
> > > > > > > > > 
> > > > > > > > > You may have to clear this variable before a CPU is brought up to avoid
> > > > > > > > > raising a false error message when another secondary CPU doesn't boot
> > > > > > > > > for some other reason (say granule support) after a CPU failed with lack
> > > > > > > > > of 52bitva. It is really a crazy corner case.
> > > > > > > > 
> > > > > > > > Can't we just follow the example set by the EL2 setup in the way that is
> > > > > > > > uses __boot_cpu_mode? In that case, we only need one variable and you can
> > > > > > > > detect a problem by comparing the two halves.
> > > > > > > 
> > > > > > > The only difference here is, the support is bolted at boot CPU time and hence
> > > > > > > we need to verify each and every CPU, unlike the __boot_cpu_mode where we
> > > > > > > check for mismatch after the SMP CPUs are brought up. If we decide to make
> > > > > > > the choice later, something like that could work. The only caveat is the 52bit
> > > > > > > kernel VA will have to do something like the above.
> > > > > > 
> > > > > > So looking at this a bit more, I think we're better off repurposing the
> > > > > > upper bits of the early boot status word to contain a reason code, rather
> > > > > > than introducing new variables for every possible mismatch.
> > > > > > 
> > > > > > Does the untested diff below look remotely sane to you?
> > > > > > 
> > > > > > Will
> > > > > > 
> > > > > 
> > > > > Thanks Will,
> > > > > This looks good to me, I will test now and fold this into a patch.
> > > > 
> > > > Cheers, Steve. Testing would be handy, but don't worry about respinning the
> > > > patches as I'm already on top of this and hope to push this out later today.
> > > > 
> > > 
> > > Thanks Will,
> > > This looks good to me so FWIW:
> > > Tested-by: Steve Capper <steve.capper@arm.com>
> > > 
> > > (for both the 52-bit VA mismatch and 64KB granule not supported cases
> > > using the model).
> > > 
> > > The only small issue I see is that if subsequent CPUs aren't brought
> > > online (because they don't exist in the model) then the error reason is
> > > repeated.
> > > 
> > > I'll dig into this.
> > >
> > 
> > I think __early_cpu_boot_status needs to be reset at the beginning of
> > __cpu_up before the secondary is booted. Testing a check for this now.
> >
> 




> Hi Will,
> 
> The following fixed the repeating error message problem for me. If you
> want, I can send a separate patch to fix this?
> 
> Cheers,
> -- 
> Steve
> 
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4e3bfbde829a..936156a7ae88 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -123,6 +123,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	update_cpu_boot_status(CPU_MMU_OFF);
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>  
> +	__early_cpu_boot_status = 0;
> +	dsb(ishst);
> +	__flush_dcache_area(&__early_cpu_boot_status,
> +			sizeof(__early_cpu_boot_status));
> +
>  	/*
>  	 * Now bring the CPU into our world.
>  	 */
>

I have tested Will's changes and hit the issue reported by Steve. But this
is mainly due to a bug in our __cpu_up() code, which ignores the errors reported
by the firmware and goes ahead assuming that the CPU entered the kernel and
failed so in the process.

e.g, with a missing CPU3:

[   78.050880] psci: failed to boot CPU3 (-22)
[   78.051079] CPU3: failed to boot: -22
[   78.051319] CPU3: is stuck in kernel
[   78.051496] CPU3: does not support 52-bit VAs

With the fix attached below, I get:
# echo 1 > cpu5/online
[  101.883862] CPU5: failed to come online
[  101.884860] CPU5: is stuck in kernel
[  101.885060] CPU5: does not support 52-bit VAs
-sh: echo: write error: Input/output error
# echo 1 > cpu3/online
[  106.746141] psci: failed to boot CPU3 (-22)
[  106.746360] CPU3: failed to boot: -22
-sh: echo: write error: Invalid argument


----8>----

arm64: smp: Handle errors reported by the firmware

The __cpu_up() routine ignores the errors reported by the firmware
for a CPU bringup operation and looks for the error status set by the
booting CPU. If the CPU never entered the kernel, we could end up
in assuming stale error status, which otherwise would have been
set/cleared appropriately by the booting CPU.

Reported-by: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ac73d6c..a854e3d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -141,6 +141,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		}
 	} else {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		return ret;
 	}
 
 	secondary_data.task = NULL;
-- 
2.7.4

 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
