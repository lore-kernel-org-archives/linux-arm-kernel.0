From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Feb 2015 08:28:21 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150213155208.GG10496@leverpostej>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org> <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
 <20150213155208.GG10496@leverpostej>
Message-ID: <54DE2625.8080200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/15 07:52, Mark Rutland wrote:
> @@ -194,10 +195,6 @@ int __cpu_disable(void)
>  	unsigned int cpu = smp_processor_id();
>  	int ret;
>  
> -	ret = platform_cpu_disable(cpu);
> -	if (ret)
> -		return ret;
> For PSCI 0.2+ I was hoping to hook the MIGRATE logic in here. The secure
> side may reject hotplugging of a CPU, but it's a dynamic property of the
> system and so can't be probed once at boot time.
>
> I guess when I manage to get around to that I can restore a hook here.
>

Yeah I noticed a comment to that effect in the mcpm_cpu_disable() code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
