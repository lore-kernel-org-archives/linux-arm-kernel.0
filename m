Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1232C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A6F2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oyU+fM3n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpQMg22O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A6F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u8T7caamiKaIlq7G71JWY7g+SdbABep3c1xV+pLN0T0=; b=oyU+fM3nTfH2T8
	iq0w+AoiZmoTR9eVNNiBDWw8uD72TJ1LTrfwo1xBWJB90zu9HOifEugk3ua2TdWpOyaWZZQjQzplA
	i3inQq+HI/MkJ7V9HV8hf/VTr1zQ2En5kjRg2FIcXmq+s8RXHy9EGuvGgKJyxNv1UdJwD2qTuD1YE
	WalSUDABREdQ7Pq8wdFxtwiGtJskLokvq7ps19pHhDp4u+iSnyx1Ma5Inor4dckJzcVHmy1a6t3h1
	iNQ9HMmcnEpkwDfRbqF8577qtRhTbN3E+lmSLcCkOH/CmLo/sroP6leDByD4OTBrG55NMp732qpkQ
	mjefhOk00ynEdN3Fsp1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glmTG-0006Ve-QJ; Tue, 22 Jan 2019 03:11:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glmTD-0006VK-Cp
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 03:11:25 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC79F2085A;
 Tue, 22 Jan 2019 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548126683;
 bh=SC25KCGp6kA0m8UPCcANMYDAanAKYeFBvpZ7JjbMHCg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qpQMg22O3Ga+7e5boCuOWylKuAgWQt5eJWCbFdfFSmbhsT+hfQp89bYMty5vobv4R
 LSbKtG6NGUuiJIBvY2NO/0Rb20o+hBfjtK1KEadSQvHrpY3+1RL6hyK0iC5+IiMgUG
 kPBLgt+NHbac3mZh1xK6BJorxEPZiJT85YRceUag=
Date: Tue, 22 Jan 2019 12:11:20 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/4] KVM: arm64: Forbid kprobing of the VHE world-switch
 code
Message-Id: <20190122121120.b781ced513220436da1e6d09@kernel.org>
In-Reply-To: <20190121170404.142966-2-james.morse@arm.com>
References: <20190121170404.142966-1-james.morse@arm.com>
 <20190121170404.142966-2-james.morse@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_191123_471755_59CB9D70 
