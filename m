Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244EEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:28:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE63218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="it72VZ0G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMU5tEf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE63218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9ocHeh3Y+wMyuk87TLSXumqsgdZvtOE8yEP94sthWck=; b=it72VZ0GmWvSTa
	CtQ4+1FkGoi0LZ++k+SGQeGI/jF/jqEe/QnW8A6c57CJkkNOp0kG+gNLqsjy3uqlkvZQ/Bw833KcX
	u+wPTN1qzuLl0kZnx5rebfD4FUByN1jkz36GiNOASTP8IgtI9YFCIMQTTXI/AD1lIY7kfoT4T1jab
	Jc7/4oY/CddnbCKBeoFUuPRu3xPWqDXJ9qSlV2rBs1oZ0bGXZJAWfnlyDYeQgMx70wy/HW46nEKyB
	t73xwbO92Ml74F6WpBai4dLqPEuyCfh04EB6qrJTsvOTESZsEFRETzieeoJFOxKk4ec3BjJbunI4l
	aAHlaXQgKREXiSFk9gWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmqIM-0001qU-EC; Fri, 25 Jan 2019 01:28:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmqII-0001pz-Sd
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 01:28:32 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3C53218D0;
 Fri, 25 Jan 2019 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548379710;
 bh=Dc+kjHefFoULIbluXbDM/J8AI/ftwDAk/P/jrLbL1qU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZMU5tEf0OIuypeRCTKRWcPi5XljBoiIeFK2tMcCllRzXIbGI6nlZfTHaxqfKj0/or
 pMIb2kumryu2pxnhu0qbsOgUSDHhkKOBNe1RsBvF9L+oFssIOfmRMHSsfI5DCBSa8Z
 Y/pjSzeeVu8fccGldwYNC169K1RNgIDON1jy2S8I=
Date: Fri, 25 Jan 2019 10:28:26 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Forbid kprobing of the VHE
 world-switch code
Message-Id: <20190125102826.8b2b35e3d24efe18b4534e6e@kernel.org>
In-Reply-To: <20190124163257.233929-2-james.morse@arm.com>
References: <20190124163257.233929-1-james.morse@arm.com>
 <20190124163257.233929-2-james.morse@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_172830_960660_C2278FE6 
X-CRM114-Status: GOOD (  20.96  )
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

On Thu, 24 Jan 2019 16:32:54 +0000
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
> __hyp_text using NOKPROBE_SYMBOL().

This looks good to me!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Fixes: 3f5c90b890ac ("KVM: arm64: Introduce VHE-specific kvm_vcpu_run")
> ---
> 
> This has been an issue since the VHE/non-VHE world-switch paths were
> split.
> 
> 
> Changes since v1:
>  * Switched to NOKPROBE_SYMBOL() as this doesn't move code between
>    sections.
> 
> ---
>  arch/arm64/kvm/hyp/switch.c    | 5 +++++
>  arch/arm64/kvm/hyp/sysreg-sr.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index b0b1478094b4..421ebf6f7086 100644
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
> @@ -107,6 +108,7 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
>  
>  	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
>  }
> +NOKPROBE_SYMBOL(activate_traps_vhe);
>  
>  static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
>  {
> @@ -154,6 +156,7 @@ static void deactivate_traps_vhe(void)
>  	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
>  	write_sysreg(vectors, vbar_el1);
>  }
> +NOKPROBE_SYMBOL(deactivate_traps_vhe);
>  
>  static void __hyp_text __deactivate_traps_nvhe(void)
>  {
> @@ -513,6 +516,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  
>  	return exit_code;
>  }
> +NOKPROBE_SYMBOL(kvm_vcpu_run_vhe);
>  
>  /* Switch to the guest for legacy non-VHE systems */
>  int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
> @@ -620,6 +624,7 @@ static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
>  	      read_sysreg_el2(esr),   read_sysreg_el2(far),
>  	      read_sysreg(hpfar_el2), par, vcpu);
>  }
> +NOKPROBE_SYMBOL(__hyp_call_panic_vhe);
>  
>  void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *host_ctxt)
>  {
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 68d6f7c3b237..b426e2cf973c 100644
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
> @@ -98,12 +99,14 @@ void sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_save_common_state(ctxt);
>  }
> +NOKPROBE_SYMBOL(sysreg_save_host_state_vhe);
>  
>  void sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_save_common_state(ctxt);
>  	__sysreg_save_el2_return_state(ctxt);
>  }
> +NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
>  
>  static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>  {
> @@ -188,12 +191,14 @@ void sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_restore_common_state(ctxt);
>  }
> +NOKPROBE_SYMBOL(sysreg_restore_host_state_vhe);
>  
>  void sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt)
>  {
>  	__sysreg_restore_common_state(ctxt);
>  	__sysreg_restore_el2_return_state(ctxt);
>  }
> +NOKPROBE_SYMBOL(sysreg_restore_guest_state_vhe);
>  
>  void __hyp_text __sysreg32_save_state(struct kvm_vcpu *vcpu)
>  {
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
