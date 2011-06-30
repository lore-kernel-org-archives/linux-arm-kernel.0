From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 14:11:54 +0100
Subject: [PATCH] arm: platsmp: Allow secondary cpu hotplug with maxcpus=1
In-Reply-To: <1309372300-28911-1-git-send-email-sboyd@codeaurora.org>
References: <1309372300-28911-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110630131154.GJ23312@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 11:31:39AM -0700, Stephen Boyd wrote:
>  void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	int i;
> -
>  	/*
>  	 * Initialise the present map, which describes the set of CPUs
>  	 * actually populated at the present time.
>  	 */
> -	for (i = 0; i < max_cpus; i++)
> -		set_cpu_present(i, true);
> +	init_cpu_present(&cpu_possible_map);

Ok, if we're now doing this in every platform, it might as well go into
arch/arm/kernel/smp.c - platforms can re-initialize the present map
in this callback if they need to do something different.