X-CRM114-Status: GOOD (  23.19  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

On Mon, 21 Jan 2019 17:04:01 +0000
James Morse <james.morse@arm.com> wrote:

> On systems with VHE the kernel and KVM's world-switch code run at the
> same exception level. Code that is only used on a VHE system does not
> need to be annotated as __hyp_text as it can reside anywhere in the
> kernel text.
> 
> __hyp_text was also used to prevent kprobes from patching breakpoint
> instructions into this region, as this code runs at a different
> exception level. While this is no longer true with VHE, KVM still
> switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
> world-switch code will cause a hyp-panic.
> 
> echo "p:weasel sysreg_save_guest_state_vhe" > /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/weasel/enable
> lkvm run -k /boot/Image --console serial -p "console=ttyS0 earlycon=uart,mmio,0x3f8"
> 
>   # lkvm run -k /boot/Image -m 384 -c 3 --name guest-1474
>   Info: Placing fdt at 0x8fe00000 - 0x8fffffff
>   Info: virtio-mmio.devices=0x200@0x10000:36
> 
>   Info: virtio-mmio.devices=0x200@0x10200:37
> 
>   Info: virtio-mmio.devices=0x200@0x10400:38
> 
> [  614.178186] Kernel panic - not syncing: HYP panic:
> [  614.178186] PS:404003c9 PC:ffff0000100d70e0 ESR:f2000004
> [  614.178186] FAR:0000000080080000 HPFAR:0000000000800800 PAR:1d00007edbadc0de
> [  614.178186] VCPU:00000000f8de32f1
> [  614.178383] CPU: 2 PID: 1482 Comm: kvm-vcpu-0 Not tainted 5.0.0-rc2 #10799
> [  614.178446] Call trace:
> [  614.178480]  dump_backtrace+0x0/0x148
> [  614.178567]  show_stack+0x24/0x30
> [  614.178658]  dump_stack+0x90/0xb4
> [  614.178710]  panic+0x13c/0x2d8
> [  614.178793]  hyp_panic+0xac/0xd8
> [  614.178880]  kvm_vcpu_run_vhe+0x9c/0xe0
> [  614.178958]  kvm_arch_vcpu_ioctl_run+0x454/0x798
> [  614.179038]  kvm_vcpu_ioctl+0x360/0x898
> [  614.179087]  do_vfs_ioctl+0xc4/0x858
> [  614.179174]  ksys_ioctl+0x84/0xb8
> [  614.179261]  __arm64_sys_ioctl+0x28/0x38
> [  614.179348]  el0_svc_common+0x94/0x108
> [  614.179401]  el0_svc_handler+0x38/0x78
> [  614.179487]  el0_svc+0x8/0xc
> [  614.179558] SMP: stopping secondary CPUs
> [  614.179661] Kernel Offset: disabled
> [  614.179695] CPU features: 0x003,2a80aa38
> [  614.179758] Memory Limit: none
> [  614.179858] ---[ end Kernel panic - not syncing: HYP panic:
> [  614.179858] PS:404003c9 PC:ffff0000100d70e0 ESR:f2000004
> [  614.179858] FAR:0000000080080000 HPFAR:0000000000800800 PAR:1d00007edbadc0de
> [  614.179858] VCPU:00000000f8de32f1 ]---
> 
> Annotate the VHE world-switch functions that aren't marked
> __hyp_text as __kprobes.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Fixes: 3f5c90b890ac ("KVM: arm64: Introduce VHE-specific kvm_vcpu_run")
> ---
> This has been an issue since the VHE/non-VHE world-switch paths were
> split. Before then the code was common, and covered by __hyp_text, which
> is always blacklisted by a subsequent patch.

Thank you very much for fixing it!

BTW, would you mind if I ask you using NOKPROBE_SYMBOL() macro instead of
__kprobes attribute? __kprobes moves the function into __kprobe_text
forcibly, OTOH, NOKPROBE_SYMBOL() has no such side-effect.

Thank you,

> 
> ---
>  arch/arm64/kvm/hyp/switch.c    | 11 ++++++-----
>  arch/arm64/kvm/hyp/sysreg-sr.c |  9 +++++----
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index b0b1478094b4..21c291586832 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -23,6 +23,7 @@
>  #include <kvm/arm_psci.h>
>  
>  #include <asm/cpufeature.h>
> +#include <asm/kprobes.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_host.h>
> @@ -91,7 +92,7 @@ static void __hyp_text __deactivate_traps_common(void)
>  	write_sysreg(0, pmuserenr_el0);
>  }
>  
> -static void activate_traps_vhe(struct kvm_vcpu *vcpu)
> +static void __kprobes activate_traps_vhe(struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
>  
> @@ -139,7 +140,7 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  		__activate_traps_nvhe(vcpu);
>  }
>  
> -static void deactivate_traps_vhe(void)
> +static void __kprobes deactivate_traps_vhe(void)
>  {
>  	extern char vectors[];	/* kernel exception vectors */
>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> @@ -460,7 +461,7 @@ static void __hyp_text __set_host_arch_workaround_state(struct kvm_vcpu *vcpu)
>  }
>  
>  /* Switch to the guest for VHE systems running in EL2 */
> -int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
> +int __kprobes kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *host_ctxt;
>  	struct kvm_cpu_context *guest_ctxt;
> @@ -606,8 +607,8 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
>  		       read_sysreg(hpfar_el2), par, vcpu);
>  }
>  
> -static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
> -				 struct kvm_cpu_context *host_ctxt)
> +static void __kprobes __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
> +					   struct kvm_cpu_context *host_ctxt)
>  {
>  	struct kvm_vcpu *vcpu;
>  	vcpu = host_ctxt->__hyp_running_vcpu;
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 68d6f7c3b237..fbb6001ecdf7 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -18,6 +18,7 @@
>  #include <linux/compiler.h>
>  #include <linux/kvm_host.h>
>  
> +#include <asm/kprobes.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_hyp.h>
> @@ -94,12 +95,12 @@ void __hyp_text __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt)
>  	__sysreg_save_el2_return_state(ctxt);
>  }
>  
> -void sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt)
> +void __kprobes sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_save_common_state(ctxt);
>  }
>  
> -void sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt)
> +void __kprobes sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_save_common_state(ctxt);
>  	__sysreg_save_el2_return_state(ctxt);
> @@ -184,12 +185,12 @@ void __hyp_text __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt)
>  	__sysreg_restore_el2_return_state(ctxt);
>  }
>  
> -void sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt)
> +void __kprobes sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_restore_common_state(ctxt);
>  }
>  
> -void sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt)
> +void __kprobes sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_restore_common_state(ctxt);
>  	__sysreg_restore_el2_return_state(ctxt);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
