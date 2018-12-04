Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D22C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34A520659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GVAq/wGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34A520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dKFbTpgkIpaGIgnF9f2ngTS4qfULV7UTjewbWhrKWkY=; b=GVAq/wGzMErzTS
	T/ta9bwww/9wrEPZozvSgRjYLUW9b8U9PJ3/yTeqeQbiKawvnDT1IaXv1/Bqb3Td4SMcoFhdqOg5X
	Lchfw420Xb3KLBXJBI6l9vhBz8DdRrLB7PPhyZAJ8/nxfC/W9+EdUUm/0cEB8lwPsq72IJdCbQciZ
	Go0CreiK/4ootPH15QdAs/m7/WkFjTOPEGNWHPlV986Y/pqJE3Jjt85hJTMPER/BPTI+SY0jKIWlj
	GJgUvR1CxyTGyAGO5Pa1QcChYRMehby2vppBREnHYs+TW4aK83EgFNbrFb4Na4Szr/pF8AcxIF4hz
	bOS7dGwxAv52K3mD6gLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDMz-0001tK-L0; Tue, 04 Dec 2018 16:16:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDMv-0001sl-Rq
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:16:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78443A78;
 Tue,  4 Dec 2018 08:16:05 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDA653F614;
 Tue,  4 Dec 2018 08:16:03 -0800 (PST)
Subject: Re: [PATCH v4 4/4] arm64: KVM: Enable support for :G/:H perf event
 modifiers
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1543935500-23207-1-git-send-email-andrew.murray@arm.com>
 <1543935500-23207-5-git-send-email-andrew.murray@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <4ddb1abb-441d-b504-790d-f2bc45c52db9@arm.com>
Date: Tue, 4 Dec 2018 16:16:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1543935500-23207-5-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_081617_908006_D168DEAA 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On 04/12/18 14:58, Andrew Murray wrote:
> Enable/disable event counters as appropriate when entering and exiting
> the guest to enable support for guest or host only event counting.
> 
> For both VHE and non-VHE we switch the counters between host/guest at
> EL2. EL2 is filtered out by the PMU when we are using the :G modifier.
> 
> The PMU may be on when we change which counters are enabled however
> we avoid adding an isb as we instead rely on existing context
> synchronisation events: the isb in kvm_arm_vhe_guest_exit for VHE and
> the eret from the hvc in kvm_call_hyp.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/kvm/hyp/switch.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d496ef5..5e03921 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -373,6 +373,35 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>  
> +static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +	u32 host = host_ctxt->events_host;
> +	u32 guest = host_ctxt->events_guest;
> +
> +	if (host == guest)
> +		return false;
> +
> +	if (host)
> +		write_sysreg(host, pmcntenclr_el0);

Nit:
Instead of clearing host counters we could clear non-guest counters:

	u32 clear_events = host_ctxt->events_hosts & ~guest;
		
	if (clear_events)
		write_sysreg(clear_events, pmcntenclr_el0);

Don't know if it makes a lot of difference.

> +
> +	if (guest)
> +		write_sysreg(guest, pmcntenset_el0);
> +
> +	return (host || guest);

We know this is true. If both (host == 0 && guest == 0) then (host ==
guest) meaning we returned false.


> +}
> +
> +static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
> +{
> +	u32 host = host_ctxt->events_host;
> +	u32 guest = host_ctxt->events_guest;
> +
> +	if (guest)
> +		write_sysreg(guest, pmcntenclr_el0);

Nit:
Same as above, we could just clear the counters that are exclusive to
the guest.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
