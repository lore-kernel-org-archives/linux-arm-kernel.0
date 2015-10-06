From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 10:09:59 +0100
Subject: [PATCH v2 21/22] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1
 to sysfs
In-Reply-To: <1444064531-25607-22-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-22-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151006090959.GO21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 06:02:10PM +0100, Suzuki K. Poulose wrote:
> +static int __init cpuinfo_regs_init(void)
> +{
> +	int cpu, ret;
> +
> +	for_each_present_cpu(cpu) {
> +		struct device *dev = get_cpu_device(cpu);
> +
> +		if (!dev)
> +			return -1;

NAK.  Go figure out why, I'm too lazy to tell you.

> +
> +		ret = sysfs_create_group(&dev->kobj, &cpuregs_attr_group);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +device_initcall(cpuinfo_regs_init);
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
