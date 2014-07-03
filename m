From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 10:54:16 +0200
Subject: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
In-Reply-To: <20140630160727.628e79c3@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
 <20140630160727.628e79c3@free-electrons.com>
Message-ID: <53B51A38.6050406@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

	struct device_node *np;
>> +	const struct of_device_id *match;
>> +
>> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
>> +					&match);
> 
> I'm not sure I like using of_find_matching_node_and_match() on the
> entire tree to find the root node compatible string. Wouldn't it be
> simpler and shorter to just do:
> 
> 	if (of_machine_is_compatible("marvell,armadaxp"))
> 		ret = armadaxp_cpuidle_init();
> 	else if (of_machine_is_compatible("marvell,armada370"))
> 		ret = armada370_cpuidle_init();
> 	else if (of_machine_is_compaitble("marvell,armada380"))
> 		ret = armada38x_cpuidle_init();
> 
> 	if (ret)
> 		return ret;

Indeed, as I don't use any resource from the device tree here, using
of_find_matching_node_and_match is overkill. And your alternative
will be enough.

> 
> Also, using a boolean to return a success/error status is not the
> kernel way of doing things, you should use an int instead and use
> proper error codes or return 0 on success.

OK


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
