From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 16:36:36 +0000
Subject: [PATCH v5 08/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <20130108183931.46302.60921.stgit@ubuntu>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183931.46302.60921.stgit@ubuntu>
Message-ID: <20130114163636.GG23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 01:39:31PM -0500, Christoffer Dall wrote:
> +	/*
> +	 * Check whether this vcpu requires the cache to be flushed on
> +	 * this physical CPU. This is a consequence of doing dcache
> +	 * operations by set/way on this vcpu. We do it here to be in
> +	 * a non-preemptible section.
> +	 */
> +	if (cpumask_test_cpu(cpu, &vcpu->arch.require_dcache_flush)) {
> +		cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);

There is cpumask_test_and_clear_cpu() which may be better for this.
