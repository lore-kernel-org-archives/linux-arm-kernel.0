From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 26 Jul 2013 11:00:48 -0400 (EDT)
Subject: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
In-Reply-To: <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013, Lorenzo Pieralisi wrote:

> +static int notrace bl_powerdown_finisher(unsigned long arg)
> +{
> +	/* MCPM works with HW CPU identifiers */
> +	unsigned int mpidr = read_cpuid_mpidr();
> +	unsigned int cluster = (mpidr >> 8) & 0xf;
> +	unsigned int cpu = mpidr & 0xf;

You probably want to use the MPIDR_AFFINITY_LEVEL() macro here.


Nicolas
