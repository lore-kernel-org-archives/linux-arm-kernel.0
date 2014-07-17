From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 23:14:36 +0100
Subject: [PATCH] ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs
In-Reply-To: <1405617110-1136-1-git-send-email-romain.perier@gmail.com>
References: <1405617110-1136-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140717221436.GZ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 05:11:50PM +0000, Romain Perier wrote:
> +static DECLARE_COMPLETION(cpu_died);
> +
> +static int rockchip_cpu_kill(unsigned int cpu)
> +{
> +	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(1000))) {
> +		pr_err("CPU%d: didn't die correctly\n", cpu);
> +		return 0;
> +	}

Please explain the point of this cpu_died thing.

I think you should read arch/arm/kernel/smp.c, searching for cpu_died
in there.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
