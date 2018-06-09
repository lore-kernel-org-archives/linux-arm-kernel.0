From: jcm@jonmasters.org (Jon Masters)
Date: Sat, 9 Jun 2018 08:53:08 -0400
Subject: [PATCH v2 05/17] arm64: Add 'ssbd' command-line option
In-Reply-To: <20180529121121.24927-6-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
 <20180529121121.24927-6-marc.zyngier@arm.com>
Message-ID: <e1b89362-ba94-ead9-a930-eac0e1b3ffba@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2018 08:11 AM, Marc Zyngier wrote:

> +	ssbd=		[ARM64,HW]
> +			Speculative Store Bypass Disable control
> +
> +			On CPUs that are vulnerable to the Speculative
> +			Store Bypass vulnerability and offer a
> +			firmware based mitigation, this parameter
> +			indicates how the mitigation should be used:
> +
> +			force-on:  Unconditionally enable mitigation for
> +				   for both kernel and userspace
> +			force-off: Unconditionally disable mitigation for
> +				   for both kernel and userspace
> +			kernel:    Always enable mitigation in the
> +				   kernel, and offer a prctl interface
> +				   to allow userspace to register its
> +				   interest in being mitigated too.

This should be "spec_store_bypass_disable" and it should have the same
parameters as on x86: "on", "off", "auto". Why not just add "kernel"?
(we had a "kernel" early on for x86 as well, and it might still end up
coming back anyway). If there's a /compelling/ reason to have the Arm
parameter differ, then it should still recognize the x86 parameter,
similarly to how POWER also does that for cross-arch consistency.

We'll add the x86 parameter way of doing it to RHEL anyway.

Jon.
