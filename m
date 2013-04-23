From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 20:42:37 +0100
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP
 operation if required
In-Reply-To: <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423194237.GE5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:22:12AM -0500, Nicolas Pitre wrote:
> +void __init vexpress_smp_init_ops(void)
> +{
> +	struct smp_operations *ops = &vexpress_smp_ops;
> +#ifdef CONFIG_CLUSTER_PM
> +	extern struct smp_operations mcpm_smp_ops;
> +	if(of_find_compatible_node(NULL, NULL, "arm,cci"))
> +		ops = &mcpm_smp_ops;

Hmm, so these patches haven't been subjected to checkpatch treatment?
As a seasoned kernel programmer, I'm surprised you haven't checked that
already.
